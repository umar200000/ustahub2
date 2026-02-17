import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ustahub/application2/category_list_bloc_and_data/bloc/category_list_bloc.dart';
import 'package:ustahub/application2/details_service/bloc/details_bloc.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/pages/booking_page/pages/booking_page.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import '../company_details_page/pages/company_details_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.serviceId});
  final String serviceId;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<DetailsBloc>().add(
      GetServiceDetailsEvent(serviceId: widget.serviceId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.neutral50,
          body: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state.status == Status2.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }

              if (state.status == Status2.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? "Xatolik yuz berdi",
                    style: TextStyle(color: colors.red500),
                  ),
                );
              }

              if (state.status == Status2.success &&
                  state.detailsServiceModel?.data != null) {
                final data = state.detailsServiceModel!.data!;

                // Category bo'yicha boshqa xizmatlarni yuklash
                if (data.category?.id != null) {
                  context.read<CategoryListBloc>().add(
                    GetCategoryList(categoryId: data.category!.id!),
                  );
                }

                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 400.h,
                          pinned: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: colors.shade0,
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (data.images != null &&
                                    data.images!.isNotEmpty)
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: double.infinity,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll:
                                          data.images!.length > 1,
                                      autoPlay: data.images!.length > 1,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentImageIndex = index;
                                        });
                                      },
                                    ),
                                    items: data.images!.map((image) {
                                      return Image.network(
                                        image.imageUrl ?? "",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    }).toList(),
                                  )
                                else
                                  Container(
                                    color: colors.neutral200,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 64.sp,
                                      color: colors.neutral400,
                                    ),
                                  ),
                                Positioned.fill(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          colors.neutral800.withOpacity(0.3),
                                          Colors.transparent,
                                          colors.neutral800.withOpacity(0.5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (data.images != null &&
                                    data.images!.length > 1)
                                  Positioned(
                                    bottom: 40.h,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: data.images!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                            return Container(
                                              width:
                                                  _currentImageIndex ==
                                                      entry.key
                                                  ? 20.w
                                                  : 8.w,
                                              height: 8.h,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 4.w,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                                color:
                                                    _currentImageIndex ==
                                                        entry.key
                                                    ? colors.blue500
                                                    : colors.shade0.withOpacity(
                                                        0.5,
                                                      ),
                                              ),
                                            );
                                          })
                                          .toList(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(30.h),
                            child: Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: colors.neutral50,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.blue500.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        data.category?.nameUz?.toUpperCase() ??
                                            "XIZMAT",
                                        style: fonts.paragraphP3Bold.copyWith(
                                          color: colors.blue500,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.star,
                                      color: colors.yellow500,
                                      size: 18.sp,
                                    ),
                                    4.w.horizontalSpace,
                                    Text(
                                      data.averageRating?.toString() ?? "0.0",
                                      style: fonts.paragraphP2Bold.copyWith(
                                        color: colors.neutral800,
                                      ),
                                    ),
                                    Text(
                                      " (${data.totalReviews ?? 0} reviews)",
                                      style: fonts.paragraphP3Regular.copyWith(
                                        color: colors.neutral500,
                                      ),
                                    ),
                                  ],
                                ),
                                12.h.verticalSpace,
                                Text(
                                  data.titleUz ?? "",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                16.h.verticalSpace,
                                Row(
                                  children: [
                                    _buildInfoChip(
                                      Icons.access_time,
                                      "${data.durationMinutes ?? 0} min",
                                      colors,
                                      fonts,
                                    ),
                                    12.w.horizontalSpace,
                                    _buildInfoChip(
                                      Icons.location_on_outlined,
                                      "Tashkent",
                                      colors,
                                      fonts,
                                    ),
                                    12.w.horizontalSpace,
                                    _buildInfoChip(
                                      Icons.verified_outlined,
                                      "Verified",
                                      colors,
                                      fonts,
                                    ),
                                  ],
                                ),
                                24.h.verticalSpace,
                                Text(
                                  "About Service",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                12.h.verticalSpace,
                                Text(
                                  data.descriptionUz ?? "",
                                  style: fonts.paragraphP2Regular.copyWith(
                                    color: colors.neutral600,
                                    height: 1.6,
                                  ),
                                ),
                                24.h.verticalSpace,
                                GestureDetector(
                                  onTap: () {
                                    if (data.providerId != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyDetailsPage(
                                                providerId: data.providerId!,
                                              ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: colors.shade0,
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: colors.neutral200,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25.r,
                                          backgroundColor: colors.neutral200,
                                          backgroundImage:
                                              data.providerLogo != null
                                              ? NetworkImage(data.providerLogo!)
                                              : null,
                                          child: data.providerLogo == null
                                              ? Icon(
                                                  Icons.person,
                                                  color: colors.neutral400,
                                                )
                                              : null,
                                        ),
                                        12.w.horizontalSpace,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Qurilish.uz",
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                "Professional Mutaxasislar bizda",
                                                style: fonts.paragraphP3Regular
                                                    .copyWith(
                                                      color: colors.neutral500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.chat_bubble_outline,
                                            color: colors.blue500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                32.h.verticalSpace,
                                // O'xshash xizmatlar sarlavhasi
                                Text(
                                  "Similar Services",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                16.h.verticalSpace,
                                // O'xshash xizmatlar ro'yxati (CategoryListBloc orqali)
                                BlocBuilder<
                                  CategoryListBloc,
                                  CategoryListState
                                >(
                                  builder: (context, catState) {
                                    if (catState.status == Status2.loading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    // Hozirgi service ID si bilan bir xil bo'lganlarni olib tashlash
                                    final filteredItems = catState.items
                                        .where((item) => item.id != data.id)
                                        .toList();

                                    if (filteredItems.isEmpty) {
                                      return const Text(
                                        "No similar services found",
                                      );
                                    }
                                    return SizedBox(
                                      height: 170.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: filteredItems.length,
                                        separatorBuilder: (context, index) =>
                                            Gap(12.w),
                                        itemBuilder: (context, index) {
                                          final item = filteredItems[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                        serviceId: item.id!,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 160.w,
                                              decoration: BoxDecoration(
                                                color: colors.shade0,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: colors.neutral200,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            12.r,
                                                          ),
                                                        ),
                                                    child: Image.network(
                                                      item.primaryImageUrl ??
                                                          "",
                                                      height: 100.h,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                      8.w,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.titleUz ?? "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: fonts
                                                              .paragraphP3Bold,
                                                        ),
                                                        Gap(4.h),
                                                        Text(
                                                          "${item.basePrice} ${item.currencySymbol ?? "So'm"}",
                                                          style: fonts
                                                              .paragraphP3Regular
                                                              .copyWith(
                                                                color: colors
                                                                    .blue500,
                                                              ),
                                                        ),
                                                      ],
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
                                ),
                                140.h.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Bottom Navigation Bar
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.shade0,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.neutral800.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom - 10,
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Price",
                                    style: fonts.paragraphP3Regular.copyWith(
                                      color: colors.neutral500,
                                    ),
                                  ),
                                  Text(
                                    "${data.basePrice ?? '0'} ${data.currencySymbol ?? ''}",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: colors.blue500,
                                    ),
                                  ),
                                ],
                              ),
                              20.w.horizontalSpace,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingPage(service: data),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colors.blue500,
                                    foregroundColor: colors.shade0,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "Book Now",
                                    style: fonts.paragraphP2Bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Custom Back Button
                    Positioned(
                      top: 50.h,
                      left: 20.w,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: colors.shade0.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.sp,
                            color: colors.neutral800,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.shade0,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.neutral200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: colors.blue500),
          6.w.horizontalSpace,
          Text(
            label,
            style: fonts.paragraphP3Bold.copyWith(color: colors.neutral700),
          ),
        ],
      ),
    );
  }
}
