import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/tic_tac_toe_board.dart';

import '../utils/text_style_utils.dart';

class SetMultiPlayerGame extends StatefulWidget {
  const SetMultiPlayerGame({super.key});

  @override
  _SetMultiPlayerGameState createState() => _SetMultiPlayerGameState();
}

class _SetMultiPlayerGameState extends State<SetMultiPlayerGame> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2053),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Enter Player Names', style: TextStyles.cavetBold(fontSize: 24, color: Colors.white)),
        backgroundColor: const Color(0xff1d2053),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNameInputField('Player 1', _player1Controller),
            const SizedBox(height: 20),
            _buildNameInputField('Player 2', _player2Controller),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Start Game', style: TextStyles.medium(fontSize: 14, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInputField(String playerName, TextEditingController controller) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: TextField(
        style: TextStyles.medium(fontSize: 16, color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter $playerName\'s name',
          hintStyle: TextStyles.regular(fontSize: 16, color: Colors.grey.withOpacity(0.6)),
        ),
      ),
    );
  }

  void _startGame() {
    final player1Name = _player1Controller.text.trim();
    final player2Name = _player2Controller.text.trim();

    if (player1Name.isEmpty || player2Name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter names for both players.',
            style: TextStyles.regular(fontSize: 14, color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );

      return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TicTacToeBoard(mode: 'multiplayer',player1Name: _player1Controller.text, player2Name: _player2Controller.text)));

  }
}
