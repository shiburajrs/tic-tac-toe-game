import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/text_style_utils.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? playerName;
  final String imagePath;
  final VoidCallback onConfirm;

  CustomAlertDialog({
    required this.title,
    required this.message,
    this.playerName,
    required this.imagePath,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyles.bold(fontSize: 20, color: const Color(0xff1d2053)),
          ),
          const SizedBox(height: 10),
          if (playerName != null)
            Text(
              'Congratulations, $playerName!',
              style: TextStyles.regular(fontSize: 17, color: Colors.blueAccent,
            ),),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style:TextStyles.regular(fontSize: 18, color: Colors.black,
            )
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1d2053),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Restart Game',
              style: TextStyles.medium(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
