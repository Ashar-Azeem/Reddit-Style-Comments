// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_style_comments/src/Bloc/Comment_Bloc.dart';
import 'package:reddit_style_comments/src/Bloc/Comment_Event.dart';
import 'package:reddit_style_comments/src/Bloc/Comment_State.dart';
import 'package:reddit_style_comments/src/models/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

export 'src/models/comment_model.dart';

typedef CommentCallback = void Function(Comment comment);

class RedditStyleComments extends StatelessWidget {
  final Comment comment;
  final bool isNetWorkImage;
  final Color backgroundColor;
  final Color textColor;
  final Color showMoreIconColor;
  final Color activeVoteColor;
  final Color inActiveVoteColor;
  final CommentCallback onUpvote;
  final CommentCallback onDownvote;
  final CommentCallback onReply;
  final Color popUpMenuBackgroundColor;
  final CommentCallback? reportComment;
  final Color verticalLineColor;
  final bool disableShowMore;

  const RedditStyleComments({
    super.key,
    required this.comment,
    required this.backgroundColor,
    required this.onUpvote,
    required this.onDownvote,
    required this.onReply,
    this.reportComment,
    this.isNetWorkImage = true,
    this.textColor = Colors.white,
    this.showMoreIconColor = Colors.white,
    this.activeVoteColor = const Color.fromARGB(255, 47, 157, 246),
    this.inActiveVoteColor = Colors.white,
    this.disableShowMore = false,
    this.verticalLineColor = Colors.grey,
    this.popUpMenuBackgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsBloc(comment: comment),
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          return Card(
            color: backgroundColor,
            child: RedditStyleCommentsRecurssion(
              comment: state.comment,
              popUpMenuBackgroundColor: popUpMenuBackgroundColor,
              onUpvote: onUpvote,
              onDownvote: onDownvote,
              onReply: onReply,
              isNetWorkImage: isNetWorkImage,
              textColor: textColor,
              showMoreIconColor: showMoreIconColor,
              activeVoteColor: activeVoteColor,
              inActiveVoteColor: inActiveVoteColor,
              disableShowMore: disableShowMore,
              verticalLineColor: verticalLineColor,
            ),
          );
        },
      ),
    );
  }
}

class RedditStyleCommentsRecurssion extends StatelessWidget {
  final Comment comment;
  final bool isNetWorkImage;
  final int level;
  final Color textColor;
  final Color showMoreIconColor;
  final Color activeVoteColor;
  final Color inActiveVoteColor;
  final CommentCallback onUpvote;
  final CommentCallback onDownvote;
  final CommentCallback onReply;
  final CommentCallback? reportComment;
  final Color verticalLineColor;
  final bool disableShowMore;
  final Color popUpMenuBackgroundColor;

  const RedditStyleCommentsRecurssion({
    super.key,
    this.level = 1,
    required this.popUpMenuBackgroundColor,
    required this.comment,
    required this.onUpvote,
    required this.onDownvote,
    required this.onReply,
    required this.isNetWorkImage,
    required this.textColor,
    required this.showMoreIconColor,
    required this.activeVoteColor,
    required this.inActiveVoteColor,
    required this.disableShowMore,
    required this.verticalLineColor,
    this.reportComment,
  });

  void onreply(BuildContext context) {
    onReply.call(comment);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    double w(double percent) => screenWidth * (percent / 100);
    double h(double percent) => screenHeight * (percent / 100);

    return Stack(
      children: [
        if (level > 1)
          Positioned(
            left: level * w(0.6),
            top: 0,
            bottom: 0,
            child: Container(width: 1, color: verticalLineColor),
          ),
        Padding(
          padding: EdgeInsets.only(
            // Replaced .w logic
            left: level > 4 ? level * w(1.1) : level * w(2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: w(3.5),
                          backgroundImage: isNetWorkImage
                              ? NetworkImage(comment.avatar)
                              : AssetImage(comment.avatar) as ImageProvider,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w(1.5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.commenterName,
                                style: TextStyle(
                                  color: textColor,
                                  // Replaced 3.w
                                  fontSize: w(3),
                                ),
                              ),
                              Text(
                                timeago.format(comment.uploadTime),
                                style: TextStyle(
                                  color: textColor.withOpacity(0.8),
                                  // Replaced 1.5.w
                                  fontSize: w(1.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        disableShowMore
                            ? const SizedBox.shrink()
                            : PopupMenuButton<String>(
                                color: popUpMenuBackgroundColor,
                                icon: Icon(
                                  Icons.more_vert,
                                  // Replaced 5.w
                                  size: w(5),
                                  color: showMoreIconColor,
                                ),
                                onSelected: (String value) {
                                  if (value == "report") {
                                    reportComment?.call(comment);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'report',
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.report_gmailerrorred,
                                              color: showMoreIconColor,
                                            ),
                                            Text(
                                              'Report',
                                              style: TextStyle(
                                                color: textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                              ),
                      ],
                    ),
                    // Replaced 0.5.h
                    SizedBox(height: h(0.5)),
                    ExpandableText(
                      comment.content,
                      expandOnTextTap: true,
                      collapseOnTextTap: true,
                      expandText: 'show more',
                      collapseText: 'show less',
                      linkEllipsis: false,
                      maxLines: 4,
                      style: TextStyle(
                        // Replaced 3.8.w
                        fontSize: w(3.8),
                        color: textColor,
                        fontWeight: FontWeight.w300,
                      ),
                      linkColor: Theme.of(context).colorScheme.primary,
                    ),
                    BlocBuilder<CommentsBloc, CommentsState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              key: ValueKey(comment.isUpVote),
                              onPressed: () {
                                onUpvote.call(comment);
                                context.read<CommentsBloc>().add(
                                  UpVoteComment(comment: comment),
                                );
                              },
                              padding: EdgeInsets.zero,
                              icon:
                                  Icon(
                                        Icons.arrow_circle_up_outlined,
                                        // Replaced 5.5.w
                                        size: w(5.5),
                                        color: comment.isUpVote
                                            ? activeVoteColor
                                            : inActiveVoteColor,
                                      )
                                      .animate(
                                        onPlay: (controller) =>
                                            controller.forward(from: 0),
                                      )
                                      .scale(
                                        duration: 300.ms,
                                        curve: Curves.easeOutBack,
                                      ),
                            ),
                            Text(
                              "${comment.totalUpVotes - comment.totalDownVotes}",
                              style: TextStyle(
                                color: textColor,
                                // Replaced 3.w
                                fontSize: w(3),
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: w(1)),
                            IconButton(
                              onPressed: () {
                                onDownvote.call(comment);
                                context.read<CommentsBloc>().add(
                                  DownVoteComment(comment: comment),
                                );
                              },

                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.arrow_circle_down_outlined,
                                // Replaced 5.5.w
                                size: w(5.5),
                                color: comment.isDownVote
                                    ? activeVoteColor
                                    : inActiveVoteColor,
                              ),
                            ),
                            level > 7
                                ? const SizedBox.shrink()
                                : level == 1
                                ? TextButton.icon(
                                    onPressed: () => onReply.call(comment),
                                    label: Text(
                                      "Reply",
                                      style: TextStyle(
                                        color: textColor,
                                        // Replaced 3.5.w
                                        fontSize: w(3.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.reply,
                                      // Replaced 5.5.w
                                      size: w(5.5),
                                      color: activeVoteColor,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () => onreply(context),
                                    icon: Icon(
                                      Icons.reply,
                                      // Replaced 5.5.w
                                      size: w(5.5),
                                      color: activeVoteColor,
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                    if (comment.allReplies.isNotEmpty)
                      Padding(
                        // Replaced 0.3.h
                        padding: EdgeInsets.only(top: h(0.3)),
                        child: Column(
                          children: comment.allReplies.map((reply) {
                            return RedditStyleCommentsRecurssion(
                              level: level + 1,
                              onUpvote: onUpvote,
                              onDownvote: onDownvote,
                              onReply: onReply,
                              popUpMenuBackgroundColor:
                                  popUpMenuBackgroundColor,
                              comment: reply,
                              isNetWorkImage: isNetWorkImage,
                              textColor: textColor,
                              showMoreIconColor: showMoreIconColor,
                              activeVoteColor: activeVoteColor,
                              inActiveVoteColor: inActiveVoteColor,
                              reportComment: reportComment,
                              disableShowMore: disableShowMore,
                              verticalLineColor: verticalLineColor,
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
