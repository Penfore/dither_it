# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- [ ] Jarvis-Judice-Ninke error diffusion algorithm
- [ ] Stucki dithering algorithm
- [ ] Burkes dithering algorithm
- [ ] Sierra family algorithms (Sierra, Two-Row Sierra, Sierra Lite)
- [ ] Atkinson dithering algorithm
- [ ] Blue noise dithering using void-and-cluster method
- [ ] Ostromoukhov's variable error diffusion
- [ ] Gradient-based error diffusion
- [ ] Custom color palette support
- [ ] Performance optimizations with isolates
- [ ] CLI tool for batch processing
- [ ] Web demo application

## [0.0.4] - October 14, 2025

### Added
- **Visual Examples**: Added comprehensive visual comparison section in README
  - Original image showcase
  - Side-by-side algorithm comparison images
  - Example images for Floyd-Steinberg, Ordered, and Riemersma algorithms
- **Documentation Enhancements**:
  - Created detailed CODE_OF_CONDUCT.md following Contributor Covenant 2.1
  - Enhanced CONTRIBUTING.md with complete contribution guidelines
  - Added IMAGE_CREDITS.md with proper attribution for example images
  - Improved Technical Details section in README with practical examples
- **Example Code**:
  - Working example demonstrating all three algorithms
  - Batch processing example code in README
  - Clear usage examples for each algorithm

### Changed
- **License**: Changed from BSD-3-Clause to MIT License for better compatibility
- **README Improvements**:
  - Updated badges to reflect current status
  - Added visual examples section with before/after comparisons
  - Improved algorithm comparison table with practical use cases
  - Enhanced performance characteristics with real-world metrics
  - Added memory usage estimates and processing time examples
  - Clarified parallelization support for each algorithm
- **Package Metadata**:
  - Updated pubspec.yaml with repository and issue tracker links
  - Enhanced package description for better discoverability
  - Added documentation link

### Fixed
- Corrected installation instructions to show git-based installation
- Fixed README formatting and removed duplicate content
- Updated support section with accurate contact information

### Documentation
- Added comprehensive algorithm research notes
- Documented 15+ additional algorithms for future implementation
- Created roadmap with clear feature priorities
- Improved API documentation consistency

## [0.0.3] - February 3, 2025

### Added
- Riemersma dithering algorithm implementation
- Hilbert curve-based error diffusion for natural-looking results
- Configurable history size for Riemersma algorithm
- Comprehensive documentation and examples
- Performance optimizations for all algorithms

### Changed
- Improved API documentation with better examples
- Enhanced test coverage for all algorithms
- Updated README with detailed usage instructions

### Fixed
- Edge case handling in Floyd-Steinberg algorithm
- Memory optimization in error diffusion calculations

## [0.0.2] - Aug, 15, 2024

### Added
- Ordered dithering (Bayer matrix) implementation
- Support for 2x2, 4x4, and 8x8 Bayer matrices
- Configurable matrix sizes for different quality levels
- Comprehensive test suite for ordered dithering

### Changed
- Improved error handling for invalid matrix sizes
- Performance optimizations for matrix-based algorithms

### Fixed
- Boundary checking in ordered dithering algorithm

## [0.0.1] - Aug, 6, 2024

### Added
- Initial release of DitherIt library
- Floyd-Steinberg dithering algorithm implementation
- Basic error diffusion functionality
- Support for RGB image processing
- Comprehensive documentation
- Unit tests for core functionality
- MIT License
- Basic example usage

### Features
- Pure Dart implementation with no native dependencies
- Compatible with the `image` package
- Optimized algorithms for performance
- Well-documented API with DartDoc comments
