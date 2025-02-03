import 'package:dither_it/dither_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart';

void main() {
  group('DitherIt', () {
    test('floydSteinberg applies dithering correctly', () {
      final Image image = Image(height: 2, width: 2)
        ..setPixelRgb(0, 0, 128, 128, 128) // Mid-gray
        ..setPixelRgb(1, 0, 130, 130, 130) // Slightly lighter
        ..setPixelRgb(0, 1, 127, 127, 127) // Slightly darker
        ..setPixelRgb(1, 1, 64, 192, 64); // Mixed mid-tones

      final Image ditheredImage = DitherIt.floydSteinberg(image: image);

      expect(ditheredImage.width, equals(2));
      expect(ditheredImage.height, equals(2));

      for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 2; x++) {
          expect(ditheredImage.getPixel(x, y) != image.getPixel(x, y), isTrue, reason: 'Pixel at ($x,$y) should be modified');
        }
      }
    });

    test('floydSteinberg handles edge pixels correctly', () {
      final Image image = Image(height: 1, width: 1);
      image.setPixelRgb(0, 0, 128, 128, 128); // Gray

      final Image ditheredImage = DitherIt.floydSteinberg(image: image);
      final Pixel p = ditheredImage.getPixel(0, 0);

      expect(p.r, anyOf(0, 255));
      expect(p.g, anyOf(0, 255));
      expect(p.b, anyOf(0, 255));

      expect(ditheredImage.width, equals(1));
      expect(ditheredImage.height, equals(1));
      expect(ditheredImage.getPixel(0, 0) != image.getPixel(0, 0), isTrue);
    });

    test('ordered dithering applies dithering correctly with matrix size 2', () {
      final Image image = Image(height: 2, width: 2)
        ..setPixelRgb(0, 0, 128, 128, 128)
        ..setPixelRgb(1, 0, 130, 130, 130)
        ..setPixelRgb(0, 1, 127, 127, 127)
        ..setPixelRgb(1, 1, 64, 192, 64);

      final Image ditheredImage = DitherIt.ordered(image: image, matrixSize: 2);

      expect(ditheredImage.width, equals(2));
      expect(ditheredImage.height, equals(2));

      for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 2; x++) {
          expect(ditheredImage.getPixel(x, y) != image.getPixel(x, y), isTrue, reason: 'Pixel at ($x,$y) should be modified');
        }
      }
    });

    test('ordered dithering throws ArgumentError for invalid matrix size', () {
      final Image image = Image(height: 2, width: 2);

      expect(() => DitherIt.ordered(image: image, matrixSize: 3), throwsArgumentError);
      expect(() => DitherIt.ordered(image: image, matrixSize: 9), throwsArgumentError);
    });

    test('ordered dithering handles edge pixels correctly', () {
      final Image image = Image(height: 1, width: 1);
      image.setPixelRgb(0, 0, 128, 128, 128); // Gray

      final Image ditheredImage = DitherIt.ordered(image: image, matrixSize: 2);
      final Pixel p = ditheredImage.getPixel(0, 0);

      expect(p.r, anyOf(0, 255));
      expect(p.g, anyOf(0, 255));
      expect(p.b, anyOf(0, 255));

      expect(ditheredImage.width, equals(1));
      expect(ditheredImage.height, equals(1));
      expect(ditheredImage.getPixel(0, 0) != image.getPixel(0, 0), isTrue);
    });

    test('riemersma applies dithering correctly', () {
      final Image image = Image(height: 2, width: 2)
        ..setPixelRgb(0, 0, 128, 128, 128)
        ..setPixelRgb(1, 0, 130, 130, 130)
        ..setPixelRgb(0, 1, 127, 127, 127)
        ..setPixelRgb(1, 1, 64, 192, 64);

      final Image ditheredImage = DitherIt.riemersma(image: image);

      expect(ditheredImage.width, equals(2));
      expect(ditheredImage.height, equals(2));

      for (int y = 0; y < 2; y++) {
        for (int x = 0; x < 2; x++) {
          expect(ditheredImage.getPixel(x, y) != image.getPixel(x, y), isTrue, reason: 'Pixel at ($x,$y) should be modified');
        }
      }
    });
  });
}
