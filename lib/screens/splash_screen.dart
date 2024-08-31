import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/menu_screen.dart';

import '../utils/text_style_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _statusText = 'Starting...';
  double _progress = 0.0;
  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );


    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.forward().then((_) {
      setState(() {
        _isLoading = true;
      });
      _simulateTasks();
    });
  }


  void _simulateTasks() async {
    final List<String> tasks = [
      'Initializing application...',
      'Loading assets...',
      'Fetching user data...',
      'Connecting to server...',
      'Downloading graphics...',
      'Setting up user preferences...',
      'Configuring network settings...',
      'Loading game resources...',
      'Synchronizing data...',
      'Applying updates...',
      'Setting up database...',
      'Preparing user interface...',
      'Validating configurations...',
      'Checking system requirements...',
      'Loading external plugins...',
      'Processing user authentication...',
      'Finalizing setup...',
      'Reviewing logs...',
      'Optimizing performance...',
      'Almost there...',
      'Completing setup...'
    ];


    for (int i = 0; i < tasks.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _progress = (i + 1) / tasks.length;
          _statusText = tasks[i];
          _currentStep = i;
        });
      });
    }

    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    });
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget loadingProgress(){
      return Column(children: [

        LinearProgressIndicator(borderRadius: BorderRadius.circular(10),
          value: _progress,
          color: const Color(0xFF007BFF),
          backgroundColor: Colors.grey,
          minHeight: 6,
        ),
        const SizedBox(height: 10),
        Text(
          _statusText,
          style: TextStyles.regular(fontSize: 12, color: Colors.white),
        ),

      ],);
    }

    return Scaffold(
      backgroundColor: const Color(0xff1d2053), // Background color
      body: Center(child: FadeTransition(opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Spacer(),

              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),child: Image.asset('assets/images/tic_tac_toe.png', height: 150,),),
              const SizedBox(height: 20,),
              Text("Tic Tac Toe",style: TextStyles.cavetBold(fontSize: 40, color: Colors.white),),

              const Spacer(),

              _isLoading ? loadingProgress() : Container(),

            ],),
        ),
      ),)
    );
  }
}
