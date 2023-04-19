import 'dart:io';

import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

// String based helpers
String getLinkFromText(String text) {
  String link = '';
  List<String> wordsInSentence = text.split(' ');
  for (String word in wordsInSentence) {
    if (word.startsWith('https://') || word.startsWith('www.')) {
      link = word;
    }
  }
  return link;
}

List<String> getHashTagsFromText(String text) {
  List<String> hashtags = [];
  List<String> wordsInSentence = text.split(' ');
  for (String word in wordsInSentence) {
    if (word.startsWith('#')) {
      hashtags.add(word);
    }
  }
  return hashtags;
}

// File Based helpers
Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

// Link based helpers
Future<void> commonLaunchUrl(
  String address, {
  LaunchMode launchMode = LaunchMode.inAppWebView,
}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('Invalid URL: $address');
    return false;
  });
}
