import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 576;

bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 576 &&
    MediaQuery.of(context).size.width <= 992;

bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width > 992;

extension WidgetX on Widget {
  Widget centerWidget(BuildContext context) {
    if (!isDesktop(context)) {
      return Center(child: this);
    } else {
      return this;
    }
  }

  Widget paddingMobile(BuildContext context, double vertical, horizontal) {
    if (!isDesktop(context)) {
      ScreenUtil.init(
        context,
        minTextAdapt: true,
        designSize: const Size(1920.0, 884),
      );
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );
    } else {
      return this;
    }
  }

  Widget paddingDesk(BuildContext context, double vertical, horizontal) {
    if (isDesktop(context)) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );
    } else {
      return this;
    }
  }
}
