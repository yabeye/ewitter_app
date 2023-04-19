import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ewitter_app/src/common/components/components.dart';
import 'package:ewitter_app/src/common/components/error_page.dart';
import 'package:ewitter_app/src/common/constants/constants.dart';
import 'package:ewitter_app/src/common/theme/theme.dart';
import 'package:ewitter_app/src/data/models/eweet_model.dart';
import 'package:ewitter_app/src/data/models/user_model.dart';
import 'package:ewitter_app/src/features/eweet/widgets/eweet_card.dart';

import '../../../common/components/rounded_small_button.dart';
import '../../../utils/helpers.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controller/eweet_controller.dart';

class ReplayEweetView extends ConsumerStatefulWidget {
  const ReplayEweetView({super.key, required this.eweet});

  final Eweet eweet;

  @override
  ConsumerState<ReplayEweetView> createState() => _ReplayEweetViewState();
}

class _ReplayEweetViewState extends ConsumerState<ReplayEweetView> {
  late TextEditingController _reEweetController;
  List<Eweet> _eweets = [];

  bool _isCommenting = false;
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _reEweetController = TextEditingController();
  }

  @override
  void dispose() {
    _reEweetController.dispose();
    super.dispose();
  }

  void _onPickImages() async {
    _images = await pickImages();
    setState(() {});
  }

  void _realtimeEweetUpdate(RealtimeMessage realtimeEweets) {
    final String eventFrom =
        'databases.*.collections.${KAppwrite.eweetsCollection}.documents.*';
    final latestEweet = Eweet.fromMap(realtimeEweets.payload);

    if (latestEweet.repliedTo == widget.eweet.id) {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        showBack: true,
        backWidget: const BackWidget(),
        titleWidget: Text(
          "Eweet",
          style: boldTextStyle(
            color: KPalette.whiteColor,
          ),
        ),
        isCenterTitle: false,
      ),
      body: Column(
        children: [
          EweetCard(eweet: widget.eweet, isComment: true),
          ref.watch(getRepliesToEweetsProvider(widget.eweet)).when(
                data: (eweets) {
                  _eweets = [];
                  _eweets = eweets;
                  return ref.watch(getLatestEweetProvider).when(
                      data: (data) {
                        log("Inside!");
                        _realtimeEweetUpdate(data);

                        return Expanded(
                            child: ListView.builder(
                                itemCount: _eweets.length,
                                itemBuilder: (c, i) {
                                  return EweetCard(eweet: _eweets[i]);
                                }));
                      },
                      error: (e, s) => ErrorPage(error: e.toString()),
                      loading: () => Expanded(
                            child: ListView.builder(
                                itemCount: _eweets.length,
                                itemBuilder: (c, i) {
                                  return EweetCard(eweet: _eweets[i]);
                                }),
                          ));
                },
                error: (e, s) => ErrorPage(error: e.toString()),
                loading: () => Loader(),
              ),
          ref.watch(userDetailsProvider(widget.eweet.uid)).when(
                data: (user) {
                  return _buildReEweets(user, context);
                },
                error: (e, s) => ErrorPage(error: e.toString()),
                loading: () => Loader(),
              ),
        ],
      ),
    );
  }

  Column _buildReEweets(UserModel user, BuildContext context) {
    final isLoading = ref.watch(eweetControllerProvider);
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: RichTextWidget(
              list: [
                TextSpan(text: 'Replying to ', style: secondaryTextStyle()),
                TextSpan(
                  text: "@${user.username}",
                  style: boldTextStyle(color: KPalette.primaryColor, size: 14),
                ),
              ],
            )).paddingSymmetric(horizontal: 8).visible(_isCommenting),
        TextField(
          controller: _reEweetController,
          autofocus: _isCommenting,
          onSubmitted: (value) {},
          onTap: () {
            _isCommenting = true;
            setState(() {});
          },
          decoration: const InputDecoration(
            hintText: 'Eweet your reply',
          ),
        ).paddingSymmetric(horizontal: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: _onPickImages,
                  child: SvgPicture.asset(
                    KAssets.galleryIcon,
                    color: KPalette.primaryColor,
                    width: 30,
                    height: 30,
                  ),
                ).paddingOnly(right: 22),
                InkWell(
                  onTap: _onPickImages,
                  child: SvgPicture.asset(
                    KAssets.gifIcon,
                    color: KPalette.primaryColor,
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : RoundedSmallButton(
                      onTap: () {
                        ref.read(eweetControllerProvider.notifier).postEweet(
                              context,
                              images: _images,
                              text: _reEweetController.text,
                              repliedTo: widget.eweet.id,
                              repliedToUserId: user.username,
                            );
                        _reEweetController.text = "";
                        _isCommenting = false;
                        setState(() {});
                      },
                      label: 'Reply',
                      backgroundColor: KPalette.primaryColor,
                    ),
            ),
          ],
        ).visible(_isCommenting).paddingSymmetric(vertical: 10, horizontal: 8),
      ],
    );
  }
}
