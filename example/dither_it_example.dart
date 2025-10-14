import 'dart:io';

import 'package:dither_it/dither_it.dart';
import 'package:image/image.dart';

void main() async {
  // Load an image
  final bytes = await File('example/input.png').readAsBytes();
  final image = decodeImage(bytes)!;

  // Try Floyd-Steinberg dithering
  final floydSteinbergImage = DitherIt.floydSteinberg(image: image);
  await File('example/output_floyd_steinberg.png').writeAsBytes(
    encodePng(floydSteinbergImage),
  );

  // Try Ordered Dithering with 4x4 Bayer matrix
  final orderedImage = DitherIt.ordered(image: image, matrixSize: 4);
  await File('example/output_ordered.png').writeAsBytes(
    encodePng(orderedImage),
  );

  // Try Riemersma Dithering
  final riemersmaImage = DitherIt.riemersma(image: image);
  await File('example/output_riemersma.png').writeAsBytes(
    encodePng(riemersmaImage),
  );

  print('✅ Dithering complete! Check the output files.');
}
