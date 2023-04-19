import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/components/error_page.dart';
import '../../../common/constants/constants.dart';
import '../../../data/models/eweet_model.dart';
import '../controller/eweet_controller.dart';
import '../widgets/eweet_card.dart';

class EweetList extends ConsumerStatefulWidget {
  const EweetList({super.key});

  @override
  ConsumerState<EweetList> createState() => _EweetListState();
}

class _EweetListState extends ConsumerState<EweetList> {
  List<Eweet> _eweets = [];

  void _realtimeEweetUpdate(RealtimeMessage realtimeEweets) {
    final String eventFrom =
        'databases.*.collections.${KAppwrite.eweetsCollection}.documents.*';
    if (realtimeEweets.events.contains('$eventFrom.create')) {
      _eweets.insert(0, Eweet.fromMap(realtimeEweets.payload));
    } else if (realtimeEweets.events.contains('$eventFrom.update')) {
      final start = realtimeEweets.events[0].lastIndexOf('documents.');
      final end = realtimeEweets.events[0].lastIndexOf('.update');
      final eweetId = realtimeEweets.events[0].substring(start + 10, end);

      int updatedEweetIndex = _eweets.indexWhere((e) => e.id == eweetId);
      _eweets[updatedEweetIndex] = Eweet.fromMap(realtimeEweets.payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getEweetsProvider).when(
          data: (preEweets) {
            _eweets = [];
            _eweets.addAll(preEweets);
            return ref.watch(getLatestEweetProvider).when(
                  data: (realtimeEweets) {
                    _realtimeEweetUpdate(realtimeEweets);

                    return ListView.builder(
                      itemCount: _eweets.length,
                      itemBuilder: (c, i) => EweetCard(eweet: _eweets[i]),
                    );
                  },
                  error: (e, _) => ErrorText(error: e.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: _eweets.length,
                      itemBuilder: (c, i) => EweetCard(eweet: _eweets[i]),
                    );
                  },
                );
          },
          error: (e, _) => ErrorText(error: e.toString()),
          loading: () => Loader(),
        );
  }
}
