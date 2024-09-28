import 'package:equatable/equatable.dart';

class GithubUserDetailEntity extends Equatable {
  final String? username;
  final String? avatarUrl;
  final int? repoCount;

 const GithubUserDetailEntity({
    required this.username,
    required this.avatarUrl,
    required this.repoCount,
  });

  @override
  List<Object?> get props => [username, avatarUrl, repoCount];
}
