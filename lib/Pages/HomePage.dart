import 'package:flutter/material.dart';
import 'package:portfolio/Components/NavBar.dart';
import 'package:portfolio/Utils/ResponsiveLayout.dart';
import 'package:portfolio/Utils/ThemeUI.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("../Assets/Images/spaceSky1.jpg"),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(colors: [
            Color.fromARGB(239, 3, 1, 24),
            Color.fromARGB(255, 0, 0, 0),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[NavBar(), Body()],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
      mediumScreen: Container(),
    );
  }
}

class LargeChild extends StatefulWidget {
  @override
  _LargeChildState createState() => _LargeChildState();
}

class _LargeChildState extends State<LargeChild>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _textAnimation;
  late Animation<int> _textAnimation2;
  late Animation<double> _imageAnimation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    _textAnimation = IntTween(begin: 0, end: 6).animate(_controller);
    _textAnimation2 = IntTween(begin: 0, end: 31).animate(_controller);
    _imageAnimation =
        Tween<double>(begin: isHovered ? 0 : 5, end: 15).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateHoverState(bool hover) {
    setState(() {
      isHovered = hover;
      // if (isHovered) {
      //   _controller.forward();
      // } else {
      //   _controller.reverse();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 600,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: .5,
              child: AnimatedBuilder(
                animation: _imageAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(12, _imageAnimation.value),
                    child: Image.network(
                      "../Assets/Images/spaceship_Img.png",
                      scale: .85,
                    ),
                  );
                },
              ),
            ),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: .4,
              child: Padding(
                padding: EdgeInsets.only(left: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _textAnimation,
                      builder: (context, child) {
                        return Text(
                          "Hello!".substring(0, _textAnimation.value),
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat-Regular",
                            color: isHovered
                                ? AppColors.cosmicBlue
                                : AppColors.starrySilver,
                          ),
                        );
                      },
                    ),
                    MouseRegion(
                      onEnter: (_) => _updateHoverState(false),
                      onExit: (_) => _updateHoverState(true),
                      child: AnimatedBuilder(
                        animation: _textAnimation2,
                        builder: (context, child) {
                          return RichText(
                            text: TextSpan(
                              text: "Welcome To Gaurav's Space Walk"
                                  .substring(0, min(_textAnimation2.value, 30)),
                              style:
                                  TextStyle(fontSize: 60, color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                    // if (!isHovered)
                    //   Padding(
                    //     padding: const EdgeInsets.only(left: 12.0, top: 20),
                    //     child: Text(
                    //       "LET’S EXPLORE THE Universe",
                    //       style: TextStyle(
                    //         fontSize: 60,
                    //         fontWeight: FontWeight.bold,
                    //         fontFamily: "Montserrat-Regular",
                    //         color: isHovered
                    //             ? AppColors.cosmicBlue
                    //             : AppColors.starrySilver,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500,
              width: 300,
            )
          ],
        ),
      ),
    );
  }
}

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello!",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat-Regular"),
            ),
            RichText(
              text: TextSpan(
                text: 'WellCome To ',
                style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Britu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black87)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text("LET’S EXPLORE THE WORLD"),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.network(
                "../Assets/Images/spaceship_Img.png",
                scale: 1,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            // Search(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
