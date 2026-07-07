import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ustahub/application2/express_bloc_and_data/bloc/express_bloc.dart';
import 'package:ustahub/application2/express_bloc_and_data/data/model/express_model.dart';
import 'package:ustahub/presentation/styles/style.dart';

import 'express_searching_page.dart';

class ExpressLandingPage extends StatefulWidget {
  const ExpressLandingPage({super.key});

  @override
  State<ExpressLandingPage> createState() => _ExpressLandingPageState();
}

class _ExpressLandingPageState extends State<ExpressLandingPage> {
  late final ExpressClientBloc _bloc;

  Position? _position;
  ExpressProvinceModel? _selectedProvince;
  ExpressDistrictModel? _selectedDistrict;
  ExpressCategoryModel? _selectedCategory;
  String _paymentMethod = 'cash';

  bool _locationGranted = false;
  bool _locationLoading = false;

  @override
  void initState() {
    super.initState();
    // Sahifa o'z bloc'ini yaratadi (singleton EMAS — har ochilishda toza instance)
    _bloc = ExpressClientBloc();
    // Viloyatlarni darhol yuklaymiz (lokatsiyaga bog'liq emas)
    _bloc.add(const LoadExpressProvincesEvent());
    _checkLocationAndLoad();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<void> _checkLocationAndLoad() async {
    setState(() => _locationLoading = true);

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _locationLoading = false);
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      if (mounted) setState(() => _locationLoading = false);
      return;
    }

    if (permission == LocationPermission.denied) {
      if (mounted) setState(() => _locationLoading = false);
      return;
    }

    await _getLocation();
    if (mounted) setState(() => _locationLoading = false);
  }

  Future<void> _getLocation() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
      if (mounted) {
        setState(() {
          _position = pos;
          _locationGranted = true;
        });
      }
    } catch (_) {}
  }

  Future<void> _onProvinceChanged(ExpressProvinceModel? province) async {
    setState(() {
      _selectedProvince = province;
      _selectedDistrict = null;
      _selectedCategory = null;
    });
    if (province?.id != null) {
      _bloc.add(LoadExpressDistrictsEvent(provinceId: province!.id!));
    }
  }

  bool get _canSearch =>
      _locationGranted &&
      _position != null &&
      _selectedProvince != null &&
      _selectedDistrict != null &&
      _selectedCategory != null;

  void _startSearch() {
    if (!_canSearch) return;
    final bloc = _bloc;
    bloc.add(StartExpressSearchEvent(
      categoryId: _selectedCategory!.id!,
      provinceId: _selectedProvince!.id!,
      districtId: _selectedDistrict?.id,
      latitude: _position!.latitude,
      longitude: _position!.longitude,
      paymentMethod: _paymentMethod,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: ExpressSearchingPage(
            categoryName: _selectedCategory!.name(context.locale.languageCode),
            basePrice: _selectedCategory!.basePrice,
            maxPrice: _selectedCategory!.maxPrice,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF2A2B36)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'express_title'.tr(),
            style: TextStyle(
              color: const Color(0xFF2A2B36),
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationCard(),
                      SizedBox(height: 16.h),
                      _buildProvinceSelector(),
                      SizedBox(height: 12.h),
                      _buildDistrictSelector(),
                      SizedBox(height: 16.h),
                      _buildCategorySelector(),
                      if (_selectedCategory?.basePrice != null) ...[
                        SizedBox(height: 12.h),
                        _buildPriceCard(_selectedCategory!),
                      ],
                      SizedBox(height: 16.h),
                      _buildPaymentSelector(),
                    ],
                  ),
                ),
              ),
              _buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Style.primary500.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _locationGranted
                  ? Icons.location_on_rounded
                  : Icons.location_off_rounded,
              color: _locationGranted ? Style.primary500 : Colors.red,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _locationLoading
                ? Text('express_detecting_location'.tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey))
                : _locationGranted
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'express_location_detected'.tr(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Style.primary500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_position != null)
                            Text(
                              '${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      )
                    : GestureDetector(
                        onTap: _checkLocationAndLoad,
                        child: Text(
                          'express_grant_location'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
          ),
          if (_locationLoading)
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Style.primary500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProvinceSelector() {
    return BlocBuilder<ExpressClientBloc, ExpressClientState>(
      buildWhen: (p, c) =>
          p.provinces != c.provinces ||
          p.provincesLoading != c.provincesLoading,
      builder: (context, state) {
        final lang = context.locale.languageCode;
        return _buildSelectorField(
          label: 'express_province'.tr(),
          icon: Icons.map_outlined,
          valueText: _selectedProvince?.name(lang),
          hint: 'express_select_province'.tr(),
          isLoading: state.provincesLoading,
          onTap: _openProvinceSheet,
        );
      },
    );
  }

  Widget _buildDistrictSelector() {
    return BlocBuilder<ExpressClientBloc, ExpressClientState>(
      buildWhen: (p, c) =>
          p.districts != c.districts ||
          p.districtsLoading != c.districtsLoading,
      builder: (context, state) {
        final lang = context.locale.languageCode;
        return _buildSelectorField(
          label: 'express_district'.tr(),
          icon: Icons.location_city_rounded,
          valueText: _selectedDistrict?.name(lang),
          hint: 'express_select_district'.tr(),
          isLoading: state.districtsLoading,
          // Viloyat tanlanmaguncha tuman tanlab bo'lmaydi
          enabled: _selectedProvince != null,
          onTap: _openDistrictSheet,
        );
      },
    );
  }

  // Viloyat tanlash uchun pastdan ochiladigan modal oyna
  void _openProvinceSheet() {
    final lang = context.locale.languageCode;
    _showBottomSelector(
      title: 'express_select_province'.tr(),
      emptyText: 'express_no_provinces'.tr(),
      selectedId: _selectedProvince?.id,
      itemsBuilder: (state) => state.provinces
          .map((p) => _SelectorItem(id: p.id, label: p.name(lang), model: p))
          .toList(),
      loadingBuilder: (state) => state.provincesLoading,
      onSelected: (item) =>
          _onProvinceChanged(item.model as ExpressProvinceModel),
    );
  }

  // Tuman tanlash uchun pastdan ochiladigan modal oyna
  void _openDistrictSheet() {
    if (_selectedProvince == null) return;
    final lang = context.locale.languageCode;
    _showBottomSelector(
      title: 'express_select_district'.tr(),
      emptyText: 'express_no_districts'.tr(),
      selectedId: _selectedDistrict?.id,
      itemsBuilder: (state) => state.districts
          .map((d) => _SelectorItem(id: d.id, label: d.name(lang), model: d))
          .toList(),
      loadingBuilder: (state) => state.districtsLoading,
      onSelected: (item) {
        final district = item.model as ExpressDistrictModel;
        setState(() {
          _selectedDistrict = district;
          _selectedCategory = null;
        });
        if (_selectedProvince?.id != null && district.id != null) {
          _bloc.add(GetExpressCategoriesEvent(
            provinceId: _selectedProvince!.id!,
            districtId: district.id!,
          ));
        }
      },
    );
  }

  Future<void> _showBottomSelector({
    required String title,
    required String emptyText,
    required String? selectedId,
    required List<_SelectorItem> Function(ExpressClientState) itemsBuilder,
    required bool Function(ExpressClientState) loadingBuilder,
    required void Function(_SelectorItem) onSelected,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: _bloc,
          child: BlocBuilder<ExpressClientBloc, ExpressClientState>(
            builder: (sheetCtx, state) {
              final items = itemsBuilder(state);
              final isLoading = loadingBuilder(state);
              return SafeArea(
                top: false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(sheetCtx).size.height * 0.7,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tepadagi tutqich
                      Container(
                        margin: EdgeInsets.only(top: 10.h, bottom: 4.h),
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(sheetCtx),
                              child: Icon(Icons.close_rounded,
                                  size: 22.sp, color: const Color(0xFF8A8A8A)),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1.h, color: const Color(0xFFEAEAEA)),
                      Flexible(
                        child: isLoading && items.isEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 40.h),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Style.primary500,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : items.isEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    child: Center(
                                      child: Text(
                                        emptyText,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF8A8A8A),
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    itemCount: items.length,
                                    separatorBuilder: (_, _) => Divider(
                                      height: 1.h,
                                      indent: 20.w,
                                      endIndent: 20.w,
                                      color: const Color(0xFFF0F0F0),
                                    ),
                                    itemBuilder: (_, i) {
                                      final item = items[i];
                                      final isSel = selectedId != null &&
                                          item.id == selectedId;
                                      return InkWell(
                                        onTap: () {
                                          onSelected(item);
                                          Navigator.pop(sheetCtx);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 14.h),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.label.isEmpty
                                                      ? '—'
                                                      : item.label,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black,
                                                    fontWeight: isSel
                                                        ? FontWeight.w600
                                                        : FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              if (isSel)
                                                Icon(Icons.check_rounded,
                                                    size: 20.sp,
                                                    color: Style.primary500),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Tappable maydon (dropdown ko'rinishida, lekin bosilganda modal ochadi)
  Widget _buildSelectorField({
    required String label,
    required IconData icon,
    required String? valueText,
    required String hint,
    required bool isLoading,
    required VoidCallback onTap,
    bool isOptional = false,
    bool enabled = true,
  }) {
    final hasValue = valueText != null && valueText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2A2B36),
              ),
            ),
            if (isOptional)
              Text(
                ' (${'express_optional'.tr()})',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
          ],
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: (isLoading || !enabled) ? null : onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFEAEAEA)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20.sp, color: const Color(0xFF8A8A8A)),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    hasValue ? valueText : hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: hasValue ? Colors.black : Colors.grey,
                      fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
                if (isLoading)
                  SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                        strokeWidth: 2, color: Style.primary500),
                  )
                else
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 22.sp, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return BlocBuilder<ExpressClientBloc, ExpressClientState>(
      builder: (context, state) {
        final lang = context.locale.languageCode;
        final categories = state.categories;
        final loading = state.status == ExpressSearchStatus.loadingCategories;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'express_category'.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2A2B36),
              ),
            ),
            SizedBox(height: 8.h),
            if (loading)
              const Center(
                child: CircularProgressIndicator(
                  color: Style.primary500,
                  strokeWidth: 2,
                ),
              )
            else if (categories.isEmpty && _selectedProvince != null)
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'express_no_categories'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: categories.map((cat) {
                  final isSelected = _selectedCategory?.id == cat.id;
                  final isRemote = cat.isRemote;
                  final remoteColor = const Color(0xFF6C63FF);
                  final activeBg = isRemote ? remoteColor : Style.primary500;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? activeBg : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? activeBg
                              : isRemote
                                  ? remoteColor.withValues(alpha: 0.35)
                                  : const Color(0xFFEAEAEA),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: activeBg.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (cat.iconUrl != null &&
                                  cat.iconUrl!.isNotEmpty) ...[
                                CachedNetworkImage(
                                  imageUrl: cat.iconUrl!,
                                  width: 18.w,
                                  height: 18.w,
                                  fit: BoxFit.contain,
                                  placeholder: (_, _) =>
                                      SizedBox(width: 18.w, height: 18.w),
                                  errorWidget: (_, _, _) =>
                                      const SizedBox.shrink(),
                                ),
                                SizedBox(width: 6.w),
                              ] else if (isRemote) ...[
                                Icon(
                                  Icons.wifi_rounded,
                                  size: 15.sp,
                                  color: isSelected
                                      ? Colors.white
                                      : remoteColor,
                                ),
                                SizedBox(width: 5.w),
                              ],
                              Text(
                                cat.name(lang),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF2A2B36),
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                          if (isRemote) ...[
                            SizedBox(height: 2.h),
                            Text(
                              'express_remote_label'.tr(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : remoteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'express_payment'.tr(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2A2B36),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _buildPaymentOption(
              label: 'express_cash'.tr(),
              icon: Icons.payments_rounded,
              value: 'cash',
            ),
            SizedBox(width: 10.w),
            _buildPaymentOption(
              label: 'express_card'.tr(),
              icon: Icons.credit_card_rounded,
              value: 'card',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String label,
    required IconData icon,
    required String value,
  }) {
    final selected = _paymentMethod == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _paymentMethod = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: selected ? Style.primary500 : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? Style.primary500 : const Color(0xFFEAEAEA),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF2A2B36),
                size: 18.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF2A2B36),
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(num price) {
    final str = price.toInt().toString();
    final buf = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write(' ');
      buf.write(str[i]);
    }
    return buf.toString();
  }

  Widget _buildPriceCard(ExpressCategoryModel cat) {
    final base = cat.basePrice!;
    final hasRange = cat.maxPrice != null && cat.maxPrice! > base;
    final priceText = hasRange
        ? '${_formatPrice(base)} – ${_formatPrice(cat.maxPrice!)} ${'sum'.tr()}'
        : '${_formatPrice(base)} ${'sum'.tr()}';
    final isRemote = cat.isRemote;
    final accentColor = isRemote ? const Color(0xFF6C63FF) : Style.primary500;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: accentColor.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              Icon(Icons.payments_rounded, color: accentColor, size: 20.sp),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'express_service_price'.tr(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    priceText,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF2A2B36),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isRemote) ...[
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.wifi_rounded,
                    size: 16.sp, color: const Color(0xFF6C63FF)),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'express_remote_note'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF6C63FF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSearchButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: _canSearch ? _startSearch : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Style.primary500,
              disabledBackgroundColor: const Color(0xFFEAEAEA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'express_search_button'.tr(),
              style: TextStyle(
                color: _canSearch ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modal bottom sheet ro'yxatidagi bitta element (viloyat yoki tuman).
class _SelectorItem {
  final String? id;
  final String label;
  final Object model;

  const _SelectorItem({
    required this.id,
    required this.label,
    required this.model,
  });
}
