import 'package:flutter/material.dart';
import 'package:scroll_demo/content_box.dart';
import 'package:scroll_demo/random_colour_generator.dart';
import 'package:sizer/sizer.dart';

class MainContent extends StatefulWidget {
  final DeviceType deviceType;
  const MainContent({
    Key? key,
    required this.deviceType,
  }) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  // In practice, the height of the animated content box
  // is never going to reach zero as long as it contains children
  // that take up some space.
  // If this is the sort of behaviour that you're looking for,
  // you could wrap the animated ContentBox with an AnimatedCrossFade widget
  // and add a SizedBox as second child, with a pre-defined small height
  // otherwise the rest of the content will "jump up" as you scroll down
  static const double _animationLowerBound = 0.0;

  // Maximum height of the animated content box
  static const double _animationUpperBound = 300.0;

  // "Aggressiveness" of the animation
  static const double _offsetRate = 3.0;

  final ScrollController _scrollController = ScrollController();

  final _contentListColours = List.generate(
    10,
    (index) => RandomColourGenerator.generate(),
  );

  double _dismissibleContentHeight = _animationUpperBound;

  @override
  Widget build(BuildContext context) {
    final isTablet = widget.deviceType == DeviceType.tablet;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.0.h,
                  ),
                  // If you wish to see how it behaves without being animated,
                  // simply set isAnimated to false and height to _animationUpperBound
                  child: ContentBox(
                    text: 'Dismissible on scroll',
                    width: isTablet ? 80.0.w : 300.0,
                    isAnimated: true,
                    height: _dismissibleContentHeight,
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 3.0.h,
                    bottom: 3.0.h,
                  ),
                  child: ContentBox(
                    text: 'Some content',
                    width: isTablet ? 80.0.w : 300.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  10,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.0.h,
                    ),
                    child: ContentBox(
                      text: 'Some more content',
                      width: isTablet ? 80.0.w : 300.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                        color: _contentListColours[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateDismissibleContentHeight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateDismissibleContentHeight);
  }

  void _updateDismissibleContentHeight() {
    // Forward: Up
    // Reverse: Down
    // final scrollDirection = _scrollController.position.userScrollDirection;
    final verticalOffset = _scrollController.offset;

    // Threshold to start dismissing or sliding the content box back into view
    if ((verticalOffset >= 2.0.h &&
            _dismissibleContentHeight != _animationLowerBound) ||
        (verticalOffset <= _animationUpperBound &&
            _dismissibleContentHeight < _animationUpperBound)) {
      final newHeight =
          (_animationUpperBound - verticalOffset * _offsetRate).clamp(
        _animationLowerBound,
        _animationUpperBound,
      );
      setState(() {
        _dismissibleContentHeight = newHeight;
      });
    }
  }
}
