import 'package:animtrials/ui/widgets/tutorial_page.dart';
import 'package:flutter/material.dart';

class CirclesPageView extends StatefulWidget {
  @override
  _CirclesPageViewState createState() => _CirclesPageViewState();
}

class _CirclesPageViewState extends State<CirclesPageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation startAnimation;
  Animation endAnimation;
  Animation horizontalAnimation;

  PageController _pageController;
  Color fgColor = Colors.indigo;
  Color bgColor = Colors.white;

  int index = 0;
  bool isInHalfWay = false;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    startAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );
    endAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.500, 1.000, curve: Curves.easeInExpo),
    );
    horizontalAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          swapColors();
          _controller.reset();
        }
      })
      ..addListener(() {
        if (_controller.value > 0.5) {
          setState(() {
            isInHalfWay = true;
          });
        } else {
          setState(() {
            isInHalfWay = false;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  goNext() {
    setState(() {
      isToggled = !isToggled;
      index++;
      if (index > 3) {
        index = 0;
      }
    });
    _controller.forward(from: 0.0);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
  }

  swapColors() {
    if (isToggled) {
      setState(() {
        bgColor = Colors.white;
        fgColor = Colors.indigo;
      });
    } else {
      setState(() {
        bgColor = Colors.indigo;
        fgColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isInHalfWay ? fgColor : bgColor,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: width / 2 - 40,
            child: Container(
              color: isInHalfWay ? fgColor : bgColor,
              width: width / 2 + 40,
            ),
          ),
          Positioned(
              bottom: 40,
              child: GestureDetector(
                  onTap: () {
                    print("onTap");
                    if (_controller.status != AnimationStatus.forward) {
                      goNext();
                    }
                  },
                  child: Stack(
                    children: [
                      AnimatedCircle(
                        animation: startAnimation,
                        color: fgColor,
                        iconColor: bgColor,
                        tween: Tween<double>(begin: 1.0, end: 80.0),
                        flip: 1.0,
                      ),
                      AnimatedCircle(
                        animation: endAnimation,
                        color: bgColor,
                        iconColor: fgColor,
                        tween: Tween<double>(begin: 80.0, end: 1.0),
                        flip: -1.0,
                        horizontalAnimation: horizontalAnimation,
                        horizontalTween: Tween<double>(begin: 0, end: -80.0),
                      ),
                    ],
                  ))),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 200,
            child: PageView(
              controller: _pageController,
              children: [
                TutorialPage(
                  title: "Local News\nStories",
                  titleColor: fgColor,
                  icon: Icons.add_road,
                ),
                TutorialPage(
                  title: "Drag and Drop\nto move",
                  titleColor: bgColor,
                  icon: Icons.smart_button,
                ),
                TutorialPage(
                  title: "Choose your interests",
                  titleColor: fgColor,
                  icon: Icons.star_outline,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedCircle extends AnimatedWidget {
  final Animation<double> animation;
  final Animation<double> horizontalAnimation;
  final Color color;
  final Color iconColor;
  final Tween tween;
  final double flip;
  final Tween horizontalTween;

  const AnimatedCircle(
      {Key key,
      @required this.animation,
      @required this.color,
      @required this.iconColor,
      @required this.tween,
      @required this.flip,
      this.horizontalAnimation,
      this.horizontalTween})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..scale(tween.evaluate(animation) * flip, tween.evaluate(animation)),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(horizontalTween == null
              ? 0.0
              : horizontalTween.evaluate(horizontalAnimation)),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                  80 / 2 - tween.evaluate(animation) / 40)),
          width: 80,
          height: 80,
          child: Icon(
            flip == 1 ? Icons.navigate_next : Icons.navigate_before,
            size: 38,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
