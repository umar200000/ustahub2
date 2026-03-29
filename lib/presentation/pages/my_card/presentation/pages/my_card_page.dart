import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ustahub/application2/card_bloc_and_data/bloc/card_bloc.dart';
import 'package:ustahub/application2/card_bloc_and_data/data/model/card_model.dart';
import 'package:ustahub/infrastructure/services/enum_status/status_enum.dart';
import 'package:ustahub/presentation/components/universal_appbar.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

import 'add_card_page.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(const GetCardsEvent());
  }

  void _showDeleteConfirmation(
    String id,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: colors.shade0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            "delete_card".tr(),
            style: fonts.paragraphP1Bold.copyWith(color: colors.neutral800),
          ),
          content: Text(
            "are_you_sure_delete_card".tr(),
            style: fonts.paragraphP2Regular.copyWith(color: colors.neutral600),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                "cancel".tr(),
                style: fonts.paragraphP2Bold.copyWith(color: colors.neutral500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<CardBloc>().add(DeleteCardEvent(cardId: id));
              },
              child: Text(
                "delete".tr(),
                style: fonts.paragraphP2Bold.copyWith(color: colors.red500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.shade0,
          body: Column(
            children: [
              UniversalAppBar(
                title: "my_cards".tr(),
                showBackButton: true,
                centerTitle: true,
                backgroundColor: colors.primary500,
              ),
              Expanded(
                child: BlocConsumer<CardBloc, CardState>(
                  listenWhen: (previous, current) =>
                      previous.deleteStatus != current.deleteStatus,
                  listener: (context, state) {
                    if (state.deleteStatus == Status2.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.successMessage ?? "card_deleted".tr(),
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else if (state.deleteStatus == Status2.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage ?? "error".tr(),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.listStatus == Status2.loading) {
                      return _buildShimmer();
                    }

                    if (state.listStatus == Status2.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.errorMessage ?? "error".tr()),
                            Gap(16.h),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<CardBloc>()
                                    .add(const GetCardsEvent());
                              },
                              child: Text("retry".tr()),
                            ),
                          ],
                        ),
                      );
                    }

                    final isDeleting =
                        state.deleteStatus == Status2.loading;

                    return Stack(
                      children: [
                        ListView.separated(
                          padding: EdgeInsets.all(20.w),
                          itemCount: state.cards.length + 1,
                          separatorBuilder: (context, index) => Gap(16.h),
                          itemBuilder: (context, index) {
                            if (index == state.cards.length) {
                              return _buildAddCardButton(colors, fonts);
                            }
                            final card = state.cards[index];
                            return _buildCardItem(card, colors, fonts);
                          },
                        ),
                        if (isDeleting)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.3),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(24.w),
                                  decoration: BoxDecoration(
                                    color: colors.shade0,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: SizedBox(
                                    width: 36.w,
                                    height: 36.w,
                                    child: CircularProgressIndicator(
                                      color: colors.primary500,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 2,
        separatorBuilder: (_, __) => Gap(16.h),
        itemBuilder: (_, __) => Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  Color _getCardColor(String? cardType) {
    switch (cardType?.toLowerCase()) {
      case 'humo':
        return const Color(0xFF1A237E);
      case 'uzcard':
        return const Color(0xFF2E7D32);
      case 'visa':
        return const Color(0xFF1565C0);
      case 'mastercard':
        return const Color(0xFFE65100);
      default:
        return const Color(0xFF37474F);
    }
  }

  Widget _buildCardItem(
    CardItem card,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    final cardColor = _getCardColor(card.cardType);

    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: cardColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Icon(
              Icons.credit_card,
              size: 150.sp,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (card.cardType ?? "").toUpperCase(),
                      style: fonts.paragraphP1Bold.copyWith(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onPressed: () => _showDeleteConfirmation(
                        card.id ?? "",
                        colors,
                        fonts,
                      ),
                    ),
                  ],
                ),
                Text(
                  card.cardNumber ?? "",
                  style: fonts.headingH4Bold.copyWith(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 22.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.cardHolder ?? "",
                      style: fonts.paragraphP2Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(CustomColorSet colors, FontSet fonts) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCardPage()),
        );
        if (mounted) {
          context.read<CardBloc>().add(const GetCardsEvent());
        }
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: colors.neutral50,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.neutral200,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: colors.primary500),
            Gap(12.w),
            Text(
              "add_new_card".tr(),
              style: fonts.paragraphP2Bold.copyWith(color: colors.primary500),
            ),
          ],
        ),
      ),
    );
  }
}
