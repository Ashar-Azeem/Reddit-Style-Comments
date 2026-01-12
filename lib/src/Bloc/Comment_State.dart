// ignore_for_file: library_prefixes

import 'package:equatable/equatable.dart';

import '../models/comment_model.dart';

class CommentsState extends Equatable {
  final Comment comment;

  const CommentsState({required this.comment});

  CommentsState copyWith({Comment? comment}) {
    return CommentsState(comment: comment ?? this.comment);
  }

  @override
  List<Object?> get props => [comment];
}
