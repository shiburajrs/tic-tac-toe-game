import 'package:flutter/material.dart';
import '../../utils/text_style_utils.dart';
import '../../widgets/leaderboard_head.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2053), // Background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35),
        child: Column(
          children: [
            // Header Section
            CustomShapeWidget(),

            // Leaderboard List
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length + 1, // +1 for the header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Header
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xff4a3f7d), // Header color
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Header
                          Text(
                            'Rank',
                            style: TextStyles.bold(fontSize: 12, color: Colors.white60),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Username",
                                style: TextStyles.bold(fontSize: 12, color: Colors.white60),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // Stats Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Wins',
                                style: TextStyles.bold(fontSize: 12, color: Colors.white60),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Draws',
                                style: TextStyles.bold(fontSize: 12, color: Colors.white60),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Fails',
                                style: TextStyles.bold(fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Leaderboard Card
                    final player = leaderboardData[index - 1];
                    return AnimatedLeaderboardCard(
                      rank: player['rank'],
                      username: player['username'],
                      matches: player['matches'],
                      wins: player['wins'],
                      draws: player['draws'],
                      fails: player['fails'],
                      index: index - 1,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLeaderboardCard extends StatelessWidget {
  final int rank;
  final String username;
  final int matches;
  final int wins;
  final int draws;
  final int fails;
  final int index;

  AnimatedLeaderboardCard({
    required this.rank,
    required this.username,
    required this.matches,
    required this.wins,
    required this.draws,
    required this.fails,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Color(0xff3a2a6b) : Color(0xff4a3f7d),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Rank
          Text(
            '$rank',
            style: TextStyles.bold(fontSize: 20, color: Colors.white),
          ),

          // Username
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                username,
                style: TextStyles.bold(fontSize: 16, color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle long usernames
              ),
            ),
          ),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$wins',
                style: TextStyles.bold(fontSize: 16, color: Colors.white60),
              ),
              SizedBox(width: 10),
              Text(
                '$draws',
                style: TextStyles.bold(fontSize: 16, color: Colors.white60),
              ),
              SizedBox(width: 10),
              Text(
                '$fails',
                style: TextStyles.bold(fontSize: 16, color: Colors.white60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> leaderboardData = List.generate(
  10,
      (index) => {
    'rank': index + 1,
    'username': 'Player ${index + 1}',
    'matches': (index + 1) * 10,
    'wins': (index + 1) * 3,
    'draws': (index + 1) * 2,
    'fails': (index + 1) * 5,
  },
);
