# Contributing to DitherIt 🎨

Thank you for your interest in contributing to DitherIt! We welcome contributions from everyone, whether you're fixing bugs, adding features, improving documentation, or suggesting enhancements.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Commit Messages](#commit-messages)
- [Issue Guidelines](#issue-guidelines)
- [Algorithm Implementation](#algorithm-implementation)

## 🤝 Code of Conduct

This project follows a Code of Conduct to ensure a welcoming environment for all contributors. Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## 🚀 Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dither_it.git
   cd dither_it
   ```
3. **Add the original repository as upstream**:
   ```bash
   git remote add upstream https://github.com/Penfore/dither_it.git
   ```

## 🛠️ Development Setup

### Prerequisites
- Dart SDK >= 3.0.0
- Git

### Setup Steps
1. Install dependencies:
   ```bash
   dart pub get
   ```

2. Run tests to ensure everything works:
   ```bash
   dart test
   ```

3. Verify the library works (examples coming soon):
   ```bash
   # Examples will be available in future releases
   # dart run example/basic_example.dart
   ```

## 🤖 How to Contribute

### Types of Contributions

1. **🐛 Bug Fixes**
   - Find and fix bugs in existing algorithms
   - Improve error handling
   - Fix edge cases

2. **✨ New Features**
   - Implement new dithering algorithms
   - Add utility functions
   - Improve performance

3. **📚 Documentation**
   - Improve API documentation
   - Add or improve examples
   - Write tutorials

4. **🧪 Testing**
   - Add test cases
   - Improve test coverage
   - Add benchmark tests

5. **🎨 Examples**
   - Create new example applications
   - Improve existing examples

## 📝 Pull Request Process

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes** following our coding standards

3. **Add or update tests** for your changes

4. **Update documentation** if needed

5. **Run the test suite**:
   ```bash
   dart test
   dart analyze
   dart format --set-exit-if-changed .
   ```

6. **Commit your changes** with descriptive commit messages

7. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Create a Pull Request** on GitHub with:
   - Clear description of changes
   - Reference to related issues
   - Screenshots or examples if applicable

### Pull Request Checklist
- [ ] Code follows project style guidelines
- [ ] Tests pass locally
- [ ] New code has appropriate test coverage
- [ ] Documentation is updated
- [ ] Commit messages are descriptive
- [ ] No merge conflicts with main branch

## 🎯 Coding Standards

### Dart Style
- Follow the [official Dart style guide](https://dart.dev/effective-dart/style)
- Use `dart format` to automatically format code
- Run `dart analyze` to check for issues

### Code Quality
- **Functions should be small and focused** (ideally < 20 lines)
- **Use descriptive variable and function names**
- **Add DartDoc comments** for public APIs
- **Handle edge cases** appropriately
- **Avoid code duplication**

### Example of Good Code Style:
```dart
/// Applies the Floyd-Steinberg dithering algorithm to the provided image.
///
/// This algorithm distributes quantization error to neighboring pixels
/// using the following error diffusion pattern:
/// ```
///      X   7/16
/// 3/16 5/16 1/16
/// ```
///
/// [image]: The input image to be dithered.
///
/// Returns the dithered image with reduced color depth.
///
/// Throws [ArgumentError] if the image is null or empty.
static Image floydSteinberg({required Image image}) {
  ArgumentError.checkNotNull(image, 'image');

  if (image.width == 0 || image.height == 0) {
    throw ArgumentError('Image must have non-zero dimensions');
  }

  // Implementation details...
}
```

## 🧪 Testing

### Test Requirements
- **100% test coverage** for new features
- **Edge case testing** (empty images, single pixel, etc.)
- **Performance regression tests** for algorithms
- **Integration tests** for complete workflows

### Running Tests
```bash
# Run all tests
dart test

# Run tests with coverage
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib

# Run specific test file
dart test test/dither_it_test.dart
```

### Writing Tests
```dart
group('FloydSteinberg', () {
  test('should handle single pixel image', () {
    final image = Image(width: 1, height: 1);
    image.setPixelRgb(0, 0, 128, 128, 128);

    final result = DitherIt.floydSteinberg(image: image);

    expect(result.width, equals(1));
    expect(result.height, equals(1));
    // Additional assertions...
  });

  test('should throw on null image', () {
    expect(
      () => DitherIt.floydSteinberg(image: null),
      throwsA(isA<ArgumentError>()),
    );
  });
});
```

## 📖 Documentation

### API Documentation
- Use **DartDoc comments** (`///`) for all public APIs
- Include **parameter descriptions**
- Provide **usage examples**
- Document **exceptions** that can be thrown

### README Updates
- Update feature lists when adding new algorithms
- Add examples for new functionality
- Update performance comparisons

### Example Documentation
```dart
/// Applies ordered dithering using a Bayer matrix of the specified size.
///
/// Ordered dithering uses a threshold matrix to determine which pixels
/// should be quantized to which values, creating a regular pattern.
///
/// Example usage:
/// ```dart
/// final image = decodeImage(imageBytes)!;
/// final dithered = DitherIt.ordered(image: image, matrixSize: 4);
/// ```
///
/// [image]: The input image to process
/// [matrixSize]: Size of the Bayer matrix (must be 2, 4, or 8)
///
/// Returns a new image with ordered dithering applied.
///
/// Throws [ArgumentError] if matrixSize is not supported.
static Image ordered({required Image image, required int matrixSize}) {
  // Implementation...
}
```

## 💬 Commit Messages

Use the [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Adding or modifying tests
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `chore`: Maintenance tasks

### Examples:
```bash
feat(algorithms): add Jarvis-Judice-Ninke dithering algorithm

Implements the JJN error diffusion algorithm with 12-pixel
error distribution pattern for higher quality results.

Closes #15

fix(floyd-steinberg): handle edge pixels correctly

Previously, the algorithm could access pixels outside image
boundaries when processing edge pixels. Added boundary checks.

docs(readme): add performance comparison table

Added detailed comparison of algorithm performance characteristics
to help users choose the right algorithm for their needs.
```

## 🐛 Issue Guidelines

### Bug Reports
When reporting bugs, please include:
- **Clear description** of the issue
- **Steps to reproduce** the problem
- **Expected vs actual behavior**
- **Dart version** and platform
- **Sample code** or images if applicable

### Feature Requests
For new features, please provide:
- **Clear description** of the desired functionality
- **Use case** and motivation
- **Proposed API** if applicable
- **References** to algorithms or papers

### Issue Templates
```markdown
**Bug Report**
- Dart version:
- Platform:
- Library version:

**Description:**
A clear description of the bug.

**Steps to Reproduce:**
1. Step one
2. Step two
3. Step three

**Expected Behavior:**
What should happen.

**Actual Behavior:**
What actually happens.

**Code Sample:**
```dart
// Minimal code to reproduce the issue
```
```

## 🧮 Algorithm Implementation

### Adding New Dithering Algorithms

When implementing new algorithms, follow this checklist:

1. **Research the algorithm** thoroughly
   - Understand the mathematical foundation
   - Find reference implementations
   - Study performance characteristics

2. **Create the implementation**
   - Add to `DitherIt` class
   - Follow existing naming patterns
   - Include comprehensive documentation

3. **Add comprehensive tests**
   - Unit tests for the algorithm
   - Edge case testing
   - Performance benchmarks

4. **Update documentation**
   - Add to README algorithm list
   - Update comparison tables
   - Create usage examples

### Algorithm Implementation Template:
```dart
/// Applies the [AlgorithmName] dithering algorithm to the provided image.
///
/// [Brief description of how the algorithm works and its characteristics]
///
/// Reference: [Link to paper or documentation]
///
/// [image]: The input image to be dithered.
/// [parameter]: Description of any algorithm-specific parameters.
///
/// Returns the dithered image.
///
/// Throws [ArgumentError] if parameters are invalid.
static Image algorithmName({
  required Image image,
  int parameter = defaultValue,
}) {
  // Validate inputs
  ArgumentError.checkNotNull(image, 'image');
  if (parameter < minValue || parameter > maxValue) {
    throw ArgumentError('parameter must be between $minValue and $maxValue');
  }

  // Implementation
  final Image result = Image.from(image);

  // Algorithm logic here...

  return result;
}
```

## 🏆 Recognition

Contributors are recognized in our README and release notes. Significant contributions may be highlighted in blog posts or social media.

## ❓ Questions?

If you have questions about contributing, feel free to:
- Open a [GitHub Discussion](https://github.com/Penfore/dither_it/discussions)
- Create an issue with the "question" label
- Reach out to maintainers

## 🙏 Thank You!

Every contribution, no matter how small, helps make DitherIt better. Thank you for taking the time to contribute!

---

Happy coding! 🎨✨
