import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AnimatedPress extends StatefulWidget {
  const AnimatedPress({
    super.key,
    required this.child,
    this.onTap,
    this.scaleAmount = 0.94,
    this.duration = const Duration(milliseconds: 140),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleAmount;
  final Duration duration;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleAmount)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
            reverseCurve: Curves.easeOutBack,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      _controller.reverse();
      widget.onTap!();
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) =>
            Transform.scale(scale: _scaleAnimation.value, child: child),
        child: widget.child,
      ),
    );
  }
}

class DcAnimatedButton extends StatefulWidget {
  const DcAnimatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.height = 56,
    this.width,
    this.gradient,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final double height;
  final double? width;
  final Gradient? gradient;
  final Color? backgroundColor;

  @override
  State<DcAnimatedButton> createState() => _DcAnimatedButtonState();
}

class _DcAnimatedButtonState extends State<DcAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _iconPulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _iconPulse = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGradient =
        widget.gradient ??
        const LinearGradient(
          colors: [DcColors.primary, DcColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    return AnimatedPress(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          gradient: widget.backgroundColor == null ? effectiveGradient : null,
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.height / 2),
          boxShadow: [
            BoxShadow(
              color: (widget.backgroundColor ?? DcColors.primary).withValues(
                alpha: 0.35,
              ),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  AnimatedBuilder(
                    animation: _iconPulse,
                    builder: (context, child) => Transform.scale(
                      scale: _iconPulse.value,
                      child: Icon(widget.icon, color: Colors.white, size: 23),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label,
                  style: dc(16, weight: FontWeight.w700, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
