# DitherIt

DitherIt is a Dart library that implements dithering algorithms for image processing. The library currently supports Floyd-Steinberg, Ordered and Riemersma dithering algorithms, allowing you to apply these dithering techniques to images to reduce the number of colors used while maintaining visual quality.

## Features

- Floyd-Steinberg Dithering: Applies the Floyd-Steinberg dithering algorithm to an image. This well-known dithering method propagates the quantization error to neighboring pixels, enhancing the visual quality of images with reduced colors. It is particularly effective for creating smooth gradients and reducing banding artifacts.

- Ordered Dithering: Applies the Ordered dithering (or Bayer matrix dithering) algorithm to an image. This algorithm uses a predefined threshold matrix to determine which pixels should be adjusted, providing a regular and repetitive dithering pattern. It is highly configurable, allowing you to specify the size of the Bayer matrix (2x2, 4x4, or 8x8) for different levels of detail and texture.

- Riemersma Dithering: Applies the Riemersma dithering algorithm to an image. This algorithm uses a Hilbert curve pattern to distribute quantization errors across subsequent pixels, providing a more natural-looking error diffusion compared to matrix-based approaches. It is particularly useful for creating organic and visually pleasing dithering effects, especially in images with complex textures.

## Installation

Add `dither_it` and `image` to your `pubspec.yaml` via git (it will be avaiable on pub.dev in the future):

```yaml
dependencies:
  image:
  dither_it:
    git:
      url: https://github.com/Penfore/dither_it.git
      ref: main
```

Then run flutter pub get or dart pub get to install the package.

## Usage
```dart
import 'dart:io';

import 'package:dither_it/dither_it.dart';
import 'package:image/image.dart';

void main() {
  // Load or create an image
  final Image image = decodeImage(File('{path}/test.png').readAsBytesSync())!;

  // Apply Floyd-Steinberg dithering
  final Image ditheredImage = DitherIt.floydSteinberg(image: image);

  // Apply Ordered dithering with different Bayer matrix sizes
  final Image orderedDitheredImage = DitherIt.ordered(image: image, matrixSize: 2);
  final Image ordered4DitheredImage = DitherIt.ordered(image: image, matrixSize: 4);
  final Image ordered8DitheredImage = DitherIt.ordered(image: image, matrixSize: 8);

  // Apply Riemersma dithering
  final Image riemersmaDitheredImage = DitherIt.riemersma(image: image, historySize: 16);

  // Save the dithered image
  File('{path}/floyd_steinberg_dithered_image.png').writeAsBytesSync(encodePng(floydSteinbergDitheredImage));
  File('{path}/ordered_dithered_image.png').writeAsBytesSync(encodePng(orderedDitheredImage));
  File('{path}/ordered4_dithered_image.png').writeAsBytesSync(encodePng(ordered4DitheredImage));
  File('{path}/ordered8_dithered_image.png').writeAsBytesSync(encodePng(ordered8DitheredImage));
  File('{path}/riemersma_dithered_image.png').writeAsBytesSync(encodePng(riemersmaDitheredImage));
}
  ```

## Choosing the Right Algorithm

- Floyd-Steinberg Dithering: Best for images with smooth gradients and subtle color transitions. It produces high-quality results but may introduce noticeable patterns in areas with sharp edges.

- Ordered Dithering: Ideal for creating retro or pixelated effects. The size of the Bayer matrix determines the level of detail and texture in the output:
    - 2x2 Matrix: Produces a coarse, pixelated effect.
    - 4x4 Matrix: Balances detail and texture.
    - 8x8 Matrix: Provides fine detail with a subtle dithering pattern.

- Riemersma Dithering: Suitable for images with complex textures or organic shapes. It produces a more natural and less repetitive dithering pattern compared to matrix-based methods.

## Performance Considerations

- Floyd-Steinberg Dithering: Computationally intensive due to error diffusion across neighboring pixels. Best suited for smaller images or offline processing.

- Ordered Dithering: Faster than Floyd-Steinberg, as it uses a fixed threshold matrix. Performance is consistent regardless of image size.

- Riemersma Dithering: Moderately fast, with performance depending on the historySize parameter. Larger historySize values increase computation time.
