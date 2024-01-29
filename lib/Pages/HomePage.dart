import 'dart:async';
import 'dart:ui';

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
  final ScrollController _Scrollcontroller = ScrollController();
  double _ScrollOpacity = 1.0;
  @override
  void initState() {
    super.initState();
    _Scrollcontroller.addListener(_scrollListener);

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
    _Scrollcontroller.removeListener(_scrollListener);
    _Scrollcontroller.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _updateHoverState(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }

  void _scrollListener() {
    setState(() {
      // Example: Fade out when scrolling down
      _ScrollOpacity = (_Scrollcontroller.offset > 100) ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _Scrollcontroller,
      child: AnimatedBuilder(
        animation: _Scrollcontroller,
        builder: (context, child) {
          return Opacity(
            opacity: _ScrollOpacity,
            child: CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: StarsPainter(
                  isHovered:
                      isHovered), // You need to define BackgroundPainter class
              child: Column(
                children: [
                  SizedBox(
                    height: 600,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // Background Stars
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: CustomPaint(
                            size: Size(double.infinity, double.infinity),
                            painter: StarsPainter(isHovered: isHovered),
                          ),
                        ),

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
                          heightFactor: .5,
                          alignment: Alignment.centerLeft,
                          widthFactor: .4,
                          child: MouseRegion(
                            onEnter: (_) => _updateHoverState(false),
                            onExit: (_) => _updateHoverState(true),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
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
                                          "Hello!".substring(
                                              0, _textAnimation.value),
                                          style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            color: isHovered
                                                ? Color.fromARGB(
                                                    255, 42, 152, 243)
                                                : Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                    AnimatedBuilder(
                                      animation: _textAnimation2,
                                      builder: (context, child) {
                                        return RichText(
                                          text: TextSpan(
                                            text:
                                                "Welcome To Gaurav's Space Walk"
                                                    .substring(
                                                        0,
                                                        min(
                                                            _textAnimation2
                                                                .value,
                                                            30)),
                                            style: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(80),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: .5,
                      child: Container(
                        height: 800,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Color.fromARGB(255, 5, 6, 49).withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Welcome to My Portfolio!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Hey there! I'm Gaurav, a software developer who loves building cool stuff. I've been at it for about 1.8 years now and have tried my hand at a bunch of things.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Here's What I Do:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                """🛰️-  I make Android apps using Java. You know, those little programs you use on your phone? Yup, I make those. """,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                """🛰️-  I've also dabbled in React Native, which lets me build mobile apps that work on both Android and iOS. It's like killing two birds with one stone!""",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                """🛰️-  For the web, I'm all about React and Next.js. They help me create websites that load super fast and show up high on Google. Pretty neat, right? .""",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                """🛰️-  Ever heard of Flutter? It's this cool thing from Google that lets me build apps for mobile, web, and even desktop, all from one place. Saves me a ton of time! """,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                """🛰️-  Oh, and I'm not just a frontend guy. I also do backend stuff with Node.js and MongoDB. That's the behind-the-scenes magic that makes everything work smoothly.""",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Why Pick Me:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "I'm all about teamwork and making cool things happen. Whether it's making an app look pretty or building the engine that runs it, I'm up for the challenge. So, if you've got a project in mind or just want to chat tech, hit me up! Let's make something awesome together.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hey there! I\'m [Your Name], a software developer who loves building cool stuff. I\'ve been at it for about 1.8 years now and have tried my hand at a bunch of things.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Here\'s What I Do:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'I make Android apps using Java. You know, those little programs you use on your phone? Yup, I make those.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            // Add more text for other skills/services
          ],
        ),
      ),
    );
  }
}

// Custom painter for drawing stars
class StarsPainter extends CustomPainter {
  final bool isHovered;

  StarsPainter({required this.isHovered});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final starPaint = Paint()
      ..color = Colors.white
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5);

    final starBluePaint = Paint()
      ..color = Colors.blue.shade500
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5);

    final glowPaint = Paint()
      ..color = AppColors.astronautOrange // Adjust glow opacity here
      ..maskFilter =
          MaskFilter.blur(BlurStyle.solid, 5); // Adjust glow size here

    // Draw static stars
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1.0; // Varying star sizes

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1 + 1.0; // Varying star sizes

      canvas.drawCircle(Offset(x, y), radius, starBluePaint);
    }

    // Draw glowing stars if hovered
    if (isHovered) {
      for (int i = 0; i < 20; i++) {
        final x = random.nextDouble() * size.width;
        final y = random.nextDouble() * size.height;
        final radius = random.nextDouble() * 2 + 1.0; // Varying star sizes

        canvas.drawCircle(Offset(x, y), radius, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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
