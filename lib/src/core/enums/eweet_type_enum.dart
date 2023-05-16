enum EweetType { text, image }

extension ConvertEweet on String {
  EweetType toEweetTypeEnum() {
    switch (this) {
      case 'text':
        return EweetType.text;
      case 'image':
        return EweetType.image;
      default:
        return EweetType.text;
    }
  }
}
