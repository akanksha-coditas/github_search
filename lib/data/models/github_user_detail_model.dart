import 'package:github_search/domain/entities/github_user_detail_entity.dart';

class GithubUserDetailModel extends GithubUserDetailEntity {
 const GithubUserDetailModel({
    required super.username,
    required super.avatarUrl,
    required super.repoCount,
  });

  factory GithubUserDetailModel.fromJson(Map<String, dynamic> json) {
    return GithubUserDetailModel(
      username: json['login'],
      avatarUrl: json['avatar_url'],
      repoCount: json['public_repos'],
    );
  }

  GithubUserDetailModel copyWith({
   final String? username,
   final String? avatarUrl,
  final  int? repoCount,
  }) {
    return GithubUserDetailModel(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      repoCount: repoCount ?? this.repoCount,
    );
  }
}