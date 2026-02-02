import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final storedLoginProvider = FutureProvider<String?>((ref) async {
  return ref.read(authRepositoryProvider).getSavedLogin();
});
