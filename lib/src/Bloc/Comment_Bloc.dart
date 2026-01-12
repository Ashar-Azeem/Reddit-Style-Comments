// ignore_for_file: use_build_context_synchronously, library_prefixes
import 'package:bloc/bloc.dart';
import 'package:reddit_style_comments/reddit_style_comments.dart';

import 'package:reddit_style_comments/src/Bloc/Comment_Event.dart';
import 'package:reddit_style_comments/src/Bloc/Comment_State.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required Comment comment})
    : super(CommentsState(comment: comment)) {
    on<UpVoteComment>(upVoteComment);
    on<DownVoteComment>(downVoteComment);
  }

  upVoteComment(UpVoteComment event, Emitter<CommentsState> emit) {
    Comment comment = state.comment;
    comment = _updateVotes([comment], event.comment.id, isUpvote: true)[0];
    emit(state.copyWith(comment: comment));
  }

  downVoteComment(DownVoteComment event, Emitter<CommentsState> emit) {
    Comment comment = state.comment;
    comment = _updateVotes([comment], event.comment.id, isUpvote: false)[0];
    emit(state.copyWith(comment: comment));
  }
}

List<Comment> _updateVotes(
  List<Comment> comments,
  String commentId, {
  required bool isUpvote,
}) {
  return comments.map((comment) {
    if (comment.id == commentId) {
      bool updatedIsUpVote = comment.isUpVote;
      bool updatedIsDownVote = comment.isDownVote;
      int updatedTotalUpvotes = comment.totalUpVotes;
      int updatedTotalDownvotes = comment.totalDownVotes;

      if (isUpvote) {
        // When user taps upvote
        if (!comment.isUpVote) {
          // User is newly upvoting
          updatedIsUpVote = true;

          // Increase upvotes only if not already upvoted
          updatedTotalUpvotes += 1;

          // If previously downvoted, remove that downvote
          if (comment.isDownVote) {
            updatedIsDownVote = false;
            updatedTotalDownvotes -= 1;
          }
        } else {
          // User removes upvote
          updatedIsUpVote = false;
          updatedTotalUpvotes -= 1;
        }
      } else {
        // When user taps downvote
        if (!comment.isDownVote) {
          // User is newly downvoting
          updatedIsDownVote = true;
          updatedTotalDownvotes += 1;

          // If previously upvoted, remove that upvote
          if (comment.isUpVote) {
            updatedIsUpVote = false;
            updatedTotalUpvotes -= 1;
          }
        } else {
          // User removes downvote
          updatedIsDownVote = false;
          updatedTotalDownvotes -= 1;
        }
      }

      // Clamp totals so they don’t go below zero
      if (updatedTotalUpvotes < 0) updatedTotalUpvotes = 0;
      if (updatedTotalDownvotes < 0) updatedTotalDownvotes = 0;

      return comment.copyWith(
        isUpVote: updatedIsUpVote,
        isDownVote: updatedIsDownVote,
        totalUpVotes: updatedTotalUpvotes,
        totalDownVotes: updatedTotalDownvotes,
      );
    } else {
      // Recursive check for replies
      return comment.copyWith(
        allReplies: _updateVotes(
          comment.allReplies,
          commentId,
          isUpvote: isUpvote,
        ),
      );
    }
  }).toList();
}
