import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/components/error_page.dart';
import 'controller/eweet_controller.dart';

class EweetList extends ConsumerWidget {
  const EweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEweetsProvider).when(
          data: (eweets) {
            return ListView.builder(
              itemCount: eweets.length,
              itemBuilder: (c, i) {
                return Text(eweets[i].text);
              },
            );
          },
          error: (e, st) {
            log("STack trace is ${st}");
            return ErrorText(error: e.toString());
          },
          loading: () => Loader(),
        );
  }
}
