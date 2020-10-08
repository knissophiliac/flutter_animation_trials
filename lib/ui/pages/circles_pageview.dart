import 'package:animtrials/ui/widgets/tutorial_page.dart';
import 'package:flutter/material.dart';

const double radius = 80.0;
const Color firstColor = Color.fromRGBO(41, 239, 162, 1);
const Color secondColor = Colors.white;

class CirclesPageView extends StatefulWidget {
  @override
  _CirclesPageViewState createState() => _CirclesPageViewState();
}

class _CirclesPageViewState extends State<CirclesPageView>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation startAnimation;
  Animation endAnimation;
  Animation horizontalAnimation;

  PageController _pageController;
  Color fgColor = firstColor;
  Color bgColor = secondColor;

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
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
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
    });
    index++;
    if (index >= 3) {
      index = 0;
    }
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuad);
    _controller.forward();
  }

  swapColors() {
    if (isToggled) {
      setState(() {
        bgColor = firstColor;
        fgColor = Colors.white;
      });
    } else {
      setState(() {
        bgColor = Colors.white;
        fgColor = firstColor;
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
            left: width / 2 - (radius / 2),
            child: Container(
              color: isInHalfWay ? fgColor : bgColor,
              width: width / 2 + (radius / 2),
            ),
          ),
          Transform(
              transform: Matrix4.identity()
                ..translate(
                  width / 2 - radius / 2.0,
                  height - radius - 50,
                ),
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
                        tween: Tween<double>(begin: 1.0, end: radius),
                        flip: 1.0,
                      ),
                      AnimatedCircle(
                        animation: endAnimation,
                        color: bgColor,
                        iconColor: fgColor,
                        tween: Tween<double>(begin: radius, end: 1.0),
                        flip: -1.0,
                        horizontalAnimation: horizontalAnimation,
                        horizontalTween: Tween<double>(begin: 0, end: -radius),
                      ),
                    ],
                  ))),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 180,
            child: PageView(
              controller: _pageController,
              children: [
                TutorialPage(
                  title: "Otobüs beklemekten sıkıldınız mı?",
                  titleColor: isInHalfWay ? bgColor : fgColor,
                  assetName: "assets/images/bored_at_station_new.png",
                ),
                TutorialPage(
                  title:
                      "Aracınızda \nsohbet edecek birileri olsun \nister miydiniz?",
                  titleColor: isInHalfWay ? bgColor : fgColor,
                  assetName: "assets/images/bored_at_car_new.png",
                ),
                TutorialPage(
                  title:
                      "Artık otostapp var!\nNereye gitmek istediğini seç.\nHepsi bu!",
                  titleColor: isInHalfWay ? bgColor : fgColor,
                  assetName: "assets/images/found_app.png",
                ),
                TutorialPage(
                  title: "Güvenliğinizi önemsiyoruz!",
                  titleColor: isInHalfWay ? bgColor : fgColor,
                  assetName: "assets/images/care_about_security.png",
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
  final Tween<double> tween;
  final double flip;
  final Tween<double> horizontalTween;

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
              radius / 2.0 - tween.evaluate(animation) / (radius / 2.0),
            ),
          ),
          width: radius,
          height: radius,
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
