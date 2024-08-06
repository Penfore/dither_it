library dither_it;

import 'package:image/image.dart';

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
}
