import 'package:games_app/features/home/data/models/image_slider_model.dart';
import 'package:games_app/features/home/data/models/text_slider_model.dart';
import 'package:games_app/features/home/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required super.siteTitle,
    required super.siteDesc,
    required super.currency,
    required super.logo,
    required super.darkModeLogo,
    required super.enableCategories,
    required super.websiteColor,
    required super.minWithdrawalProfits,
    required super.minValuePurchaseVoucher,
    required super.whatsappNumber,
    required super.telegramNumber,
    required super.enableSignIn,
    required super.enableGoogleSignIn,
    required super.imagesSlider,
    required super.textsSlider,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      siteTitle: json['site_title'],
      siteDesc: json['site_desc'],
      currency: json['currency'],
      logo: json['logo'],
      darkModeLogo: json['dark_mode_logo'],
      enableCategories: json['enable_categories'],
      websiteColor: json['website_color'],
      minWithdrawalProfits: json['min_withdrawal_profits'],
      minValuePurchaseVoucher: json['min_value_purchase_voucher'],
      whatsappNumber: json['whatsapp_number'],
      telegramNumber: json['telegram_number'],
      enableSignIn: json['enable_sign_in'],
      enableGoogleSignIn: json['enable_google_sign_in'],
      imagesSlider: List<ImageSliderModel>.from(
        json['images_slider'].map(
          (e) => ImageSliderModel.fromJson(e),
        ),
      ),
      textsSlider: List<TextSliderModel>.from(
        json['texts_slider'].map(
          (e) => TextSliderModel.fromJson(e),
        ),
      ),
    );
  }
}
