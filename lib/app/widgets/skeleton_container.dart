import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color? color;
  const SkeletonContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.color,
  }) : super(key: key);

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.color,
  });

  const SkeletonContainer.square({
    required double width,
    required double height,
    Color? color,
  }) : this._(width: width, height: height, color: color);

  const SkeletonContainer.rounded({
    required double width,
    required double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
    Color? color,
  }) : this._(
            width: width,
            height: height,
            borderRadius: borderRadius,
            color: color);

  SkeletonContainer.circular({
    required double width,
    required double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
    Color? color,
  }) : this._(
            width: width,
            height: height,
            borderRadius: borderRadius,
            color: color);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Colors.grey[300],
            borderRadius: borderRadius,
          ),
        ),
      );
}
