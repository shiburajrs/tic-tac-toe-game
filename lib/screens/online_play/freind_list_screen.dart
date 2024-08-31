import 'package:flutter/material.dart';

import '../../utils/text_style_utils.dart';

class FriendsListScreen extends StatelessWidget {
  final List<Friend> friends = [
    Friend(
      name: 'Alice',
      lastActive: DateTime.now().subtract(Duration(hours: 1)), // Active
      imageUrl:
      'https://media.themoviedb.org/t/p/w500/9XcFNLHEDian6DbkBgfNZIQ7yFt.jpg',
      status: 'Online',
    ),
    Friend(
      name: 'Bob',
      lastActive: DateTime.now().subtract(Duration(hours: 22)), // Inactive for a Day
      imageUrl:
      'https://rukminim2.flixcart.com/image/850/1000/xif0q/poster/k/y/u/medium-poster-design-no-3369-ironman-poster-ironman-posters-for-original-imaggbyahkdk73mc.jpeg?q=90&crop=false',
      status: 'Offline',
    ),
    Friend(
      name: 'Charlie',
      lastActive: DateTime.now().subtract(Duration(days: 2)), // Inactive for more than a Day
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMLBJQcs8qS1dSICQfj1e8BHQh5Cnbfna_Y_6ueaPUhKU5esht',
      status: 'Last seen 2 days ago',
    ),
    Friend(
      name: 'Daisy',
      lastActive: DateTime.now().subtract(Duration(hours: 26)), // Inactive for more than a Day
      imageUrl:
      'https://qph.cf2.quoracdn.net/main-qimg-e43af1ea0978af7da031068531f8967b-lq',
      status: 'Last seen 1 day ago',
    ),
    // Add more friends here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1d2053),
        title: Text('Friends list', style: TextStyles.cavetBold(fontSize: 24, color: Colors.white)),
      ),
      backgroundColor: Color(0xff1d2053),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return FriendCard(friend: friends[index]);
        },
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  final Friend friend;

  FriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(friend.lastActive);

    // Determine the status based on the last active time
    Color statusColor;
    String statusText;

    if (difference.inHours < 24) {
      statusColor = Colors.green;
      statusText = 'Online';
    } else if (difference.inHours < 48) {
      statusColor = Colors.yellow;
      statusText = 'Last seen ${difference.inHours} hours ago';
    } else {
      statusColor = Colors.red;
      statusText = 'Last seen ${difference.inDays} days ago';
    }

    return Card(
      color: Color(0xff4a3f7d),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(friend.imageUrl),
              radius: 30.0,
            ),
            Positioned(
              bottom: 8,
              right: 3,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          friend.name,
          style: TextStyles.bold(fontSize: 16, color: Colors.white),
        ),
        subtitle: Text(
          statusText,
          style: TextStyles.regular(color: Colors.grey.shade400),
        ),
        trailing: friend.lastActive.isAfter(now.subtract(Duration(hours: 24)))
            ? Container(height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 45,
        child: Center(child: Image.asset("assets/images/play.png", color: Colors.black,height: 25,),),)
            : null,
      ),
    );
  }
}

class Friend {
  final String name;
  final DateTime lastActive;
  final String imageUrl;
  final String status;

  Friend({
    required this.name,
    required this.lastActive,
    required this.imageUrl,
    required this.status,
  });
}
