import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/constants/constants.dart';

final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(KAppwrite.baseEndPointUrl)
      .setProject(KAppwrite.projectId)
      .setSelfSigned(status: false);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});

final appwriteStorageProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Storage(client);
});

final appwriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Realtime(client);
});
