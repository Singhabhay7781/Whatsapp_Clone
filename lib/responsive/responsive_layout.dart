import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLaytout,
    required this.webScreenLaytout,
  });
  final Widget webScreenLaytout;
  final Widget mobileScreenLaytout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 900) {
        //web screen
        return webScreenLaytout;
      } else {
        //mobile screen
        return mobileScreenLaytout;
      }
    });
  }
}
