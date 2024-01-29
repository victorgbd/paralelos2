import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../user_entity.dart';
import '../user_repository.dart';

final userNotifierProvider =
    StateNotifierProvider.autoDispose<UserNotifier, UserState>(
        (ref) => UserNotifier(ref.read(userRepositoryProvider), ref));

class UserState {
  final List<User> users;
  final bool isLoading;
  final String? errorMessage;
  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });
  UserState get empty => const UserState();

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _repository;
  final Ref ref;
  UserNotifier(
    this._repository,
    this.ref,
  ) : super(const UserState());
  Future<void> fetchAll() async {
    state = state.empty.copyWith(isLoading: true);
    final result = await _repository.fetchAll();
    if (result == null) {
      state = state.empty.copyWith(errorMessage: null, isLoading: false);
      return;
    }

    final users = result;
    state = state.empty.copyWith(users: users, isLoading: false);
  }

  Future<void> fetchAllIsolate() async {
    state = state.empty.copyWith(isLoading: true);
    final resultPort = ReceivePort();
    await Isolate.spawn(
      _repository.fetchAllIsolate,
      resultPort.sendPort,
    );
    resultPort.listen((result) {
      if (result == null) {
        state = state.empty.copyWith(errorMessage: null, isLoading: false);
        return;
      }

      final users = result;
      state = state.empty.copyWith(users: users, isLoading: false);
    });
  }
}
