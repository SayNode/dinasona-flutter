import 'package:flutter/material.dart';

class NetworkImageHandler extends StatelessWidget {
  const NetworkImageHandler({
    required this.url,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? height;
  final double? width;
  final BoxFit fit;

  bool _isValidUrl(String url) {
    // ignore: use_if_null_to_convert_nulls_to_bools
    return Uri.tryParse(url)?.hasAbsolutePath == true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isValidUrl(url)) {
      return Image.asset(
        'assets/images/image_unavailable.png',
        height: height,
        width: width,
        fit: fit,
      );
    }

    return Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return Image.asset(
          'assets/images/image_unavailable.png',
          height: height,
          width: width,
          fit: fit,
        );
      },
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
