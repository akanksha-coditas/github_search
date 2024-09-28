import 'package:dartz/dartz.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/domain/entities/github_user_detail_entity.dart';
import 'package:github_search/domain/repositories/github_search_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final githubSearchUsecaseProvider = Provider((ref) {
  return GithubSearchUsecase(
    ref.read(githubSearchRepositoryProvider),
  );
});

class GithubSearchUsecase {
  final GithubSearchRepository _repository;

  GithubSearchUsecase(this._repository);

  Future<Either<Failure, List<GithubUserDetailEntity>>> call(String query) =>
      _repository.searchUsers(query);
  Future<Either<Failure, GithubUserDetailEntity>> fetchUserDetails(
          String username) =>
      _repository.fetchUserDetails(username);
}
