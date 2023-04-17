import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:ewitter_app/src/constants/constants.dart';
import 'package:ewitter_app/src/data/models/user_model.dart';
import 'package:ewitter_app/src/theme/theme.dart';
import 'package:ewitter_app/src/common/utils/utils.dart';

import '../../../common/components/rounded_small_button.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controller/eweet_controller.dart';

class NewEweet extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NewEweet(),
      );
  const NewEweet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewEweetState();
}

class _NewEweetState extends ConsumerState<NewEweet> {
  late final TextEditingController _eweetTextController;
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _eweetTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _eweetTextController.dispose();
  }

  void _onPickImages() async {
    _images = await pickImages();
    setState(() {});
  }

  void _postEweet() async {
    ref.read(eweetControllerProvider.notifier).postEweet(
          context,
          images: _images,
          text: _eweetTextController.text,
          repliedTo: '',
          repliedToUserId: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser;

    try {
      // TODO: Remove this try catch block latter!
      currentUser = ref.watch(currentUserDetailsProvider).value;
    } catch (_) {}

    final isLoading = ref.watch(eweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          RoundedSmallButton(
            onTap: _postEweet,
            label: 'Eweet',
            backgroundColor: KPalette.primaryColor,
            textColor: KPalette.whiteColor,
          ),
        ],
      ),
      body: currentUser == null
          ? Loader()
          : SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: currentUser.profilePic == null
                                    ? SvgPicture.asset(
                                        KAssets.noUserIcon,
                                        color: Colors.white,
                                        width: 50,
                                        height: 50,
                                      )
                                    : OptimizedCacheImage(
                                        imageUrl: currentUser.profilePic!,
                                        height: 50,
                                        width: 50,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _eweetTextController,
                                style: boldTextStyle(
                                  weight: FontWeight.normal,
                                  color: KPalette.whiteColor,
                                  size: heading3Size,
                                ),
                                decoration: InputDecoration(
                                  hintText: "What's happening?",
                                  hintStyle:
                                      secondaryTextStyle(size: heading3Size),
                                  border: InputBorder.none,
                                ),
                                maxLines: 3,
                                onSubmitted: (v) {
                                  hideKeyboard(context);
                                },
                              ),
                            ),
                          ],
                        ).paddingAll(12),
                        if (_images.isNotEmpty)
                          CarouselSlider(
                            items: _images.map(
                              (file) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Image.file(file),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              height: 400,
                              enableInfiniteScroll: false,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Loader().visible(isLoading),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: KPalette.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
                onTap: _onPickImages,
                child: SvgPicture.asset(
                  KAssets.galleryIcon,
                  color: KPalette.whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(
                KAssets.gifIcon,
                color: KPalette.whiteColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(
                KAssets.emojiIcon,
                color: KPalette.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
