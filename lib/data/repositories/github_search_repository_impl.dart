import 'package:dartz/dartz.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/data/data_source/github_search_data_source.dart';
import 'package:github_search/data/models/github_user_detail_model.dart';
import 'package:github_search/domain/repositories/github_search_repository.dart';

class GithubSearchRepositoryImpl implements GithubSearchRepository {
  final GithubSearchDataSource _dataSource;

  GithubSearchRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<GithubUserDetailModel>>> searchUsers(
          String query) =>
      _dataSource.searchUsers(query);
  @override
  Future<Either<Failure, GithubUserDetailModel>> fetchUserDetails(
          String username) =>
      _dataSource.fetchUserDetails(username);
}
