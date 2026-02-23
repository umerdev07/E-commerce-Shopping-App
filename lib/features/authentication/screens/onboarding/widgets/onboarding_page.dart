import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/helpers/device_helper.dart';

class onBoardingPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;

  const onBoardingPage({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: UDeviceHelper.getAppBarHeight(),
      ),
      child: Column(
        children: [
          Lottie.asset(image),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center ,
          ),
          Text(subTitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
