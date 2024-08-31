import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/online_play/online_play_menu_screen.dart';
import 'package:tic_tac_toe/screens/set_multiplayer_game.dart';
import 'package:tic_tac_toe/screens/settings_page.dart';
import 'package:tic_tac_toe/screens/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/utils/text_style_utils.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2053),
      appBar: AppBar(
        title: Text('Tic-Tac-Toe Menu', style: TextStyles.cavetBold(fontSize: 24, color: Colors.white)),
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
          'Single Player',
          Colors.blueAccent,
              () {

                _showComingSoonSnackBar(context);

              },
          'assets/images/single_player.png',
        ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Multi Player',
              Colors.blueAccent,
                  () {


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetMultiPlayerGame(),
                      ),
                    );

                  },
              'assets/images/multiplayer.png',
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Online Play',
              Colors.blueAccent,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnlinePlayMenuScreen(),
                      ),
                    );
              },
              'assets/images/online.png',
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              'Settings',
              Colors.blueAccent,
                  () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
              },
              'assets/images/settings.png',
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
