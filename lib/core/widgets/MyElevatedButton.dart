import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadiusGeometry;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final double marginHorizontal;
  final double marginVertical;
  final BorderSide borderSide;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 44.0,
    this.borderRadiusGeometry,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    this.borderSide = const BorderSide(color: Colors.transparent),
    this.gradient =
        const LinearGradient(colors: [Colors.transparent, Colors.transparent]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadiusGeometry =
        this.borderRadiusGeometry ?? BorderRadius.circular(0);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadiusGeometry,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // primary: Colors.transparent,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadiusGeometry),
          side: borderSide,
        ),
        child: child,
      ),
    );
  }
}
