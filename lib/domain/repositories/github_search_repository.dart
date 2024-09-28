import 'package:dartz/dartz.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/data/data_source/github_search_data_source.dart';
import 'package:github_search/domain/entities/github_user_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/data/repositories/github_search_repository_impl.dart';

final githubSearchRepositoryProvider = Provider<GithubSearchRepository>((ref) {
  return GithubSearchRepositoryImpl(
    ref.read(githubSearchDataSourceProvider),
  );
});

abstract class GithubSearchRepository {
  Future<Either<Failure, List<GithubUserDetailEntity>>> searchUsers(
      String query);

  Future<Either<Failure, GithubUserDetailEntity>> fetchUserDetails(
      String username);
}
