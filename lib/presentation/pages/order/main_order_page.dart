import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/custom_toggle.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
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

  // Sample data - replace with real data
  final List<Map<String, dynamic>> activeOrders = [
    {
      'orderId': '#12345',
      'serviceName': 'Home Cleaning',
      'providerName': 'John Doe',
      'date': '12 Jan 2025',
      'time': '10:00 AM',
      'status': 'In Progress',
      'price': 150000,
    },
    {
      'orderId': '#12346',
      'serviceName': 'Plumbing Service',
      'providerName': 'Mike Smith',
      'date': '13 Jan 2025',
      'time': '2:00 PM',
      'status': 'Pending',
      'price': 200000,
    },
    {
      'orderId': '#12347',
      'serviceName': 'Electrical Repair',
      'providerName': 'Sarah Johnson',
      'date': '14 Jan 2025',
      'time': '11:30 AM',
      'status': 'In Progress',
      'price': 180000,
    },
  ];

  final List<Map<String, dynamic>> closedOrders = [
    {
      'orderId': '#12340',
      'serviceName': 'Carpet Cleaning',
      'providerName': 'Tom Wilson',
      'date': '8 Jan 2025',
      'time': '9:00 AM',
      'status': 'Completed',
      'price': 120000,
    },
    {
      'orderId': '#12341',
      'serviceName': 'AC Repair',
      'providerName': 'James Brown',
      'date': '9 Jan 2025',
      'time': '3:00 PM',
      'status': 'Completed',
      'price': 250000,
    },
    {
      'orderId': '#12342',
      'serviceName': 'Painting Service',
      'providerName': 'David Lee',
      'date': '10 Jan 2025',
      'time': '1:00 PM',
      'status': 'Cancelled',
      'price': 300000,
    },
    {
      'orderId': '#12343',
      'serviceName': 'Garden Maintenance',
      'providerName': 'Emma Davis',
      'date': '11 Jan 2025',
      'time': '8:00 AM',
      'status': 'Completed',
      'price': 100000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral100,
          body: Column(
            children: [
              UniversalAppBar(
                title: "orders".tr(),
                centerTitle: true,
                showBackButton: false,
                backgroundColor: const Color(0xFF1A1A1A),
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
                    backgroundColor: colors.neutral200,
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

              // Toggle Tabs

              // Orders List
              Expanded(
                child: selectedTab == OrderTab.active
                    ? _buildActiveOrders(colors, fonts)
                    : _buildClosedOrders(colors, fonts),
              ),
            ],
          ),
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

  Widget _buildActiveOrders(CustomColorSet colors, FontSet fonts) {
    if (activeOrders.isEmpty) {
      return _buildEmptyState(
        'no_active_orders'.tr(),
        'active_orders_description'.tr(),
        colors,
        fonts,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: activeOrders.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final order = activeOrders[index];
        return _buildOrderCard(
          orderId: order['orderId'],
          serviceName: order['serviceName'],
          providerName: order['providerName'],
          date: order['date'],
          time: order['time'],
          status: order['status'],
          price: order['price'],
          statusColor: order['status'] == 'In Progress'
              ? colors.yellow500
              : colors.blue500,
          colors: colors,
          fonts: fonts,
          isActive: true,
        );
      },
    );
  }

  Widget _buildClosedOrders(CustomColorSet colors, FontSet fonts) {
    if (closedOrders.isEmpty) {
      return _buildEmptyState(
        'no_closed_orders'.tr(),
        'closed_orders_description'.tr(),
        colors,
        fonts,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: closedOrders.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final order = closedOrders[index];
        return _buildOrderCard(
          orderId: order['orderId'],
          serviceName: order['serviceName'],
          providerName: order['providerName'],
          date: order['date'],
          time: order['time'],
          status: order['status'],
          price: order['price'],
          statusColor: order['status'] == 'Completed'
              ? colors.blue500
              : colors.red500,
          colors: colors,
          fonts: fonts,
          isActive: false,
        );
      },
    );
  }

  Widget _buildEmptyState(
    String title,
    String description,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Center(
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
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String serviceName,
    required String providerName,
    required String date,
    required String time,
    required String status,
    required int price,
    required Color statusColor,
    required CustomColorSet colors,
    required FontSet fonts,
    required bool isActive,
  }) {
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
          // Header: Order ID & Status
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
                  status,
                  style: fonts.paragraphP3Medium.copyWith(color: statusColor),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Service Name
          Text(
            serviceName,
            style: fonts.paragraphP1SemiBold.copyWith(
              color: colors.shade100,
              fontSize: 16.sp,
            ),
          ),

          SizedBox(height: 4.h),

          // Provider Name
          Row(
            children: [
              Icon(Icons.person_outline, size: 16.sp, color: colors.neutral600),
              SizedBox(width: 6.w),
              Text(
                providerName,
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Date & Time
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
                time,
                style: fonts.paragraphP3Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Divider
          Divider(height: 1, color: colors.neutral200),

          SizedBox(height: 12.h),

          // Footer: Price & Action Button
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

              // Action Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to order details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive
                      ? colors.blue500
                      : colors.neutral300,
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
