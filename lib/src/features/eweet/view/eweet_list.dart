import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/components/error_page.dart';
import '../controller/eweet_controller.dart';
import '../widgets/eweet_card.dart';

class EweetList extends ConsumerWidget {
  const EweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEweetsProvider).when(
          data: (eweets) {
            return ref.watch(getLatestEweetProvider).when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: eweets.length,
                      itemBuilder: (c, i) => EweetCard(eweet: eweets[i]),
                    );
                  },
                  error: (e, _) => ErrorText(error: e.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: eweets.length,
                      itemBuilder: (c, i) => EweetCard(eweet: eweets[i]),
                    );
                  },
                );
          },
          error: (e, _) => ErrorText(error: e.toString()),
          loading: () => Loader(),
        );
  }
}
