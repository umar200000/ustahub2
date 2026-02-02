// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class CacheManagerService {
//   static final CacheManagerService _instance = CacheManagerService._internal();
//   factory CacheManagerService() => _instance;
//   CacheManagerService._internal();

//   /// Clears the app's image cache and returns the size cleared in MB
//   Future<double> clearImageCache() async {
//     try {
//       double totalCleared = 0;

//       // Clear the Flutter image cache in memory
//       PaintingBinding.instance.imageCache.clear();
//       PaintingBinding.instance.imageCache.clearLiveImages();

//       // Clear cached network images
//       final cache = DefaultCacheManager();
//       await cache.emptyCache();

//       // Clear cache directory
//       final cacheDir = await getTemporaryDirectory();
//       if (await cacheDir.exists()) {
//         final cacheFiles = cacheDir.listSync(recursive: true);
//         for (var file in cacheFiles) {
//           if (file is File) {
//             if (_isImageFile(file.path)) {
//               final size = await file.length();
//               totalCleared += size / (1024 * 1024); // Convert to MB
//               await file.delete();
//             }
//           }
//         }
//       }

//       debugPrint('Cache cleared: ${totalCleared.toStringAsFixed(2)} MB');
//       return totalCleared;
//     } catch (e) {
//       debugPrint('Error clearing cache: $e');
//       return 0;
//     }
//   }

//   /// Get the current cache size in MB
//   Future<double> getCacheSize() async {
//     try {
//       double totalSize = 0;
//       final cacheDir = await getTemporaryDirectory();

//       if (await cacheDir.exists()) {
//         final cacheFiles = cacheDir.listSync(recursive: true);
//         for (var file in cacheFiles) {
//           if (file is File && _isImageFile(file.path)) {
//             totalSize += await file.length() / (1024 * 1024); // Convert to MB
//           }
//         }
//       }

//       return totalSize;
//     } catch (e) {
//       debugPrint('Error getting cache size: $e');
//       return 0;
//     }
//   }

//   bool _isImageFile(String path) {
//     final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
//     return imageExtensions.any((ext) => path.toLowerCase().endsWith(ext));
//   }
// }
