import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String content;
  final String commenterId;
  final String commenterName;
  final String avatar;
  final List<Comment> allReplies;
  final DateTime uploadTime;
  final bool isUpVote;
  final bool isDownVote;
  final int totalUpVotes;
  final int totalDownVotes;

  const Comment({
    required this.id,
    required this.content,
    required this.commenterId,
    required this.commenterName,
    required this.avatar,
    required this.allReplies,
    required this.uploadTime,
    required this.isUpVote,
    required this.isDownVote,
    required this.totalUpVotes,
    required this.totalDownVotes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'commenterId': commenterId,
      'commenterName': commenterName,
      'avatar': avatar,
      'allReplies': allReplies.map((e) => e.toJson()).toList(),
      'uploadTime': uploadTime.toIso8601String(),
      'isUpVote': isUpVote,
      'isDownVote': isDownVote,
      'totalUpVotes': totalUpVotes,
      'totalDownVotes': totalDownVotes,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      commenterId: json['commenterId'] ?? '',
      commenterName: json['commenterName'] ?? '',
      avatar: json['avatar'] ?? '',
      allReplies:
          (json['allReplies'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      uploadTime: json['uploadTime'] != null
          ? DateTime.parse(json['uploadTime']).toLocal()
          : DateTime.now(),
      isUpVote: json['isUpVote'] ?? false,
      isDownVote: json['isDownVote'] ?? false,
      totalUpVotes: json['totalUpVotes'] ?? 0,
      totalDownVotes: json['totalDownVotes'] ?? 0,
    );
  }

  Comment copyWith({
    String? id,
    String? content,
    String? commenterId,
    String? commenterName,
    String? avatar,
    List<Comment>? allReplies,
    DateTime? uploadTime,
    bool? isUpVote,
    bool? isDownVote,
    int? totalUpVotes,
    int? totalDownVotes,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      commenterId: commenterId ?? this.commenterId,
      commenterName: commenterName ?? this.commenterName,
      avatar: avatar ?? this.avatar,
      allReplies: allReplies ?? this.allReplies,
      uploadTime: uploadTime ?? this.uploadTime,
      isUpVote: isUpVote ?? this.isUpVote,
      isDownVote: isDownVote ?? this.isDownVote,
      totalUpVotes: totalUpVotes ?? this.totalUpVotes,
      totalDownVotes: totalDownVotes ?? this.totalDownVotes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    content,
    commenterId,
    commenterName,
    avatar,
    allReplies,
    uploadTime,
    isUpVote,
    isDownVote,
    totalUpVotes,
    totalDownVotes,
  ];
}
