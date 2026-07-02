import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:ustahub/infrastructure2/init/injection.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class MasterServicesPage extends StatefulWidget {
  const MasterServicesPage({
    super.key,
    required this.masterId,
    this.masterName,
    this.masterAvatarUrl,
  });

  final String masterId;
  final String? masterName;
  final String? masterAvatarUrl;

  @override
  State<MasterServicesPage> createState() => _MasterServicesPageState();
}

class _MasterServicesPageState extends State<MasterServicesPage> {
  static const String _systemProviderId = '00000000-0000-0000-0000-000000000001';

  bool _loading = true;
  List<dynamic> _services = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final dio = sl<Dio>();
      final response = await dio.get(
        'api/v1/client/services/provider/$_systemProviderId/',
        queryParameters: {'master_id': widget.masterId, 'limit': 50},
      );
      final body = response.data;
      if (body is Map && body['success'] == true) {
        final rawData = body['data'];
        List<dynamic> items = [];
        if (rawData is List) {
          items = rawData;
        } else if (rawData is Map) {
          items = rawData['items'] ?? rawData['results'] ?? [];
        }
        setState(() {
          _services = items;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'error'.tr();
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'error'.tr();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.bgSurface,
          appBar: AppBar(
            backgroundColor: colors.shade0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: colors.neutral800, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                _MasterAvatar(
                  avatarUrl: widget.masterAvatarUrl,
                  name: widget.masterName ?? '',
                  colors: colors,
                  radius: 16.r,
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Text(
                    widget.masterName ?? 'specialist'.tr(),
                    style: TextStyle(
                      color: colors.neutral800,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(child: Text(_error!))
                  : _services.isEmpty
                      ? Center(child: Text('no_services_found'.tr()))
                      : RefreshIndicator(
                          onRefresh: _loadServices,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            itemCount: _services.length,
                            itemBuilder: (context, index) {
                              final s = _services[index] as Map<String, dynamic>;
                              final serviceId = s['id'] as String? ?? '';
                              final title = s['title'] ??
                                  s['title_uz'] ??
                                  'unnamed_service'.tr();
                              final price = s['base_price'];
                              final imageUrl = s['primary_image_url'];
                              final currencySymbol =
                                  s['currency_symbol'] ?? 'so\'m';

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    AppRoutes.detailsPage(
                                      serviceId,
                                      providerName: widget.masterName,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  decoration: BoxDecoration(
                                    color: colors.shade0,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border:
                                        Border.all(color: colors.neutral200),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.r),
                                          bottomLeft: Radius.circular(16.r),
                                        ),
                                        child: imageUrl != null
                                            ? Image.network(
                                                imageUrl,
                                                width: 90.w,
                                                height: 90.w,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, e, st) =>
                                                    _imagePlaceholder(
                                                        colors, 90.w),
                                              )
                                            : _imagePlaceholder(colors, 90.w),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 12.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.sp,
                                                  color: colors.neutral800,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (price != null) ...[
                                                SizedBox(height: 6.h),
                                                Text(
                                                  '${price.toString()} $currencySymbol',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13.sp,
                                                    color: colors.primary500,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }

  Widget _imagePlaceholder(dynamic colors, double size) {
    return Container(
      width: size,
      height: size,
      color: colors.neutral200,
      child: Icon(Icons.image_not_supported,
          color: colors.neutral400, size: 28.sp),
    );
  }
}

class _MasterAvatar extends StatelessWidget {
  const _MasterAvatar({
    required this.avatarUrl,
    required this.name,
    required this.colors,
    required this.radius,
  });

  final String? avatarUrl;
  final String name;
  final dynamic colors;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'M';
    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.blue500,
      backgroundImage:
          avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Text(initial,
              style: TextStyle(
                  color: colors.shade0,
                  fontWeight: FontWeight.w700,
                  fontSize: radius * 0.8))
          : null,
    );
  }
}
