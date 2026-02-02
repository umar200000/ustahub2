import 'package:flutter/material.dart';

class BackgroundGrid extends StatefulWidget {
  final dynamic colors;

  const BackgroundGrid({super.key, required this.colors});

  @override
  State<BackgroundGrid> createState() => _BackgroundGridState();
}

class _BackgroundGridState extends State<BackgroundGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Color> gridColors = [
    const Color(0xFF8B7355),
    const Color(0xFF5F7A6E),
    const Color(0xFFB5838D),
    const Color(0xFFD4A574),
    const Color(0xFF4A5568),
    const Color(0xFF6B8E7F),
    const Color(0xFFC19A6B),
    const Color(0xFFE8C4A0),
  ];

  final List<IconData> serviceIcons = [
    Icons.handyman,
    Icons.plumbing,
    Icons.cleaning_services,
    Icons.electrical_services,
    Icons.hvac,
    Icons.format_paint,
    Icons.construction,
    Icons.build,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25), // Tezlikni shu yerdan sozlang
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 180.0;
    const double spacing = 8.0;
    const double totalItemHeight = itemHeight + spacing;

    // Bitta to'liq sikl balandligi (8 ta element)
    final double cycleHeight = gridColors.length * totalItemHeight;

    return ClipRect(
      child: Row(
        children: [
          // 1-ustun: Pastdan tepaga cheksiz yuradi
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // 0 dan -cycleHeight gacha suriladi
                return Transform.translate(
                  offset: Offset(0, -_controller.value * cycleHeight),
                  child: _buildInfiniteColumn(
                    itemHeight: itemHeight,
                    spacing: spacing,
                    isReverse: false,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          // 2-ustun: Tepadan pastga cheksiz yuradi
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // -cycleHeight dan 0 gacha suriladi
                return Transform.translate(
                  offset: Offset(0, (_controller.value - 1) * cycleHeight),
                  child: _buildInfiniteColumn(
                    itemHeight: itemHeight,
                    spacing: spacing,
                    isReverse: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfiniteColumn({
    required double itemHeight,
    required double spacing,
    required bool isReverse,
  }) {
    // Cheksiz tuyulishi uchun elementlarni 3 marta takrorlaymiz
    final int repeatCount = 3;
    final List<int> items = List.generate(
      gridColors.length * repeatCount,
      (index) => index % gridColors.length,
    );

    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: double.infinity, // Overflow xatosini oldini oladi
      child: Column(
        children: items.map((index) {
          // Ikkinchi ustun uchun ranglarni biroz suramiz (shaxmat tartibi uchun)
          final actualIndex = isReverse
              ? (index + 2) % gridColors.length
              : index;

          return Container(
            margin: EdgeInsets.only(bottom: spacing),
            height: itemHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: gridColors[actualIndex],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(
                serviceIcons[actualIndex],
                size: 64,
                color: widget.colors.shade100.withOpacity(0.2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
