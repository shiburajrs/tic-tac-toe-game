import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/online_play/versus_screen.dart';

import '../../utils/text_style_utils.dart';

class SearchOpponentAnimation extends StatefulWidget {
  @override
  _SearchOpponentAnimationState createState() =>
      _SearchOpponentAnimationState();
}

class _SearchOpponentAnimationState extends State<SearchOpponentAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  final List<String> _imageUrls = [
    'https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
    'https://img.freepik.com/premium-photo/bearded-man-illustration_665280-67044.jpg', // Add more image URLs
    'https://img.freepik.com/premium-photo/profile-icon-white-background_941097-162075.jpg',
  ];
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );


    Future.delayed(Duration(seconds: 2), _changeImage);


    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VersusScreen()));
    });
  }

  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageUrls.length;
    });
    Future.delayed(Duration(seconds: 2), _changeImage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2053),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated circles
                    Container(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: List.generate(5, (index) {
                              double scale = 1 + index * 0.2;
                              double opacity = 1 - (index * 0.2);
                              double progress = (_controller.value + (index * 0.2)) % 1;
                              return Transform.scale(
                                scale: scale,
                                child: Opacity(
                                  opacity: opacity,
                                  child: Container(
                                    width: 250.0 * progress,
                                    height: 250.0 * progress,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.blue.withOpacity(0.5),
                                        width: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    // Static image with opacity animation
                    Positioned(
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            _imageUrls[_currentImageIndex],
                            width: 80.0, // Set the size of your image
                            height: 80.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),



      ),
    );
  }
}
