import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContentBox extends StatelessWidget {
  final BoxDecoration? decoration;
  final String? text;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool? isAnimated;
  final Duration? animationDuration;

  const ContentBox({
    Key? key,
    this.decoration,
    this.text,
    this.width,
    this.height,
    this.padding,
    this.isAnimated = false,
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAnimated == true
        ? AnimatedContainer(
            width: width ?? 90.0.w.clamp(400.0, 600.0),
            height: height ?? 300.0,
            padding: padding,
            decoration: decoration ?? defaultBoxDecoration,
            curve: Curves.decelerate,
            duration: animationDuration ?? const Duration(milliseconds: 300),
            child: Center(
              child: Text(
                text ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          )
        : Container(
            width: width ?? 90.0.w.clamp(400.0, 600.0),
            height: height ?? 300.0,
            padding: padding,
            decoration: decoration ?? defaultBoxDecoration,
            child: Center(
              child: Text(
                text ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          );
  }
}

extension DefaultContentBoxDecoration on ContentBox {
  get defaultBoxDecoration => BoxDecoration(
        color: const Color(0xFF6166B3),
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 5.0,
            offset: const Offset(
              1.0,
              1.0,
            ),
          )
        ],
      );
}
