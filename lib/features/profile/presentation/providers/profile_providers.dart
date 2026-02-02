import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage.dart';
import '../../domain/fan_profile.dart';

final localStorageProvider = Provider<LocalStorage>((ref) => LocalStorage());

final fanProfileProvider =
    StateNotifierProvider<FanProfileNotifier, AsyncValue<FanProfile?>>(
  (ref) => FanProfileNotifier(ref),
);

class FanProfileNotifier extends StateNotifier<AsyncValue<FanProfile?>> {
  FanProfileNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load();
  }

  final Ref ref;

  Future<void> _load() async {
    final storage = ref.read(localStorageProvider);
    final profile = await storage.loadProfile();
    state = AsyncValue.data(profile);
  }

  Future<void> save(FanProfile profile) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(localStorageProvider).saveProfile(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> update(FanProfile Function(FanProfile? current) updater) async {
    final current = state.valueOrNull;
    final next = updater(current);
    await save(next);
  }
}
