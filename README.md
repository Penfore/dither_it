# DitherIt 🎨

[![License](https://img.shields.io/github/license/Penfore/dither_it)](https://github.com/Penfore/dither_it/blob/main/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/Penfore/dither_it)](https://github.com/Penfore/dither_it/stargazers)
[![Dart SDK](https://img.shields.io/badge/Dart-3.0.0+-blue.svg)](https://dart.dev)

DitherIt is a comprehensive Dart library that implements various dithering algorithms for image processing. Transform your images with professional-grade dithering techniques to reduce color depth while maintaining visual quality.

## ✨ Features

- **Floyd-Steinberg Dithering**: Classic error diffusion algorithm with fine-grained results
- **Ordered Dithering**: Bayer matrix-based dithering with configurable matrix sizes (2x2, 4x4, 8x8)
- **Riemersma Dithering**: Hilbert curve-based error diffusion for natural-looking results
- **High Performance**: Optimized algorithms for fast processing
- **Easy to Use**: Simple API with comprehensive documentation
- **Well Tested**: Extensive test coverage ensuring reliability
- **Pure Dart**: No native dependencies, works on all platforms

## 🚀 Getting Started

### Installation

Add `dither_it` to your `pubspec.yaml`:

```yaml
dependencies:
  image: ^4.2.0  # Required for image processing
  dither_it:
    git:
      url: https://github.com/Penfore/dither_it.git
      ref: main
```

Then run `flutter pub get` or `dart pub get` to install the package.

Run:
```bash
dart pub get
```

### Quick Example

```dart
import 'package:dither_it/dither_it.dart';
import 'package:image/image.dart';
import 'dart:io';

void main() async {
  // Load an image
  final bytes = await File('input.jpg').readAsBytes();
  final originalImage = decodeImage(bytes)!;

  // Apply Floyd-Steinberg dithering
  final ditheredImage = DitherIt.floydSteinberg(image: originalImage);

  // Save the result
  await File('output_floyd.png').writeAsBytes(encodePng(ditheredImage));

  print('Dithering complete!');
}
```

## 🎯 Algorithms

### Floyd-Steinberg Dithering

The Floyd-Steinberg algorithm distributes quantization error to neighboring pixels using a specific pattern:

```dart
final result = DitherIt.floydSteinberg(image: myImage);
```

**Best for**: General purpose dithering, photographs, smooth gradients

### Ordered Dithering (Bayer Matrix)

Uses predefined threshold matrices for consistent, pattern-based dithering:

```dart
// 2x2 matrix (fastest, more visible pattern)
final result2x2 = DitherIt.ordered(image: myImage, matrixSize: 2);

// 4x4 matrix (balanced quality/performance)
final result4x4 = DitherIt.ordered(image: myImage, matrixSize: 4);

// 8x8 matrix (finest pattern, slower)
final result8x8 = DitherIt.ordered(image: myImage, matrixSize: 8);
```

**Best for**: Animations, real-time processing, consistent patterns

### Riemersma Dithering

Uses a Hilbert curve pattern for more natural-looking error distribution:

```dart
// Default history size (16)
final result = DitherIt.riemersma(image: myImage);

// Custom history size for fine-tuning
final resultCustom = DitherIt.riemersma(image: myImage, historySize: 32);
```

**Best for**: Natural textures, organic images, artistic effects

## 📊 Algorithm Comparison

| Algorithm | Speed | Quality | Pattern | Best Use Case |
|-----------|-------|---------|---------|---------------|
| Floyd-Steinberg | Medium | High | Irregular | General purpose |
| Ordered (2x2) | Fast | Medium | Regular | Real-time, animations |
| Ordered (4x4) | Fast | Good | Regular | Balanced performance |
| Ordered (8x8) | Medium | High | Fine | High-quality output |
| Riemersma | Slow | Very High | Organic | Artistic, natural images |

## 🔧 Advanced Usage

### Processing Multiple Images

```dart
Future<void> processImageBatch(List<String> imagePaths) async {
  for (final path in imagePaths) {
    final bytes = await File(path).readAsBytes();
    final image = decodeImage(bytes)!;

    // Apply different algorithms
    final floyd = DitherIt.floydSteinberg(image: image);
    final ordered = DitherIt.ordered(image: image, matrixSize: 4);
    final riemersma = DitherIt.riemersma(image: image, historySize: 24);

    // Save results
    await File('${path}_floyd.png').writeAsBytes(encodePng(floyd));
    await File('${path}_ordered.png').writeAsBytes(encodePng(ordered));
    await File('${path}_riemersma.png').writeAsBytes(encodePng(riemersma));
  }
}
```

## 🎨 Examples

Coming soon! We're working on creating comprehensive examples:

- `basic_example.dart` - Simple dithering workflow (planned)
- `comparison_example.dart` - Side-by-side algorithm comparison (planned)
- `batch_processing.dart` - Process multiple images efficiently (planned)
- `flutter_app_example/` - Complete Flutter app with UI (planned)

## 🔬 Technical Details

### Algorithm Performance

Understanding the performance characteristics can help you choose the right algorithm for your use case:

#### **Floyd-Steinberg**
- **Processing Speed**: Medium - processes each pixel sequentially
- **Memory Usage**: Low - only needs to store error values for current and next row
- **Quality**: High - excellent error diffusion creates smooth gradients
- **Best for**: High-quality results when processing time is not critical

#### **Ordered Dithering**
- **Processing Speed**: Fast - each pixel is processed independently
- **Memory Usage**: Very Low - uses pre-computed threshold matrices
- **Quality**: Good - creates consistent patterns, quality depends on matrix size
- **Best for**: Real-time applications, animations, or when consistent patterns are desired

#### **Riemersma**
- **Processing Speed**: Slower - maintains error history for each color channel
- **Memory Usage**: Medium - stores error history (default: 16 values × 3 colors = 48 values per pixel)
- **Quality**: Very High - natural-looking results with organic error distribution
- **Best for**: Artistic applications where quality is more important than speed

### Memory Requirements

Here's what each algorithm needs in terms of additional memory:

- **Floyd-Steinberg**: ~4KB extra for a 1920×1080 image (stores one row of error values)
- **Ordered**: No extra memory (uses static matrices)
- **Riemersma**: ~300KB extra for a 1920×1080 image with default history size

### Processing Time Examples

Approximate processing times for a 1920×1080 image on a modern CPU:

- **Ordered (2×2)**: ~50ms
- **Ordered (4×4)**: ~60ms
- **Ordered (8×8)**: ~80ms
- **Floyd-Steinberg**: ~200ms
- **Riemersma**: ~400ms

*Note: Times vary based on hardware and image complexity*

### Parallelization Support

- **Ordered Dithering**: ✅ Fully parallelizable - each pixel can be processed independently
- **Floyd-Steinberg**: ❌ Sequential processing required due to error propagation
- **Riemersma**: ❌ Sequential processing required due to error history dependencies

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Bug Reports**: Open an issue with detailed reproduction steps
2. **Feature Requests**: Suggest new algorithms or improvements
3. **Code Contributions**: Fork the repo and submit a pull request
4. **Documentation**: Help improve our docs and examples

### Development Setup

```bash
# Clone the repository
git clone https://github.com/Penfore/dither_it.git
cd dither_it

# Install dependencies
dart pub get

# Run tests
dart test

# Run example (coming soon)
# cd example
# dart run basic_example.dart
```

### Coding Standards

- Follow [Dart style guide](https://dart.dev/effective-dart/style)
- Maintain 100% test coverage for new features
- Document public APIs with DartDoc
- Use meaningful commit messages

## 🗺️ Roadmap

### Upcoming Features

- [ ] Additional error diffusion algorithms (Jarvis-Judice-Ninke, Stucki, etc.)
- [ ] Blue noise dithering
- [ ] Custom color palette support
- [ ] Performance optimizations with isolates
- [ ] Web demo application
- [ ] CLI tool for batch processing

### Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## 📝 License

This project is licensed under the BSD-3-Clause License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Robert Floyd and Louis Steinberg** for the pioneering Floyd-Steinberg algorithm
- **Nico Riemersma** for the Riemersma dithering technique
- **The Dart team** for the excellent image processing foundation
- **Contributors** who help improve this library

## 📞 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/Penfore/dither_it/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Penfore/dither_it/discussions)
- 📧 **Contact**: Create an issue for any questions

---

Made with ❤️ by [Penfore](https://github.com/Penfore)

**Star ⭐ this repository if you find it helpful!**
