
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/text_style_utils.dart';

import '../core/share_pref_constants.dart';
import '../core/shared_pref_utils.dart';
import '../utils/custom_alert_dialog.dart'; // Ensure this path is correct

class TicTacToeBoard extends StatefulWidget {
  final String mode;
  final String player1Name;
  final String player2Name;

  TicTacToeBoard(
      {required this.mode,
      this.player1Name = "Player 1",
      this.player2Name = "Player 2"});

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  AudioPlayer audioPlayer = AudioPlayer();

  // Represents the game board, initialized with empty strings
  List<String> board = List.generate(9, (_) => '');

  // Tracks the current player ('X' starts first)
  String currentPlayer = 'assets/images/x.png';

  // Tracks the winner (if any)
  String winner = '';

  bool isMusicOn = true;

  @override
  void initState() {
    super.initState();
    if (widget.mode == 'singleplayer' &&
        currentPlayer == 'assets/images/x.png') {
      // Computer starts second in single-player mode
      Future.delayed(const Duration(milliseconds: 500), _computerMove);
    }

    _loadMusicState();
  }

  // Handles the tap on a grid cell
  void _onTap(int index) {
    // Only allow the move if the cell is empty and no winner has been determined
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;

        // Check for a winner or a draw after the move
        if (_checkWinner(currentPlayer)) {
          winner = currentPlayer;
        } else if (board.every((cell) => cell.isNotEmpty)) {
          winner = 'Draw';
        } else {
          // Toggle the current player
          currentPlayer = (currentPlayer == 'assets/images/o.png')
              ? 'assets/images/x.png'
              : 'assets/images/o.png';

          // Single-player mode: make computer move if it's computer's turn
          if (widget.mode == 'singleplayer' &&
              currentPlayer == 'assets/images/o.png') {
            Future.delayed(const Duration(milliseconds: 500), _computerMove);
          }
        }
      });
    }
  }

  // Makes a move for the computer in single-player mode
  void _computerMove() {
    if (winner == '' && widget.mode == 'singleplayer') {
      // Find empty cells
      final emptyCells = board
          .asMap()
          .entries
          .where((e) => e.value == '')
          .map((e) => e.key)
          .toList();

      // Basic AI: Choose a random empty cell
      if (emptyCells.isNotEmpty) {
        final index = emptyCells[(emptyCells.length * (0.5)).toInt()];
        _onTap(index);
      }
    }
  }

  // Checks if the current player has won
  bool _checkWinner(String player) {
    // Define all possible win patterns
    final winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    // Check if any of the win patterns match the player's moves
    return winPatterns
        .any((pattern) => pattern.every((index) => board[index] == player));
  }

  // Resets the game board for a new game
  void _resetGame() {
    setState(() {
      board = List.generate(9, (_) => '');
      currentPlayer = 'assets/images/x.png'; // Reset to 'X' start
      winner = '';
      if (widget.mode == 'singleplayer' &&
          currentPlayer == 'assets/images/x.png') {
        // Computer starts second in single-player mode
        Future.delayed(const Duration(milliseconds: 500), _computerMove);
      }
    });
  }

  // Determines the display text for the winner or the current player's turn
  String _getWinnerDisplay() {
    if (winner == 'assets/images/x.png') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWinnerDialog(context, widget.player1Name);
        playWinSound();
      });
      return 'Winner is Player 1!';
    } else if (winner == 'assets/images/o.png') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWinnerDialog(context, widget.player2Name);
        playWinSound();
      });
      return widget.mode == 'singleplayer'
          ? 'Winner is Computer!'
          : 'Winner is Player 2!';
    } else if (winner == 'Draw') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDrawDialog(context);
        playDrawSound();
      });
      return 'It\'s a Draw!';
    } else {
      return 'Player ${currentPlayer == "assets/images/x.png" ? "1" : "2"}\'s Turn';
    }
  }

  // Builds the player indicator widget
  Widget _buildPlayerIndicator(
      String playerName, String playerAsset, bool isCurrent) {
    return Container(
      height: (MediaQuery.of(context).size.width - 60) / 4,
      width: (MediaQuery.of(context).size.width - 60) / 4,
      decoration: BoxDecoration(
        color: const Color(0xff6549bf),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrent ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(playerName,
                style: TextStyles.medium(fontSize: 17, color: Colors.white)),
            const SizedBox(height: 7),
            Image.asset(playerAsset, height: 32),
          ],
        ),
      ),
    );
  }

  // Builds the game board grid
  Widget _buildGameBoard() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: board.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onTap(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff6549bf),
            ),
            child: Center(
              child: board[index] == ''
                  ? const Text('')
                  : Image.asset(board[index], height: 50),
            ),
          ),
        );
      },
    );
  }

  // Builds the restart button
  Widget _buildRestartButton() {
    return ElevatedButton(
        onPressed: _resetGame,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Restart Game',
          style: TextStyles.medium(
            fontSize: 16,
            color: const Color(0xff1d2053),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2053),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            winner == ''
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPlayerIndicator(
                          widget.player1Name,
                          "assets/images/x.png",
                          currentPlayer == "assets/images/x.png"),
                      const SizedBox(width: 20),
                      _buildPlayerIndicator(
                          widget.player2Name,
                          "assets/images/o.png",
                          currentPlayer == "assets/images/o.png"),
                    ],
                  )
                : Text(_getWinnerDisplay(),
                    style:
                        TextStyles.medium(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            Expanded(child: _buildGameBoard()),
            const SizedBox(height: 20),
            _buildRestartButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void showWinnerDialog(BuildContext context, String playerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Winner!',
          message: 'You have won the game.',
          playerName: playerName,
          imagePath: 'assets/images/trophy.png',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _resetGame();
            // Add any additional actions after closing the dialog
          },
        );
      },
    );
  }

  void showDrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Draw!',
          message: 'The game ended in a draw.',
          imagePath: 'assets/images/draw.png', // Replace with your image path
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _resetGame();
            // Add any additional actions after closing the dialog
          },
        );
      },
    );
  }

  void showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Game Over',
          message: 'Unfortunately, the game has failed.',
          imagePath: 'assets/images/fail.png', // Replace with your image path
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _resetGame();
            // Add any additional actions after closing the dialog
          },
        );
      },
    );
  }

  void playFailSound() async {
    if (isMusicOn) {
      await audioPlayer.play(AssetSource('audios/fail_game.mp3'));
    }
  }

  void playWinSound() async {
    if (isMusicOn) {
      await audioPlayer.play(AssetSource('audios/win_game.mp3'));
    }
  }

  void playDrawSound() async {
    if (isMusicOn) {
      await audioPlayer.play(AssetSource('audios/draw_game.mp3'));
    }
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
