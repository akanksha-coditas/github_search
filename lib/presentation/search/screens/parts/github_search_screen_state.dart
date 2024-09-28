import 'package:github_search/core/failure.dart';
import 'package:github_search/domain/entities/github_user_detail_entity.dart';

sealed class GithubSearchScreenState {}

class GithubSearchScreenInitialState extends GithubSearchScreenState {}
class GithubSearchScreenLoadingState extends GithubSearchScreenState {}

class GithubSearchScreenLoadedState extends GithubSearchScreenState {
  final List<GithubUserDetailEntity> users;

  GithubSearchScreenLoadedState({required this.users});
}

class GithubSearchScreenErrorState extends GithubSearchScreenState {
  final Failure failure;

  GithubSearchScreenErrorState({required this.failure});
}
