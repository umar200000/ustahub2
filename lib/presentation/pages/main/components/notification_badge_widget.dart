// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:ustahub/presentation/styles/theme_wrapper.dart';

// class NotificationCountBadge extends StatelessWidget {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   const NotificationCountBadge({super.key, required this.flutterLocalNotificationsPlugin});

//   @override
//   Widget build(BuildContext context) {
//     return ThemeWrapper(
//       builder: (ctx, colors, fonts, icons, global) {
//         return BlocConsumer<ChatBloc, ChatState>(
//           listener: (context, state) {
//             FlutterAppBadge.count(state.unreadCount?.count ?? 0);
//           },
//           builder: (context, state) {
//             if (state.unreadCount?.count != null && state.unreadCount?.count != 0) {
//               return _IntrinsicHorizontalStadium(
//                 minSize: 12,
//                 child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: ShapeDecoration(
//                       color: colors.primary500,
//                       shape: const StadiumBorder(),
//                     ),
//                     child: Center(
//                         child: Text(
//                       state.unreadCount?.count?.toString() ?? "",
//                       style: fonts.captionRegular.copyWith(color: colors.shade0),
//                     ))),
//               );
//             } else {
//               return const SizedBox();
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class _IntrinsicHorizontalStadium extends SingleChildRenderObjectWidget {
//   const _IntrinsicHorizontalStadium({super.child, required this.minSize});

//   final double minSize;

//   @override
//   _RenderIntrinsicHorizontalStadium createRenderObject(BuildContext context) {
//     return _RenderIntrinsicHorizontalStadium(minSize: minSize);
//   }
// }

// class _RenderIntrinsicHorizontalStadium extends RenderProxyBox {
//   _RenderIntrinsicHorizontalStadium({
//     RenderBox? child,
//     required double minSize,
//   })  : _minSize = minSize,
//         super(child);

//   double get minSize => _minSize;
//   double _minSize;

//   set minSize(double value) {
//     if (_minSize == value) {
//       return;
//     }
//     _minSize = value;
//     markNeedsLayout();
//   }

//   @override
//   double computeMinIntrinsicWidth(double height) {
//     return getMaxIntrinsicWidth(height);
//   }

//   @override
//   double computeMaxIntrinsicWidth(double height) {
//     return math.max(getMaxIntrinsicHeight(double.infinity), super.computeMaxIntrinsicWidth(height));
//   }

//   @override
//   double computeMinIntrinsicHeight(double width) {
//     return getMaxIntrinsicHeight(width);
//   }

//   @override
//   double computeMaxIntrinsicHeight(double width) {
//     return math.max(minSize, super.computeMaxIntrinsicHeight(width));
//   }

//   BoxConstraints _childConstraints(RenderBox child, BoxConstraints constraints) {
//     final double childHeight = math.max(minSize, child.getMaxIntrinsicHeight(constraints.maxWidth));
//     final double childWidth = child.getMaxIntrinsicWidth(constraints.maxHeight);
//     return constraints.tighten(width: math.max(childWidth, childHeight), height: childHeight);
//   }

//   Size _computeSize({required ChildLayouter layoutChild, required BoxConstraints constraints}) {
//     final RenderBox child = this.child!;
//     final Size childSize = layoutChild(child, _childConstraints(child, constraints));
//     if (childSize.height > childSize.width) {
//       return Size(childSize.height, childSize.height);
//     }
//     return childSize;
//   }

//   @override
//   @protected
//   Size computeDryLayout(covariant BoxConstraints constraints) {
//     return _computeSize(
//       layoutChild: ChildLayoutHelper.dryLayoutChild,
//       constraints: constraints,
//     );
//   }

//   @override
//   double? computeDryBaseline(BoxConstraints constraints, TextBaseline baseline) {
//     final RenderBox child = this.child!;
//     return child.getDryBaseline(_childConstraints(child, constraints), baseline);
//   }

//   @override
//   void performLayout() {
//     size = _computeSize(
//       layoutChild: ChildLayoutHelper.layoutChild,
//       constraints: constraints,
//     );
//   }
// }
