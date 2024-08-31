import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/online_play/freind_list_screen.dart';
import 'package:tic_tac_toe/screens/online_play/leaderboard.dart';
import 'package:tic_tac_toe/screens/online_play/search_opponent_screen.dart';
import 'package:tic_tac_toe/utils/text_style_utils.dart'; // Ensure this path is correct

class OnlinePlayMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2053),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Online game play', style: TextStyles.cavetBold(fontSize: 24, color: Colors.white)),
        backgroundColor: const Color(0xff1d2053),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMenuButton(
              context,
              'Quick match',
              Colors.blueAccent,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchOpponentAnimation(), // or 'multiplayer'
                      ),
                    );
              },
              'assets/images/gameplay.png',
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Play with friends',
              Colors.blueAccent,
                  () {


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendsListScreen(),
                      ),
                    );

              },
              'assets/images/play_with_friends.png',
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Leaderboard',
              Colors.blueAccent,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderboardScreen(),
                      ),
                    );
              },
              'assets/images/leader_board.png',
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, Color color, VoidCallback onPressed, String imagePath) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyles.regular(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  void _showComingSoonSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Coming Soon!', style: TextStyles.regular(color: Colors.white, fontSize: 12)),
        backgroundColor: Color(0xFF007BFF),
        duration: Duration(seconds: 2),
      ),
    );
  }

}
