import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'app_loading_component.dart';

class CachedImageComponent extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final double borderRadius;
  final double borderWidth;
  final Color? color;
  final BoxFit fit;
  final bool isNetwork;
  final bool shadow;
  final bool isPlaceholder;
  final int? stableKey;

  // Cache SVG widgets to avoid rebuilding them
  static final Map<String, Widget> _svgCache = {};

  // Cache for network image error handlers to avoid rebuilds
  static final Map<String, Widget> _errorWidgetCache = {};

  // Limit cache size to prevent memory issues
  static const int _maxCacheSize = 50;

  // LRU tracking for cache eviction
  static final List<String> _cacheAccessOrder = [];

  // Constants for better performance
  static const Duration _fadeInDuration = Duration(milliseconds: 300);

  // Add a new entry to cache with LRU tracking
  static void _addToCache(
    Map<String, Widget> cache,
    String key,
    Widget widget,
  ) {
    // Enforce cache size limit
    if (cache.length >= _maxCacheSize && !cache.containsKey(key)) {
      // Remove least recently used item
      if (_cacheAccessOrder.isNotEmpty) {
        final leastUsedKey = _cacheAccessOrder.removeAt(0);
        cache.remove(leastUsedKey);
      }
    }

    // Add or update cache
    cache[key] = widget;

    // Update access order
    _cacheAccessOrder.remove(key);
    _cacheAccessOrder.add(key);
  }

  // Get from cache and update LRU tracking
  static Widget? _getFromCache(Map<String, Widget> cache, String key) {
    final widget = cache[key];
    if (widget != null) {
      // Update access order
      _cacheAccessOrder.remove(key);
      _cacheAccessOrder.add(key);
    }
    return widget;
  }

  const CachedImageComponent({
    super.key,
    required this.height,
    required this.width,
    required this.imageUrl,
    this.borderWidth = 0,
    this.borderRadius = 0,
    this.color,
    this.fit = BoxFit.contain,
    this.isNetwork = true,
    this.shadow = false,
    this.isPlaceholder = false,
    this.stableKey,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder:
          (
            BuildContext context,
            CustomColorSet colors,
            FontSet fonts,
            IconSet icons,
            controller,
          ) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color,
                // border: Border.all(width: borderWidth, color: colors.neutral200),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: _buildImage(context, icons),
              ),
            );
          },
    );
  }

  Widget _buildImage(BuildContext context, IconSet icons) {
    // Handle SVG images - with caching for better performance
    if (imageUrl.contains(".svg")) {
      final String cacheKey = '$imageUrl-$height-$width-${color?.value}';

      // Return cached SVG if available
      final cachedSvg = _getFromCache(_svgCache, cacheKey);
      if (cachedSvg != null) {
        return cachedSvg;
      }

      // Create and cache SVG widget
      final svgWidget = SvgPicture.network(
        imageUrl,
        fit: fit,
        height: height,
        width: width,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (context) => !isPlaceholder
            ? const Center(child: AppLoadingComponent())
            : const SizedBox.shrink(),
      );

      _addToCache(_svgCache, cacheKey, svgWidget);
      return svgWidget;
    }

    // Handle local file images
    if (!isNetwork) {
      return Image.file(
        File(imageUrl),
        fit: fit,
        height: height,
        width: width,
        filterQuality: FilterQuality.medium,
        errorBuilder: (context, error, stackTrace) =>
            icons.noProductImage.svg(width: width, height: height),
      );
    }

    // Cache error widget for better performance
    final String errorCacheKey = '${icons.hashCode}-$width-$height';
    if (!_errorWidgetCache.containsKey(errorCacheKey)) {
      final errorWidget = icons.noProductImage.svg(
        width: width,
        height: height,
      );
      _addToCache(_errorWidgetCache, errorCacheKey, errorWidget);
    }

    // Handle network images with improved caching
    return CachedNetworkImage(
      key: ValueKey(stableKey ?? imageUrl),
      imageUrl: imageUrl,
      fit: fit,
      fadeInDuration: _fadeInDuration,
      useOldImageOnUrlChange: true,

      // // Set reasonable cache dimensions to optimize memory usage with safety checks
      // cacheKey: stableKey != null ? '${imageUrl}_$stableKey' : null,
      // maxWidthDiskCache: 1000, // Limit disk cache size
      // maxHeightDiskCache: 1000,
      // Match placeholder color to container
      // placeholder: (context, url) => Container(color: color, child: const Center(child: AppLoadingComponent())),
      errorWidget: (context, _, __) =>
          _getFromCache(_errorWidgetCache, errorCacheKey) ??
          icons.noProductImage.svg(width: width, height: height),
    );
  }
}
