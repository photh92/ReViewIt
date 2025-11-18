import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reviewit/features/feed/domain/entities/user.dart'; // User 모델 참조

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  factory Review({
    required String id,
    required String content,
    required double rating,
    required String mediaTitle, // 영화/책 제목
    required String mediaType,   // "movie" 또는 "book"
    required User author,
    required DateTime createdAt,
    required int likeCount,
    required int commentCount,
    @Default(false) bool isLiked, // 사용자가 좋아요를 눌렀는지 여부
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}