# DitherIt

DitherIt is a Dart library that implements various dithering algorithms. The library currently supports the Floyd-Steinberg dithering algorithm, which can be used to apply dithering to images, reducing the number of colors while maintaining visual quality.

## Features

- Applies the Floyd-Steinberg dithering algorithm to images.

## Installation

Add `dither_it` to your `pubspec.yaml`:

```yaml
dependencies:
  dither_it:
```

Then run flutter pub get or dart pub get to install the package.

### Example
```dart
void main() {
  // Load or create an image
  final Image image = decodeImage(File('{path}/test.png').readAsBytesSync())!;

  // Apply Floyd-Steinberg dithering
  final Image ditheredImage = DitherIt.floydSteinberg(image: image);

  // Save the dithered image
  File('{path}/dithered_image.png').writeAsBytesSync(encodePng(ditheredImage));
}
  ```
