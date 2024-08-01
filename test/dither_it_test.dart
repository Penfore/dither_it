import 'package:dither_it/dither_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart';

void main() {
  group('DitherIt', () {
    test('floydSteinberg applies dithering correctly', () {
      final Image image = Image(height: 2, width: 2);
      image.setPixelRgb(0, 0, 255, 0, 0); // Red
      image.setPixelRgb(1, 0, 0, 255, 0); // Green
      image.setPixelRgb(0, 1, 0, 0, 255); // Blue
      image.setPixelRgb(1, 1, 255, 255, 0); // Yellow

      final Image ditheredImage = DitherIt.floydSteinberg(image: image);

      expect(ditheredImage.width, equals(2));
      expect(ditheredImage.height, equals(2));
      expect(ditheredImage.getPixel(0, 0) != image.getPixel(0, 0), isTrue);
      expect(ditheredImage.getPixel(1, 0) != image.getPixel(1, 0), isTrue);
      expect(ditheredImage.getPixel(0, 1) != image.getPixel(0, 1), isTrue);
      expect(ditheredImage.getPixel(1, 1) != image.getPixel(1, 1), isTrue);
    });
  });
}
