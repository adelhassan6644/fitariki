import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedWidgets extends StatelessWidget {
  final Widget? child;
  final double? verticalOffset;
  final double? horizontalOffset;
  final double? durationMilli;

  const AnimatedWidgets(
      {Key? key,
      this.child,
      this.verticalOffset,
      this.horizontalOffset,
      this.durationMilli})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 2,
      duration: Duration(
          milliseconds: durationMilli != null ? durationMilli!.toInt() : 500),
      child: SlideAnimation(
        curve: Curves.easeInOut,
        horizontalOffset: horizontalOffset ?? 0,
        verticalOffset: verticalOffset ?? 50,
        child: FadeInAnimation(
          child: child!,
        ),
      ),
    );
  }
}

class ListAnimator extends StatefulWidget {
  final List<Widget>? data;
  final int? durationMilli;
  final double? verticalOffset;
  final double? horizontalOffset;
  final ScrollController? controller;
  final Axis? direction;
  final bool addPadding;
  final EdgeInsetsGeometry? customPadding;

  const ListAnimator({
    this.controller,
    Key? key,
    this.data,
    this.durationMilli,
    this.verticalOffset,
    this.horizontalOffset,
    this.direction,
    this.addPadding = false,
    this.customPadding,
  }) : super(key: key);

  @override
  State<ListAnimator> createState() => _ListAnimatorState();
}

class _ListAnimatorState extends State<ListAnimator> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: widget.controller,
        padding: widget.customPadding ??
            EdgeInsets.only(top: widget.addPadding ? 12.h : 0),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: widget.direction ?? Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: widget.durationMilli ?? 375),
              child: SlideAnimation(
                  verticalOffset: widget.verticalOffset ?? 0.0,
                  child: FadeInAnimation(child: widget.data![index])));
        },
        itemCount: widget.data!.length,
      ),
    );
  }
}
