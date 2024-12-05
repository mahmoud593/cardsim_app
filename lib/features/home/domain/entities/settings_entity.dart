import 'package:games_app/features/home/domain/entities/text_slider_entity.dart';

import 'image_slider_entity.dart';

class SettingsEntity {
  final String siteTitle;
  final String siteDesc;
  final String currency;
  final String logo;
  final String darkModeLogo;
  final bool enableCategories;
  final String websiteColor;
  final String minWithdrawalProfits;
  final String minValuePurchaseVoucher;
  final String whatsappNumber;
  final String telegramNumber;
  final bool enableSignIn;
  final bool enableGoogleSignIn;
  final List<ImageSliderEntity> imagesSlider;
  final List<TextSliderEntity> textsSlider;

  SettingsEntity({
    required this.siteTitle,
    required this.siteDesc,
    required this.currency,
    required this.logo,
    required this.darkModeLogo,
    required this.enableCategories,
    required this.websiteColor,
    required this.minWithdrawalProfits,
    required this.minValuePurchaseVoucher,
    required this.whatsappNumber,
    required this.telegramNumber,
    required this.enableSignIn,
    required this.enableGoogleSignIn,
    required this.imagesSlider,
    required this.textsSlider,
  });
}