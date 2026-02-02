import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingWidget({
    super.key,
    required this.color,
    this.size = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
