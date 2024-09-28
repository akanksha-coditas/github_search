import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/core/debouncer.dart';
import 'package:github_search/core/string_constants.dart';
import 'package:github_search/domain/usecases/github_search_usecase.dart';
import 'package:github_search/presentation/search/screens/parts/githb_search_screen_statenotifier.dart';
import 'package:github_search/presentation/search/screens/parts/github_search_screen_state.dart';

final _githubSearchScreenStateNotifierProvider = StateNotifierProvider<
    GithubSearchScreenStateNotifier, GithubSearchScreenState>(
  (ref) => GithubSearchScreenStateNotifier(
    ref.read(githubSearchUsecaseProvider),
  ),
);

class GithubSearchScreen extends ConsumerWidget {
  GithubSearchScreen({super.key});
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.read(_githubSearchScreenStateNotifierProvider.notifier);
    final state = ref.watch(_githubSearchScreenStateNotifierProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.black.withOpacity(0.8),
          title: const Text(
            StringConstants.githubRepo,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                focusNode: FocusNode()..requestFocus(),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                    labelText: StringConstants.searchByUsername),
                onSubmitted: notifier.searchUsers,
                onChanged: (String? query) {
                  _debouncer.run(() {
                    notifier.searchUsers(query ?? '');
                  });
                },
              ),
            ),
            switch (state) {
              GithubSearchScreenInitialState() =>
                const _CommonScreenHeightWrapperWidget(
                  child: Text(StringConstants.noResults,
                      style: TextStyle(color: Colors.grey)),
                ),
              GithubSearchScreenLoadingState() =>
                const _CommonScreenHeightWrapperWidget(
                    child: CircularProgressIndicator()),
              GithubSearchScreenErrorState() =>
                _CommonScreenHeightWrapperWidget(
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              GithubSearchScreenLoadedState() => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return ListTile(
                      leading: user.avatarUrl != null
                          ? Image.network(user.avatarUrl!)
                          : const Icon(Icons.person),
                      title: Text(user.username ?? StringConstants.emptyString),
                      subtitle: Text('Repos: ${user.repoCount}'),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
            }
          ],
        ),
      ),
    );
  }
}

class _CommonScreenHeightWrapperWidget extends StatelessWidget {
  const _CommonScreenHeightWrapperWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 4 * kToolbarHeight,
      child: Center(child: child),
    );
  }
}
