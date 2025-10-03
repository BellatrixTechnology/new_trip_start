import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  final double maxRadius;
  final int numberOfRipples;
  final Widget? child;

  const RippleAnimation({
    super.key,
    this.size = 80.0,
    this.color = Colors.blue,
    this.duration = const Duration(milliseconds: 2000),
    this.maxRadius = 100.0,
    this.numberOfRipples = 3,
    this.child,
  });

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.numberOfRipples,
      (index) => AnimationController(
        vsync: this,
        duration: widget.duration,
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Start animations with delays
    for (var i = 0; i < _animationControllers.length; i++) {
      Future.delayed(
          Duration(
              milliseconds: i *
                  (widget.duration.inMilliseconds ~/ widget.numberOfRipples)),
          () {
        if (mounted) {
          _animationControllers[i].repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size + (widget.maxRadius * 2),
        height: widget.size + (widget.maxRadius * 2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.child != null) widget.child!,
            ..._animations.map((animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Container(
                    width: widget.size * animation.value +
                        (widget.maxRadius * 2 * animation.value),
                    height: widget.size * animation.value +
                        (widget.maxRadius * 2 * animation.value),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withOpacity(1 - animation.value),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
