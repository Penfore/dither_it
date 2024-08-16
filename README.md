# DitherIt

DitherIt is a Dart library that implements dithering algorithms for image processing. The library currently supports Floyd-Steinberg and Ordered dithering algorithms, allowing you to apply these dithering techniques to images to reduce the number of colors used while maintaining visual quality.

## Features

- Floyd-Steinberg Dithering: Applies the Floyd-Steinberg dithering algorithm to an image. This well-known dithering method propagates the quantization error to neighboring pixels, enhancing the visual quality of images with reduced colors.

- Ordered Dithering: Applies the Ordered dithering (or Bayer matrix dithering) algorithm to an image. This algorithm uses a predefined threshold matrix to determine which pixels should be adjusted, providing a regular and repetitive dithering pattern.

## Installation

Add `dither_it` to your `pubspec.yaml` via git (it will be avaiable on pub.dev in the future):

```yaml
dependencies:
  dither_it:
    git:
      url: https://github.com/Penfore/dither_it.git
      ref: main
```

Then run flutter pub get or dart pub get to install the package.

### Example
```dart
void main() {
  // Load or create an image
  final Image image = decodeImage(File('{path}/test.png').readAsBytesSync())!;

  // Apply Floyd-Steinberg dithering
  final Image ditheredImage = DitherIt.floydSteinberg(image: image);

  // Apply Ordered dithering with different Bayer matrix sizes
  final Image orderedDitheredImage = DitherIt.ordered(image: image, matrixSize: 2);
  final Image ordered4DitheredImage = DitherIt.ordered(image: image, matrixSize: 4);
  final Image ordered8DitheredImage = DitherIt.ordered(image: image, matrixSize: 8);

  // Save the dithered image
  File('{path}/floyd_steinberg_dithered_image.png').writeAsBytesSync(encodePng(floydSteinbergDitheredImage));
  File('{path}/ordered_dithered_image.png').writeAsBytesSync(encodePng(orderedDitheredImage));
  File('{path}/ordered4_dithered_image.png').writeAsBytesSync(encodePng(ordered4DitheredImage));
  File('{path}/ordered8_dithered_image.png').writeAsBytesSync(encodePng(ordered8DitheredImage));
}
  ```
