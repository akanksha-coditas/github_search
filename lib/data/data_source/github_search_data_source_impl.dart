import 'package:dartz/dartz.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/core/string_constants.dart';
import 'package:github_search/data/data_source/github_search_data_source.dart';
import 'package:github_search/data/models/github_user_detail_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubSearchDataSourceImpl implements GithubSearchDataSource {
  @override
  Future<Either<Failure, List<GithubUserDetailModel>>> searchUsers(
      String query) async {
    try {
      final response =
          await http.get(Uri.parse(StringConstants.baseUrl + query));
          print('response -- $response');
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['items'] as List;
   

    
        return Right(
          data.map((item) => GithubUserDetailModel.fromJson(item)).toList(),
        );
      } else {
        return Left(
          Failure(
            statusCode: response.statusCode.toString(),
            message: response.body,
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          statusCode: e.toString(),
          message: e.toString(),
        ),
      );
    }
  }

    /// Fetch detailed user info, including repo count
    @override
  Future<Either<Failure, GithubUserDetailModel>> fetchUserDetails(String username) async {
    try {
    final response = await http.get(Uri.parse(StringConstants.userUrl + username));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
       return Right(
           GithubUserDetailModel.fromJson(data),
        );
    } else {
       return Left(
        Failure(
          statusCode: response.statusCode.toString(),
          message: response.body.toString(),
        ),
      );
    }
  } catch (e) {
    return Left(
        Failure(
          statusCode: e.toString(),
          message: e.toString(),
        ),
      );
  }
}
}

