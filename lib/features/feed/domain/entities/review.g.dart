// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
      mediaTitle: json['mediaTitle'] as String,
      mediaType: json['mediaType'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'rating': instance.rating,
      'mediaTitle': instance.mediaTitle,
      'mediaType': instance.mediaType,
      'author': instance.author,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isLiked': instance.isLiked,
    };
