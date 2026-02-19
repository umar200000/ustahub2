import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/application2/booking_bloc_and_data/bloc/booking_bloc.dart';
import 'package:ustahub/application2/booking_bloc_and_data/data/model/booking_model_list.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/custom_toggle.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/routes/routes.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

enum OrderTab { active, closed }

class MainOrderPage extends StatefulWidget {
  const MainOrderPage({super.key});

  @override
  State<MainOrderPage> createState() => _MainOrderPageState();
}

class _MainOrderPageState extends State<MainOrderPage> {
  OrderTab selectedTab = OrderTab.active;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(
      const GetBookingsListEvent(isRefresh: true),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<BookingBloc>().state;
      if (state.listStatus != Status2.loading && !state.hasReachedMax) {
        context.read<BookingBloc>().add(const GetBookingsListEvent());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll - 100);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              final activeOrders = state.items.where((item) {
                return [
                  'pending',
                  'accepted',
                  'assigned',
                  'started',
                ].contains(item.status);
              }).toList();

              final closedOrders = state.items.where((item) {
                return ['completed', 'canceled'].contains(item.status);
              }).toList();

              final currentOrders = selectedTab == OrderTab.active
                  ? activeOrders
                  : closedOrders;

              return Column(
                children: [
                  UniversalAppBar(
                    title: "orders".tr(),
                    centerTitle: true,
                    showBackButton: false,
                    backgroundColor: colors.primary500,
                    showShadow: true,
                    bottom: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomToggle<OrderTab>(
                        current: selectedTab,
                        values: [OrderTab.active, OrderTab.closed],
                        onChanged: (value) {
                          setState(() {
                            selectedTab = value;
                          });
                        },
                        height: 48.h,
                        indicatorSize: Size(
                          (MediaQuery.of(context).size.width - 38.w) / 2,
                          48.h,
                        ),
                        backgroundColor: colors.neutral300,
                        indicatorColor: colors.shade0,
                        elevation: true,
                        iconList: [
                          _buildTabContent(
                            'active_orders'.tr(),
                            activeOrders.length,
                            selectedTab == OrderTab.active,
                            fonts,
                            colors,
                          ),
                          _buildTabContent(
                            'closed_orders'.tr(),
                            closedOrders.length,
                            selectedTab == OrderTab.closed,
                            fonts,
                            colors,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<BookingBloc>().add(
                          const GetBookingsListEvent(isRefresh: true),
                        );
                      },
                      child: _buildBody(currentOrders, state, colors, fonts),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(
    List<BookingListItem> orders,
    BookingState state,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    if (state.listStatus == Status2.loading && state.items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xff02BDC6)),
      );
    }

    if (orders.isEmpty &&
        !state.hasReachedMax &&
        state.listStatus != Status2.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xff02BDC6)),
      );
    }

    if (orders.isEmpty) {
      return _buildEmptyState(
        selectedTab == OrderTab.active
            ? 'no_active_orders'.tr()
            : 'no_closed_orders'.tr(),
        selectedTab == OrderTab.active
            ? 'active_orders_description'.tr()
            : 'closed_orders_description'.tr(),
        colors,
        fonts,
      );
    }

    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 12.h, bottom: 100.h),
      itemCount: state.hasReachedMax ? orders.length : orders.length + 1,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        if (index >= orders.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(color: Color(0xff02BDC6)),
            ),
          );
        }

        final order = orders[index];
        return _buildOrderCard(
          bookingUuid: order.id ?? "",
          orderId: "#${order.bookingNumber}",
          serviceName: order.serviceTitle ?? "",
          providerName: order.providerName ?? "",
          providerLogo: order.providerLogo ?? "",
          date: order.scheduledDate ?? "",
          time: order.scheduledTimeStart ?? "",
          status: order.status ?? "",
          price: (order.totalPrice ?? 0).toInt(),
          statusColor: order.status == 'started'
              ? colors.yellow500
              : colors.blue500,
          colors: colors,
          fonts: fonts,
          isActive: selectedTab == OrderTab.active,
        );
      },
    );
  }

  Widget _buildTabContent(
    String label,
    int count,
    bool isSelected,
    FontSet fonts,
    CustomColorSet colors,
  ) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: fonts.paragraphP1Medium.copyWith(
                color: isSelected ? colors.shade100 : colors.neutral600,
                fontSize: 14.sp,
              ),
            ),
            TextSpan(
              text: ' ($count)',
              style: fonts.paragraphP1Regular.copyWith(
                color: isSelected ? colors.neutral600 : colors.neutral500,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    String title,
    String description,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 80.sp,
                color: colors.neutral400,
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: fonts.headingH6SemiBold.copyWith(color: colors.shade100),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: fonts.paragraphP2Regular.copyWith(
                  color: colors.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String bookingUuid,
    required String orderId,
    required String serviceName,
    required String providerName,
    required String providerLogo,
    required String date,
    required String time,
    required String status,
    required int price,
    required Color statusColor,
    required CustomColorSet colors,
    required FontSet fonts,
    required bool isActive,
  }) {
    String formattedTime = time;
    if (time.contains(':')) {
      final parts = time.split(':');
      if (parts.length >= 2) {
        formattedTime = "${parts[0]}:${parts[1]}";
      }
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
            color: Color(0x08000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: fonts.paragraphP2SemiBold.copyWith(
                  color: colors.blue500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: fonts.paragraphP3Medium.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            serviceName,
            style: fonts.paragraphP1SemiBold.copyWith(
              color: colors.shade100,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.network(
                  providerLogo,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.business,
                    size: 18.sp,
                    color: colors.neutral600,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                providerName,
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16.sp,
                color: colors.neutral600,
              ),
              SizedBox(width: 6.w),
              Text(
                date,
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.access_time, size: 16.sp, color: colors.neutral600),
              SizedBox(width: 6.w),
              Text(
                formattedTime,
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: colors.neutral200),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: fonts.paragraphP3Regular.copyWith(
                      color: colors.neutral600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} UZS',
                    style: fonts.paragraphP1Bold.copyWith(
                      color: colors.shade100,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    AppRoutes.orders(serviceId: bookingUuid),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.blue500,
                  foregroundColor: colors.shade0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  isActive ? 'View Details' : 'View',
                  style: fonts.paragraphP2Medium.copyWith(color: colors.shade0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
