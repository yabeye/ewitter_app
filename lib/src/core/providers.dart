import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';

final appWriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(KAppWrite.baseEndPointUrl)
      .setProject(KAppWrite.projectId)
      .setSelfSigned(status: false);
});

final appWriteAccountProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Account(client);
});

final appWriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Databases(client);
});

final appWriteStorageProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Storage(client);
});

final appWriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Realtime(client);
});
