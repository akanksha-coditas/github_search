import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/core/failure.dart';
import 'package:github_search/core/string_constants.dart';
import 'package:github_search/data/models/github_user_detail_model.dart';
import 'package:github_search/domain/entities/github_user_detail_entity.dart';
import 'package:github_search/domain/usecases/github_search_usecase.dart';
import 'package:github_search/presentation/search/screens/parts/github_search_screen_state.dart';

class GithubSearchScreenStateNotifier
    extends StateNotifier<GithubSearchScreenState> {
  final GithubSearchUsecase _usecase;

  GithubSearchScreenStateNotifier(this._usecase)
      : super(GithubSearchScreenInitialState());

  Future<void> searchUsers(String query) async {
    state = GithubSearchScreenLoadingState();

    final Either<Failure, List<GithubUserDetailEntity>> result =
        await _usecase(query);
   
    result.fold(
        (failure) => state = GithubSearchScreenErrorState(failure: failure),
        (users) async {
                   List<GithubUserDetailModel> fetchedUsers = List.from(users);

      for (int index = 0; index < fetchedUsers.length; index++) {
        final Either<Failure, GithubUserDetailEntity> detailedUser =
            await _usecase.fetchUserDetails(
                fetchedUsers[index].username ?? StringConstants.emptyString);
        detailedUser.fold(
            (failure) => state = GithubSearchScreenErrorState(failure: failure),
            (userDetail) {
             fetchedUsers[index] = fetchedUsers[index].copyWith(repoCount: userDetail.repoCount);
             
            });
      }


      state = GithubSearchScreenLoadedState(users: fetchedUsers);
    });
  }
}
