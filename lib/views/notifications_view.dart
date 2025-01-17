import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/themes.dart';

import 'package:kedasrd/widgets/custom_header.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CustomHeader(title: "Notifications"),
            bodyView(),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(8, (index) {
          return WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                delay: Duration(milliseconds: index * 200)),
            child: Container(
              margin:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Themes.kWhiteColor,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Themes.kBlackColor.withOpacity(0.20),
                    blurRadius: 8.0,
                    spreadRadius: -3,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Text(
                "Order #14133${index + 2} in restaurant and fastfood pos has been deleted it exceeded the limit of 48 hours",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Themes.kBlackColor,
                ),
              ),
            ),
          );
        })),
      ),
    );
  }
}
