import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/components/error_page.dart';
import '../../../common/constants/constants.dart';
import '../../../core/enums/eweet_type_enum.dart';
import '../../../data/models/eweet_model.dart';
import '../../../data/models/user_model.dart';
import '../../../common/theme/theme.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controller/eweet_controller.dart';
import 'carousel_image.dart';
import 'eweet_icon_button.dart';
import 'hash_tag_text.dart';

class EweetCard extends ConsumerWidget {
  final Eweet eweet;
  const EweetCard({
    super.key,
    required this.eweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? currentUser;
    try {
      currentUser = ref.watch(currentUserDetailsProvider).value;
    } catch (_) {}

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(eweet.uid)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {},
                              child: currentUser!.profilePic == null
                                  ? SvgPicture.asset(
                                      KAssets.noUserIcon,
                                      color: Colors.white,
                                      width: 50,
                                      height: 50,
                                    )
                                  : OptimizedCacheImage(
                                      imageUrl: user.profilePic!,
                                      height: 50,
                                      width: 50,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (eweet.rePostedBy.isNotEmpty)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        KAssets.reEweetIcon,
                                        color: KPalette.greyColor,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${eweet.rePostedBy} re posted',
                                        style: const TextStyle(
                                          color: KPalette.greyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right:
                                            (user.isVerified ?? false) ? 1 : 5,
                                      ),
                                      child: Text(
                                        user.username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                    if ((user.isVerified ?? false))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: SvgPicture.asset(
                                          KAssets.verifiedIcon,
                                        ),
                                      ),
                                    Text(
                                      '@${user.username} · ${timeago.format(
                                        eweet.postedAt,
                                        locale: 'en_short',
                                      )}',
                                      style: const TextStyle(
                                        color: KPalette.greyColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                if (eweet.repliedTo.isNotEmpty)
                                  ref
                                      .watch(
                                          getEweetByIdProvider(eweet.repliedTo))
                                      .when(
                                        data: (repliedToEweet) {
                                          final replyingToUser = ref
                                              .watch(
                                                userDetailsProvider(
                                                  repliedToEweet.uid,
                                                ),
                                              )
                                              .value;
                                          return RichText(
                                            text: TextSpan(
                                              text: 'Replying to',
                                              style: const TextStyle(
                                                color: KPalette.greyColor,
                                                fontSize: 16,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' @${replyingToUser?.username}',
                                                  style: const TextStyle(
                                                    color:
                                                        KPalette.primaryColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        error: (error, st) => ErrorText(
                                          error: error.toString(),
                                        ),
                                        loading: () => const SizedBox(),
                                      ),
                                HashtagText(text: eweet.text),
                                if (eweet.eweetType == EweetType.image)
                                  CarouselImage(imageLinks: eweet.imageLinks),
                                if (eweet.link.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: 'https://${eweet.link}',
                                  ),
                                ],
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      EweetIconButton(
                                        pathName: KAssets.viewsIcon,
                                        text: (eweet.commentIds.length +
                                                eweet.shareCount +
                                                eweet.likes.length)
                                            .toString(),
                                        onTap: () {},
                                      ),
                                      EweetIconButton(
                                        pathName: KAssets.commentIcon,
                                        text:
                                            eweet.commentIds.length.toString(),
                                        onTap: () {},
                                      ),
                                      EweetIconButton(
                                        pathName: KAssets.reEweetIcon,
                                        text: eweet.shareCount.toString(),
                                        onTap: () {
                                          ref
                                              .read(eweetControllerProvider
                                                  .notifier)
                                              .shareEweet(
                                                context,
                                                eweet: eweet,
                                                currentUser: currentUser!,
                                              );
                                        },
                                      ),
                                      LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          ref
                                              .read(eweetControllerProvider
                                                  .notifier)
                                              .likeEweet(
                                                eweet,
                                                currentUser!,
                                              );
                                          return !isLiked;
                                        },
                                        isLiked: eweet.likes
                                            .contains(currentUser.uid),
                                        likeBuilder: (isLiked) {
                                          return isLiked
                                              ? SvgPicture.asset(
                                                  KAssets.likeFilledIcon,
                                                  color: KPalette.redColor,
                                                )
                                              : SvgPicture.asset(
                                                  KAssets.likeOutlinedIcon,
                                                  color: KPalette.greyColor,
                                                );
                                        },
                                        likeCount: eweet.likes.length,
                                        countBuilder:
                                            (likeCount, isLiked, text) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color: isLiked
                                                    ? KPalette.redColor
                                                    : KPalette.whiteColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 25,
                                          color: KPalette.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: KPalette.greyColor),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => Loader(),
            );
  }
}
