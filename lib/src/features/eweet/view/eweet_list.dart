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
  final List<Eweet> _eweets = [];

  void _realtimeEweetUpdate(RealtimeMessage realtimeEweet) {
    if (realtimeEweet.events.contains(
      'databases.*.collections.${KAppwrite.eweetsCollection}.documents.*.create',
    )) {
      _eweets.insert(0, Eweet.fromMap(realtimeEweet.payload));
    } else if (realtimeEweet.events.contains(
      'databases.*.collections.${KAppwrite.eweetsCollection}.documents.*.update',
    )) {
      final start = realtimeEweet.events[0].lastIndexOf('documents.');
      final end = realtimeEweet.events[0].lastIndexOf('.update');
      final eweetId = realtimeEweet.events[0].substring(start + 10, end);

      _eweets.removeWhere((element) => element.id == eweetId);
      var newEweet = _eweets.where((element) => element.id == eweetId).first;
      newEweet = Eweet.fromMap(realtimeEweet.payload);

      _eweets.insert(_eweets.indexOf(newEweet), newEweet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getEweetsProvider).when(
          data: (preEweets) {
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
