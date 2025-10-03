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
- [ ] Custom color palette support
- [ ] Performance optimizations with isolates
- [ ] CLI tool for batch processing
- [ ] Web demo application

## [0.0.3] - Feb, 3, 2025

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
