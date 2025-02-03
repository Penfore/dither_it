library dither_it;

import 'dart:math';

import 'package:image/image.dart';

part 'bayer_matrices.dart';

/// A library that implements various dithering algorithms.
class DitherIt {
  /// Applies the Floyd-Steinberg dithering algorithm to the provided image.
  /// https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering
  ///
  /// [image]: The input image to be dithered.
  ///
  /// Returns the dithered image.
  static Image floydSteinberg({required Image image}) {
    final Image newImage = Image.from(image);

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final Pixel currentPixel = newImage.getPixel(x, y);
        final int currentRed = currentPixel.r.toInt();
        final int currentGreen = currentPixel.g.toInt();
        final int currentBlue = currentPixel.b.toInt();

        // Find closest palette
        final int newRed = _findClosestColor(currentRed);
        final int newGreen = _findClosestColor(currentGreen);
        final int newBlue = _findClosestColor(currentBlue);
        newImage.setPixelRgb(x, y, newRed, newGreen, newBlue);

        // Quantization error
        final int errorR = currentRed - newRed;
        final int errorG = currentGreen - newGreen;
        final int errorB = currentBlue - newBlue;

        // Spread the quantization error
        _spreadError(newImage, x + 1, y, errorR, errorG, errorB, 7 / 16.0);
        _spreadError(newImage, x - 1, y + 1, errorR, errorG, errorB, 3 / 16.0);
        _spreadError(newImage, x, y + 1, errorR, errorG, errorB, 5 / 16.0);
        _spreadError(newImage, x + 1, y + 1, errorR, errorG, errorB, 1 / 16.0);
      }
    }

    return newImage;
  }

  /// Finds the closest color value for dithering.
  ///
  /// [value]: The color value to be quantized.
  ///
  /// Returns the closest color value.
  static int _findClosestColor(int value) {
    return (value > 128) ? 255 : 0;
  }

  /// Spreads the quantization error to the specified pixel.
  ///
  /// [image]: The image being processed.
  /// [x]: The x-coordinate of the pixel to spread the error to.
  /// [y]: The y-coordinate of the pixel to spread the error to.
  /// [errorR]: The red component of the quantization error.
  /// [errorG]: The green component of the quantization error.
  /// [errorB]: The blue component of the quantization error.
  /// [factor]: The factor by which to scale the error.
  static void _spreadError(Image image, int x, int y, int errorR, int errorG, int errorB, double factor) {
    if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
      final Pixel pixel = image.getPixel(x, y);
      final int newR = _clamp(pixel.r.toInt() + (errorR * factor).round());
      final int newG = _clamp(pixel.g.toInt() + (errorG * factor).round());
      final int newB = _clamp(pixel.b.toInt() + (errorB * factor).round());
      image.setPixelRgb(x, y, newR, newG, newB);
    }
  }

  /// Clamps the given [value] to be within the range [0, 255].
  ///
  /// [value]: The value to clamp.
  ///
  /// Returns the clamped value.
  static int _clamp(int value) {
    return value.clamp(0, 255);
  }

  static const int _maxMatrixSize = 8;

  /// Applies the Ordered Dithering algorithm to the provided image.
  /// https://en.wikipedia.org/wiki/Ordered_dithering
  ///
  /// [image]: The input image to be dithered.
  ///
  /// [matrixSize]: The size of the Bayer matrix to use for dithering. Must be a power of 2, greater than or equal to 2, and less than or equal to 8.
  ///
  /// Returns the dithered image.
  ///
  /// Throws an [ArgumentError] if the matrix size exceeds the maximum allowed size of 8.
  static Image ordered({required Image image, required int matrixSize}) {
    if (matrixSize < 2 || (matrixSize & (matrixSize - 1)) != 0) {
      throw ArgumentError('The size must be a power of 2 and greater than or equal to 2.');
    }
    if (matrixSize > _maxMatrixSize) {
      throw ArgumentError('Matrix size exceeds the maximum allowed size of $_maxMatrixSize.');
    }

    final Image newImage = Image.from(image);
    final List<List<double>> thresholdMap = _precomputedBayerMatrices[matrixSize]!;
    final int mapSize = matrixSize;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final Pixel currentPixel = newImage.getPixel(x, y);
        final int thresholdX = x % mapSize;
        final int thresholdY = y % mapSize;
        final double threshold = thresholdMap[thresholdY][thresholdX];

        final int currentRed = currentPixel.r.toInt();
        final int currentGreen = currentPixel.g.toInt();
        final int currentBlue = currentPixel.b.toInt();

        final double normalizedRed = (currentRed / 255.0) + (threshold - 0.5);
        final double normalizedGreen = (currentGreen / 255.0) + (threshold - 0.5);
        final double normalizedBlue = (currentBlue / 255.0) + (threshold - 0.5);

        final int newRed = _findClosestColor((normalizedRed * 255).round());
        final int newGreen = _findClosestColor((normalizedGreen * 255).round());
        final int newBlue = _findClosestColor((normalizedBlue * 255).round());

        newImage.setPixelRgb(x, y, newRed, newGreen, newBlue);
      }
    }

    return newImage;
  }

  /// Applies the Riemersma dithering algorithm to the provided image.
  /// https://www.compuphase.com/riemer.htm
  ///
  /// This dithering algorithm uses a Hilbert curve pattern to distribute
  /// quantization errors across subsequent pixels, providing a more
  /// natural-looking error diffusion compared to matrix-based approaches.
  ///
  /// [image]: The input image to be dithered.
  /// [historySize]: The number of previous errors to consider (typical 16-32).
  ///                Default is 16.
  ///
  /// Returns the dithered image.
  static Image riemersma({required Image image, int historySize = 16}) {
    final Image newImage = Image.from(image);

    final List<double> redErrors = [];
    final List<double> greenErrors = [];
    final List<double> blueErrors = [];

    for (int y = 0; y < newImage.height; y++) {
      for (int x = 0; x < newImage.width; x++) {
        final Pixel pixel = newImage.getPixel(x, y);

        final int origRed = pixel.r.toInt();
        final int origGreen = pixel.g.toInt();
        final int origBlue = pixel.b.toInt();

        final double redError = _calculateChannelError(origRed, redErrors, historySize);
        final int newRed = _findClosestColor((origRed + redError).round());

        final double greenError = _calculateChannelError(origGreen, greenErrors, historySize);
        final int newGreen = _findClosestColor((origGreen + greenError).round());

        final double blueError = _calculateChannelError(origBlue, blueErrors, historySize);
        final int newBlue = _findClosestColor((origBlue + blueError).round());

        newImage.setPixelRgb(x, y, newRed, newGreen, newBlue);
        _updateErrorHistory(redErrors, origRed - newRed + redError, historySize);
        _updateErrorHistory(greenErrors, origGreen - newGreen + greenError, historySize);
        _updateErrorHistory(blueErrors, origBlue - newBlue + blueError, historySize);
      }
    }

    return newImage;
  }

  /// Calculates the weighted error contribution for a single color channel
  /// using an exponential decay of historical errors.
  ///
  /// [value]: Original color channel value (0-255)
  /// [errors]: List of previous quantization errors for this channel
  /// [historySize]: Maximum number of historical errors to consider
  ///
  /// Returns the calculated error contribution to apply to the current pixel,
  /// with weights following the pattern 1/2, 1/4, 1/8... based on error age.
  static double _calculateChannelError(int value, List<double> errors, int historySize) {
    if (errors.isEmpty) return 0;

    double weightSum = 0;
    double errorSum = 0;

    for (int i = 0; i < errors.length; i++) {
      final double weight = pow(2, -(historySize - i)).toDouble();
      weightSum += weight;
      errorSum += errors[i] * weight;
    }

    return errorSum / weightSum;
  }

  /// Maintains a fixed-size error history queue using FIFO (first-in, first-out)
  /// methodology. Adds new error to the end of the list and removes the oldest
  /// error if the history exceeds the specified size.
  ///
  /// [errors]: Error history list to modify
  /// [error]: New error value to add to the history
  /// [historySize]: Maximum number of errors to retain in the history
  static void _updateErrorHistory(List<double> errors, double error, int historySize) {
    errors.add(error);
    if (errors.length > historySize) {
      errors.removeAt(0);
    }
  }
}
