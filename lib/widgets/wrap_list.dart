import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd/utils/themes.dart';

class WrapList extends StatefulWidget {
  final dynamic listData;
  final Function(String) onItemTap;
  const WrapList({
    super.key,
    required this.listData,
    required this.onItemTap,
  });

  @override
  State<WrapList> createState() => _WrapListState();
}

class _WrapListState extends State<WrapList> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    Size size = MediaQuery.sizeOf(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: List.generate(widget.listData.length, (index) {
              var data = widget.listData[index];

              // Calculate item width based on orientation
              final itemWidth = isPortrait
                  ? size.width - 32 // Account for padding
                  : (size.width / 2.2);

              return WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromRight(
                        delay: Duration(milliseconds: index * 100)),
                child: GestureDetector(
                  onTap: () => widget.onItemTap(data["title"]),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            data["image"],
                            height: 154.0,
                            width: itemWidth,
                            fit: BoxFit.fitWidth,
                          ),
                          Container(
                            height: 154.0,
                            width: itemWidth,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Themes.kTransparent,
                                    Themes.kBlackColor.withOpacity(0.9)
                                  ],
                                  stops: const [
                                    0.5,
                                    1.0
                                  ]),
                            ),
                          ),
                          Positioned(
                            left: 14.0,
                            bottom: 14.0,
                            child: Text(
                              "${data["title"]}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Themes.kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
