

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/share_pref_constants.dart';

import '../core/shared_pref_utils.dart';
import '../utils/text_style_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEffects = true;
  bool _music = true;
  String _aiDifficulty = 'Medium';
  String _boardSize = 'Standard';
  bool _matchmaking = true;
  bool _notifications = true;
  bool _gameAlerts = true;
  String _username = 'Player1';

  @override
  void initState() {
    // TODO: implement initState
    _loadMusicState();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xff1d2053),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1d2053),
        title: Text('Settings', style: TextStyles.cavetBold(fontSize: 24, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [


          //Profile Settings
          // _buildSectionTitle('Profile Info', ),
          // _buildProfileSection("https://www.shutterstock.com/image-vector/3d-illustration-monkey-d-luffy-600nw-2455944731.jpg","Monkey D Luffy", "1"),

          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 16.0),
          //   child: Divider(color: Colors.white.withOpacity(0.6)),
          // ),

          // General Settings
          _buildSectionTitle('General Settings', ),
          _buildSwitchTile('Sound Effects', _soundEffects, (value) async{
            await SharedPrefsManager().set(SharePrefConstants.IS_MUSIC_ON, value);
            setState(() {
              _soundEffects = value;
            });
          }),
          // _buildSwitchTile('Music', _music, (value) {
          //   setState(() {
          //     _music = value;
          //   });
          // }),


          //  Padding(
          //   padding: EdgeInsets.symmetric(vertical: 16.0),
          //   child: Divider(color: Colors.white.withOpacity(0.6)),
          // ),

          // Offline Play Settings
          // _buildSectionTitle('Offline Play Settings'),
          // _buildDropdownTile('AI Difficulty', _aiDifficulty, ['Easy', 'Medium', 'Hard'], (value) {
          //   setState(() {
          //     _aiDifficulty = value!;
          //   });
          // }),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: Colors.white.withOpacity(0.6)),
          ),


          // Online Play Settings
          _buildSectionTitle('Online Play Settings'),
          _buildSwitchTile('Matchmaking Preferences', _matchmaking, (value) {
            setState(() {
              _matchmaking = value;
            });
          }),
          _buildSwitchTile('Notifications', _notifications, (value) {
            setState(() {
              _notifications = value;
            });
          }),
          _buildSwitchTile('Game Alerts', _gameAlerts, (value) {
            setState(() {
              _gameAlerts = value;
            });
          }),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(color: Colors.white.withOpacity(0.6)),
          ),


          // About
          _buildSectionTitle('About'),
          ListTile(
            title: Text('Version Info', style: TextStyles.regular(fontSize: 13, color: Colors.white),),
            subtitle: Text('1.0.0',  style: TextStyles.regular(fontSize: 13, color: Colors.white)),
          ),
          ListTile(
            title: Text('Credits', style: TextStyles.regular(fontSize: 13, color: Colors.white)),
            subtitle: Text('Developed by Shiburaj RS',  style: TextStyles.regular(fontSize: 13, color: Colors.white)),
          ),

        ],
      ),
    );
  }


  Widget _buildProfileSection(String _profileImageUrl, String _username, String _rank) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(_profileImageUrl), // User profile image
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_username, style: TextStyles.bold(fontSize: 18, color: Colors.white)),
              SizedBox(height: 4.0),
              Text('Rank: $_rank', style: TextStyles.regular(fontSize: 14, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style:  TextStyles.bold(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyles.regular(fontSize: 13, color: Colors.white),),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownTile(String title, String value, List<String> options, ValueChanged<String?> onChanged) {
    return ListTile(
      title: Text(title, style: TextStyles.regular(fontSize: 13, color: Colors.white)),
      subtitle: Text(value, style: TextStyles.regular(fontSize: 13, color: Colors.white)),
      trailing: DropdownButton<String>(dropdownColor: Colors.black87,
        value: options.contains(value) ? value : null, // Handle null value
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option, style: TextStyles.regular(fontSize: 13, color: Colors.white)),
          );
        }).toList(),
      ),
    );
  }


  Widget _buildTextField(String title, String value, ValueChanged<String> onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: TextField(
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  void _resetSettings() {
    setState(() {
      _soundEffects = true;
      _music = true;
      _aiDifficulty = 'Medium';
      _boardSize = 'Standard (3x3)';
      _matchmaking = true;
      _notifications = true;
      _gameAlerts = true;
      _username = 'Player1';
    });
  }

  void _loadMusicState() async{
    bool? isMusicOnValue = SharedPrefsManager().get<bool>(SharePrefConstants.IS_MUSIC_ON, true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _soundEffects = isMusicOnValue ?? true;
      });
    });

  }
}