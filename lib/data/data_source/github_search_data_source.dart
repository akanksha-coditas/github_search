import 'package:dartz/dartz.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/data/models/github_user_detail_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/data/data_source/github_search_data_source_impl.dart';

final Provider<GithubSearchDataSource> githubSearchDataSourceProvider =
    Provider<GithubSearchDataSource>((ref) {
  return GithubSearchDataSourceImpl();
});

abstract class GithubSearchDataSource {
  Future<Either<Failure, List<GithubUserDetailModel>>> searchUsers(
      String query);
  Future<Either<Failure, GithubUserDetailModel>> fetchUserDetails(
      String username);
}
