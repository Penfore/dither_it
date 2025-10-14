# Image Credits 📸

This document provides attribution for images used in the DitherIt examples and documentation.

## Example Images

### Small Copper Butterfly

**Image:** Small Copper Butterfly on Purple Flower
**Author:** [Illuvis](https://pixabay.com/users/illuvis-3450147/)
**Source:** [Pixabay](https://pixabay.com/photos/small-copper-butterfly-insect-9830647/)
**License:** [Pixabay Content License](https://pixabay.com/service/license-summary/)

**Description:**
A beautiful macro photograph of a small copper butterfly (Lycaena phlaeas) resting on a purple flower. This image is used in our examples to demonstrate the various dithering algorithms available in the DitherIt library.

**Usage in Project:**
- Example demonstrations in `example/dither_it_example.dart`
- Documentation illustrations in README.md
- Algorithm comparison showcases

**License Summary:**
This image is provided under the Pixabay Content License, which allows:
- ✓ Free use for personal and commercial purposes
- ✓ Use without attribution (though attribution is appreciated)
- ✓ Modification and adaptation into new works

**Attribution (Optional but Appreciated):**
```
Photo by Illuvis on Pixabay
https://pixabay.com/photos/small-copper-butterfly-insect-9830647/
```

---

## About Image Attribution

While the Pixabay Content License does not require attribution, we believe in giving credit to the talented photographers and artists who make their work freely available. We encourage users of DitherIt to also provide attribution when using these example images in their own projects.

## Using Your Own Images

To use your own images with DitherIt:

```dart
import 'dart:io';
import 'package:dither_it/dither_it.dart';
import 'package:image/image.dart';

void main() async {
  // Load your image
  final bytes = await File('path/to/your/image.jpg').readAsBytes();
  final image = decodeImage(bytes)!;

  // Apply dithering
  final dithered = DitherIt.floydSteinberg(image: image);

  // Save the result
  await File('output.png').writeAsBytes(encodePng(dithered));
}
```

## Image Sources

Looking for royalty-free images for your dithering experiments? Here are some recommended sources:

- **[Pixabay](https://pixabay.com/)** - Free images and videos (no attribution required)
- **[Unsplash](https://unsplash.com/)** - Beautiful free images (attribution appreciated)
- **[Pexels](https://www.pexels.com/)** - Free stock photos and videos
- **[Wikimedia Commons](https://commons.wikimedia.org/)** - Free media (check individual licenses)

## Contributing Example Images

If you'd like to contribute example images to the DitherIt project:

1. Ensure you have the rights to the image
2. Use images with permissive licenses (CC0, Public Domain, or similar)
3. Provide proper attribution information
4. Submit a pull request with:
   - The image file
   - Updated credits in this file
   - Example code using the image

---

**Thank you to all photographers and artists who make their work freely available! 🙏**

*Last updated: October 14, 2025*
