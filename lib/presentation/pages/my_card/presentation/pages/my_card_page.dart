import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
  // Mock data for cards
  final List<Map<String, dynamic>> _mockCards = [
    {
      "id": "1",
      "number": "**** **** **** 4589",
      "holder": "Umarov Umar",
      "expiry": "12/26",
      "type": "Humo",
      "color": const Color(0xFF1A237E), // Dark Blue
    },
    {
      "id": "2",
      "number": "**** **** **** 1234",
      "holder": "Umarov Umar",
      "expiry": "05/25",
      "type": "Uzcard",
      "color": const Color(0xFF2E7D32), // Green
    },
  ];

  void _deleteCard(String id) {
    setState(() {
      _mockCards.removeWhere((card) => card["id"] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("card_deleted".tr()),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteConfirmation(
    String id,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    showDialog(
      context: context,
      builder: (context) {
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
              onPressed: () => Navigator.pop(context),
              child: Text(
                "cancel".tr(),
                style: fonts.paragraphP2Bold.copyWith(color: colors.neutral500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteCard(id);
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
                child: ListView.separated(
                  padding: EdgeInsets.all(20.w),
                  itemCount: _mockCards.length + 1, // +1 for Add Card button
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    if (index == _mockCards.length) {
                      return _buildAddCardButton(colors, fonts);
                    }
                    final card = _mockCards[index];
                    return _buildCardItem(card, colors, fonts);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardItem(
    Map<String, dynamic> card,
    CustomColorSet colors,
    FontSet fonts,
  ) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: card["color"],
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: card["color"].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Icon(
              Icons.credit_card,
              size: 150.sp,
              color: Colors.white.withOpacity(0.1),
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
                      card["type"],
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
                      onPressed: () =>
                          _showDeleteConfirmation(card["id"], colors, fonts),
                    ),
                  ],
                ),
                Text(
                  card["number"],
                  style: fonts.headingH4Bold.copyWith(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 22.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card["holder"],
                          style: fonts.paragraphP2Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "expiry".tr().toUpperCase(),
                          style: fonts.paragraphP3Regular.copyWith(
                            color: Colors.white70,
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          card["expiry"],
                          style: fonts.paragraphP2Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddCardPage()),
        );
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: colors.neutral50,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.neutral200,
            style: BorderStyle.solid,
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
