import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ustahub/infrastructure2/common/api_path.dart';

class VersionCheckResult {
  final bool needsUpdate;
  final bool isForceUpdate;
  final String latestVersion;
  final String? storeUrl;
  final String? releaseNotes;

  const VersionCheckResult({
    required this.needsUpdate,
    required this.isForceUpdate,
    required this.latestVersion,
    this.storeUrl,
    this.releaseNotes,
  });

  factory VersionCheckResult.noUpdate() => const VersionCheckResult(
        needsUpdate: false,
        isForceUpdate: false,
        latestVersion: '',
      );
}

/// Backend'dan ilova versiyasini tekshirib, yangilanish kerakligini qaytaradi.
///
/// API: GET {baseUrl}/api/v1/public/app-version/
///       ?app_type=client&platform=android|ios&current_version=x.y.z
///
/// Xato bo'lsa xavfsiz tarzda VersionCheckResult.noUpdate() qaytaradi.
class VersionCheckService {
  static final VersionCheckService _instance = VersionCheckService._internal();
  factory VersionCheckService() => _instance;
  VersionCheckService._internal();

  Future<VersionCheckResult> check() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final platform = Platform.isIOS ? 'ios' : 'android';

      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Accept': 'application/json'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get(
        'api/v1/public/app-version/',
        queryParameters: {
          'app_type': 'client',
          'platform': platform,
          'current_version': currentVersion,
        },
      );

      if (response.statusCode != 200) return VersionCheckResult.noUpdate();

      final body = response.data;
      final data = body is Map ? (body['data'] ?? body) : body;

      if (data is! Map) return VersionCheckResult.noUpdate();

      final needsUpdate = data['needs_update'] as bool? ?? false;
      final isForceUpdate = data['is_force_update'] as bool? ?? false;
      final latestVersion = data['latest_version']?.toString() ?? '';
      final storeUrl = data['store_url']?.toString();
      final releaseNotes = data['release_notes']?.toString();

      return VersionCheckResult(
        needsUpdate: needsUpdate,
        isForceUpdate: isForceUpdate,
        latestVersion: latestVersion,
        storeUrl: storeUrl?.isNotEmpty == true ? storeUrl : null,
        releaseNotes: releaseNotes?.isNotEmpty == true ? releaseNotes : null,
      );
    } catch (e) {
      debugPrint('[VersionCheckService] check failed (safe fallback): $e');
      return VersionCheckResult.noUpdate();
    }
  }
}
