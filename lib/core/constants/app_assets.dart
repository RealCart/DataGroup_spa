class AppAssets {
  AppAssets._();

  static final icons = _AppIcons();

  static final images = _AppImages();
}

class _AppIcons {
  final String _path = "assets/icons";

  String get search => "$_path/search.svg";
}

class _AppImages {
  final String _path = "assets/images";

  String get logo => "$_path/logo.svg";
  String get searchBg => "$_path/search_bg.png";
}
