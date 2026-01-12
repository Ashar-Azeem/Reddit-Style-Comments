import 'package:equatable/equatable.dart';
import 'package:reddit_style_comments/reddit_style_comments.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class UpVoteComment extends CommentsEvent {
  final Comment comment;

  const UpVoteComment({required this.comment});
}

class DownVoteComment extends CommentsEvent {
  final Comment comment;

  const DownVoteComment({required this.comment});
}
