import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/infrastructure/services/local_database/db_service.dart';
import 'package:ustahub/presentation/components/registration_prompt_sheet.dart';
import 'package:ustahub/presentation/styles/theme.dart';

class PaymentDetails {
  final double totalAmount;
  final double fromBalance;
  final double fromPromoCode;
  final double deliveryFee;
  final double serviceFee;
  final double amountToPay;

  PaymentDetails({
    required this.totalAmount,
    required this.fromBalance,
    required this.fromPromoCode,
    required this.deliveryFee,
    required this.serviceFee,
    required this.amountToPay,
  });
}

PaymentDetails calculatePayment({
  required double balance,
  required double promoCode,
  required double totalAmount,
  required double deliveryFee,
  required double serviceFee,
}) {
  double fromBalance = (balance >= totalAmount) ? totalAmount : balance;
  double remainingAmount = totalAmount - fromBalance;

  double fromPromoCode = (promoCode >= remainingAmount)
      ? remainingAmount
      : promoCode;
  remainingAmount -= fromPromoCode;

  double amountToPay = remainingAmount + deliveryFee + serviceFee;

  return PaymentDetails(
    totalAmount: totalAmount,
    fromBalance: fromBalance,
    fromPromoCode: fromPromoCode,
    deliveryFee: deliveryFee,
    serviceFee: serviceFee,
    amountToPay: amountToPay,
  );
}

class MyOrderStatus {
  static const String wait = "wait";
  static const String collect = "collect";
  static const String onWay = "on_way";
  static const String finish = "finish";
  static const String cancel = "cancel";

  static String statusTitle(String status) {
    switch (status) {
      case wait:
        return "order_accepted".tr();
      case collect:
        return "order_collected".tr();
      case onWay:
        return "order_on_the_way".tr();
      case finish:
        return "order_delivered".tr();
      case cancel:
        return "order_cancelled".tr();
      default:
        return "unknown".tr();
    }
  }

  static String statusIcon(String status, IconSet icons) {
    switch (status) {
      case wait:
        return icons.timeS;
      case collect:
        return icons.truckBoxS;
      case onWay:
        return icons.boxS;
      case finish:
        return icons.flagS;
      case cancel:
        return icons.crossCircularS;
      default:
        return icons.timeS;
    }
  }

  static Widget statusIconWidget(
    String status,
    IconSet icons, {
    double? height,
    double? width,
  }) {
    switch (status) {
      case wait:
        return icons.progressTracker1.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
      case collect:
        return icons.progressTracker2.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
      case onWay:
        return icons.progressTracker3.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
      case finish:
        return icons.progressTracker4.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
      case cancel:
        return icons.progressTracker5.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
      default:
        return icons.progressTracker1.svg(
          height: height,
          width: width,
          boxFit: BoxFit.scaleDown,
        );
    }
  }

  static Color statusColor(String status, CustomColorSet colors) {
    switch (status) {
      case wait:
        return colors.primary500;
      case collect:
        return colors.primary500;
      case onWay:
        return colors.primary500;
      case finish:
        return colors.primary500;
      case cancel:
        return colors.red500;
      default:
        return colors.primary500;
    }
  }

  static String statusSubtitle(String status) {
    switch (status) {
      case wait:
        return "order_accepted_subtitle".tr();
      case collect:
        return "order_collected_subtitle".tr();
      case onWay:
        return "order_status_subtitle".tr();
      case finish:
      case cancel:
        return "";
      default:
        return "unknown".tr();
    }
  }

  static int getActiveStep(String status) {
    switch (status) {
      case cancel:
      case wait:
        return 0;
      case collect:
        return 1;
      case onWay:
        return 2;
      case finish:
        return 3;
      default:
        return 0;
    }
  }
}

class AuthUtils {
  /// Checks if the user is authenticated by checking the login status from the database
  static Future<bool> checkUserAuthentication() async {
    final dbService = await DBService.create;
    return dbService.isUserLoggedIn;
  }

  /// Handles an action with authentication check
  /// If user is not authenticated, shows registration prompt
  /// If user is authenticated, executes the action
  static Future<void> handleActionWithAuth(
    BuildContext context,
    VoidCallback action, {
    String? message,
    bool? mounted,
  }) async {
    final isAuthenticated = await checkUserAuthentication();
    if (!isAuthenticated) {
      if (mounted == null || mounted) {
        showRegistrationPrompt(
          context,
          message: message ?? "add_to_cart_requires_registration".tr(),
        );
      }
    } else {
      action();
    }
  }
}
