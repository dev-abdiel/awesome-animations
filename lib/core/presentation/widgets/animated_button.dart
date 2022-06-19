import 'package:flutter/material.dart';

import '../../core.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    required this.text,
    this.height = 60,
    this.width = 300,
    this.color,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;

  /// By default use `AppColors.brownPurple`
  final Color? color;
  final BorderRadius? borderRadius;
  final void Function()? onTap;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  late final ValueNotifier<bool> _hasFocus;
  late BorderRadius borderRadius;

  @override
  void initState() {
    _hasFocus = ValueNotifier(false);
    borderRadius = widget.borderRadius ?? BorderRadius.circular(25);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedButton oldWidget) {
    if (widget != oldWidget) {
      borderRadius = widget.borderRadius ?? BorderRadius.circular(25);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _hasFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.height,
      width: widget.width,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hasFocus,
        builder: (context, hasFocus, _) => AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: (hasFocus) ? 0.90 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.brownPurple,
              borderRadius: borderRadius,
            ),
            child: InkWell(
              onTap: widget.onTap,
              onHighlightChanged: (value) => _hasFocus.value = value,
              borderRadius: borderRadius,
              splashFactory: NoSplash.splashFactory,
              child: Center(
                child: Text(widget.text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
