// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'dart:math';
// 1. Import your package
import 'package:reddit_style_comments/reddit_style_comments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reddit Style Comment Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 12, 17, 20),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 12, 17, 20),
        useMaterial3: true,
      ),
      home: const RedditStyleCommentDemo(title: 'Reddit Style Comments'),
    );
  }
}

class RedditStyleCommentDemo extends StatefulWidget {
  const RedditStyleCommentDemo({super.key, required this.title});

  final String title;

  @override
  State<RedditStyleCommentDemo> createState() => _RedditStyleCommentDemoState();
}

class _RedditStyleCommentDemoState extends State<RedditStyleCommentDemo> {
  // Helper to generate random avatars for the demo
  static String _getRandomAvatar() {
    final index = Random().nextInt(11) + 1;
    return 'assets/Avatars/avatar$index.jpg';
  }

  // 2. Define your master list of comments.
  // Note: The 'allReplies' property allows for infinite nesting.
  List<Comment> dummyComments = [
    Comment(
      id: '1',
      commenterName: 'LogicMaster',
      commenterId: 'user_1',
      content: 'This is a top-level comment (Level 1). What do you guys think?',
      avatar: _getRandomAvatar(),
      uploadTime: DateTime.now().subtract(const Duration(hours: 5)),
      isUpVote: false,
      isDownVote: false,
      totalUpVotes: 120,
      totalDownVotes: 2,
      allReplies: [
        Comment(
          id: '1-1',
          commenterName: 'FlutterDev',
          commenterId: 'user_2',
          content: 'I think the nesting logic is looking great! (Level 2)',
          avatar: _getRandomAvatar(),
          uploadTime: DateTime.now().subtract(const Duration(hours: 4)),
          isUpVote: true,
          isDownVote: false,
          totalUpVotes: 45,
          totalDownVotes: 1,
          allReplies: [
            Comment(
              id: '1-1-1',
              commenterName: 'CodeNewbie',
              commenterId: 'user_3',
              content: 'How deep can these replies go? (Level 3)',
              avatar: _getRandomAvatar(),
              uploadTime: DateTime.now().subtract(const Duration(hours: 3)),
              isUpVote: false,
              isDownVote: false,
              totalUpVotes: 12,
              totalDownVotes: 0,
              allReplies: [],
            ),
          ],
        ),
      ],
    ),
    Comment(
      id: '2',
      commenterName: 'GhostUser',
      commenterId: 'user_6',
      content: 'Just passing through. Nice package!',
      avatar: _getRandomAvatar(),
      uploadTime: DateTime.now().subtract(const Duration(minutes: 30)),
      isUpVote: false,
      isDownVote: false,
      totalUpVotes: 2,
      totalDownVotes: 0,
      allReplies: [],
    ),
  ];

  // 3. Recursive function to update votes in the nested tree
  List<Comment> _updateVotes(List<Comment> list, String id, bool isUpvote) {
    return list.map((comment) {
      if (comment.id == id) {
        // Handle Vote Logic here (simplified for demo)
        return comment.copyWith(
          isUpvote: isUpvote ? !comment.isUpVote : false,
          isDownvote: !isUpvote ? !comment.isDownVote : false,
        );
      } else if (comment.allReplies.isNotEmpty) {
        return comment.copyWith(
          allReplies: _updateVotes(comment.allReplies, id, isUpvote),
        );
      }
      return comment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: dummyComments.length,
        itemBuilder: (context, index) {
          // 4. Implement the RedditStyleComments widget
          return RedditStyleComments(
            comment: dummyComments[index],
            // Use AssetImage for the demo, set to true if using URLs
            isNetWorkImage: false,
            backgroundColor: const Color.fromARGB(255, 12, 20, 27),
            verticalLineColor: const Color.fromARGB(255, 29, 47, 60),
            popUpMenuBackgroundColor: const Color.fromARGB(255, 24, 38, 51),

            // Interaction Callbacks
            onUpvote: (comment) {},
            onDownvote: (comment) {},
            onReply: (comment) {},
          );
        },
      ),
    );
  }
}
