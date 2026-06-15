import 'package:flutter/material.dart';

class LiveIndicator extends StatefulWidget {
  final String timeElapsed;
  const LiveIndicator({super.key, required this.timeElapsed});

  @override
  State<LiveIndicator> createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<LiveIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: 1.0, end: 0.2).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  } 

   @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      AnimatedBuilder(
        animation: _opacity,
        builder: (_, __) => Opacity(
          opacity: _opacity.value,
          child: Container(
            width: 7, height: 7,
            decoration: const BoxDecoration(color: AppColors.live, shape: BoxShape.circle),
          ),
        ),
      ),
      const SizedBox(width: 5),
      Text(
        widget.timeElapsed == 'HT' ? 'HT' : "${widget.timeElapsed}'",
        style: AppTextStyles.labelLarge.copyWith(color: AppColors.live, fontSize: 13),
      ),
    ],
  );
}
