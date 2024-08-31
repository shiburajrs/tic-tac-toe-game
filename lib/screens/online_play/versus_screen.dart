import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/tic_tac_toe_board.dart';

import '../../core/share_pref_constants.dart';
import '../../core/shared_pref_utils.dart';
import '../../utils/text_style_utils.dart';

class VersusScreen extends StatefulWidget {
  @override
  _VersusScreenState createState() => _VersusScreenState();
}

class _VersusScreenState extends State<VersusScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isMusicOn = true;
  @override
  void initState() {
    super.initState();
    _loadMusicState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start the fade-in animation
    _controller.forward();


    Future.delayed(Duration(seconds: 4), () {
      audioPlayer.stop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TicTacToeBoard(mode: 'multiplayer')));
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Color(0xffb62c22),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Color(0xff2879BA),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'You',
                        style: TextStyles.regular(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'VS',
                      style: TextStyles.cavetBold(fontSize: 35, color: Colors.white),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/premium-photo/bearded-man-illustration_665280-67044.jpg',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Opponent',
                        style: TextStyles.regular(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMusicState() async {
    bool? isMusicOnValue =
    SharedPrefsManager().get<bool>(SharePrefConstants.IS_MUSIC_ON, true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isMusicOn = isMusicOnValue ?? true;
      });
    });
    //   isMusicOn = isMusicOnValue ?? true;
  }
}
