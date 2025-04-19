import 'package:flutter_svg/svg.dart';

Future<void> precacheSvg({required String assetPath}) async {
  final loader = SvgAssetLoader(assetPath);
  await svg.cache
      .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
}
