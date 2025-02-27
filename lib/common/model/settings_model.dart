class SettingsModel {
  bool? success;
  SettingsData? data;

  SettingsModel({this.success, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SettingsData.fromJson(json['data']) : null;
  }
}

class SettingsData {
  Settings? settings;
  Null socialLinks;

  SettingsData({this.settings, this.socialLinks});

  SettingsData.fromJson(Map<String, dynamic> json) {
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    socialLinks = json['socialLinks'];
  }
}

class Settings {
  General? general;

  Settings({this.general});

  Settings.fromJson(Map<String, dynamic> json) {
    general =
        json['general'] != null ? General.fromJson(json['general']) : null;
  }
}

class General {
  String? copyright;
  String? currencyName;
  String? currencySymbol;
  String? siteUrl;
  String? appName;
  String? themeName;
  String? gstValue;
  String? ithemeColorStyle;
  String? ithemePrimary;
  String? ithemePrimary100;
  String? ithemePrimary80;
  String? ithemePrimary70;
  String? ithemePrimary60;
  String? ithemePrimary50;
  String? ithemePrimary30;
  String? ithemePrimary10;
  String? ithemePrimary5;
  String? ithemeSecondary;
  String? ithemeSecondary100;
  String? ithemeSecondary80;
  String? ithemeSecondary70;
  String? ithemeSecondary60;
  String? ithemeSecondary50;
  String? ithemeSecondary30;
  String? ithemeSecondary10;
  String? ithemeSecondary5;
  String? ithemeBorder;
  String? ithemeBorder100;
  String? ithemeBorder80;
  String? ithemeBorder70;
  String? ithemeBorder60;
  String? ithemeBorder50;
  String? ithemeBorder30;
  String? ithemeBorder10;
  String? ithemeBorder5;
  String? ithemeBody;
  String? ithemeBody100;
  String? ithemeBody80;
  String? ithemeBody70;
  String? ithemeBody60;
  String? ithemeBody50;
  String? ithemeBody30;
  String? ithemeBody10;
  String? ithemeBody5;
  String? ithemeTitle;
  String? ithemeTitle100;
  String? ithemeTitle80;
  String? ithemeTitle70;
  String? ithemeTitle60;
  String? ithemeTitle50;
  String? ithemeTitle30;
  String? ithemeTitle10;
  String? ithemeTitle5;
  String? ithemeBg;
  String? ithemeWarning;
  String? ithemeInfo;
  String? ithemeRating;
  String? ithemeBodyBg;
  String? ithemeGradientColor1;
  String? ithemeGradientColor2;
  String? ithemeWarning100;
  String? ithemeWarning80;
  String? ithemeWarning70;
  String? ithemeWarning60;
  String? ithemeWarning50;
  String? ithemeWarning30;
  String? ithemeWarning10;
  String? ithemeWarning5;
  String? ithemeInfo100;
  String? ithemeInfo80;
  String? ithemeInfo70;
  String? ithemeInfo60;
  String? ithemeInfo50;
  String? ithemeInfo30;
  String? ithemeInfo10;
  String? ithemeInfo5;
  String? ithemeRating100;
  String? ithemeRating80;
  String? ithemeRating70;
  String? ithemeRating60;
  String? ithemeRating50;
  String? ithemeRating30;
  String? ithemeRating10;
  String? ithemeRating5;
  String? ithemeBodyBg100;
  String? ithemeBodyBg80;
  String? ithemeBodyBg70;
  String? ithemeBodyBg60;
  String? ithemeBodyBg50;
  String? ithemeBodyBg30;
  String? ithemeBodyBg10;
  String? ithemeBodyBg5;
  String? ithemeBg100;
  String? ithemeBg80;
  String? ithemeBg70;
  String? ithemeBg60;
  String? ithemeBg50;
  String? ithemeBg30;
  String? ithemeBg10;
  String? ithemeBg5;
  String? siteLogo;
  String? siteWhiteLogo;
  String? themeHeader;
  String? themeFooter;
  String? adminLogo;
  String? favicon;

  General(
      {this.copyright,
      this.currencyName,
      this.currencySymbol,
      this.siteUrl,
      this.appName,
      this.themeName,
      this.gstValue,
      this.ithemeColorStyle,
      this.ithemePrimary,
      this.ithemePrimary100,
      this.ithemePrimary80,
      this.ithemePrimary70,
      this.ithemePrimary60,
      this.ithemePrimary50,
      this.ithemePrimary30,
      this.ithemePrimary10,
      this.ithemePrimary5,
      this.ithemeSecondary,
      this.ithemeSecondary100,
      this.ithemeSecondary80,
      this.ithemeSecondary70,
      this.ithemeSecondary60,
      this.ithemeSecondary50,
      this.ithemeSecondary30,
      this.ithemeSecondary10,
      this.ithemeSecondary5,
      this.ithemeBorder,
      this.ithemeBorder100,
      this.ithemeBorder80,
      this.ithemeBorder70,
      this.ithemeBorder60,
      this.ithemeBorder50,
      this.ithemeBorder30,
      this.ithemeBorder10,
      this.ithemeBorder5,
      this.ithemeBody,
      this.ithemeBody100,
      this.ithemeBody80,
      this.ithemeBody70,
      this.ithemeBody60,
      this.ithemeBody50,
      this.ithemeBody30,
      this.ithemeBody10,
      this.ithemeBody5,
      this.ithemeTitle,
      this.ithemeTitle100,
      this.ithemeTitle80,
      this.ithemeTitle70,
      this.ithemeTitle60,
      this.ithemeTitle50,
      this.ithemeTitle30,
      this.ithemeTitle10,
      this.ithemeTitle5,
      this.ithemeBg,
      this.ithemeWarning,
      this.ithemeInfo,
      this.ithemeRating,
      this.ithemeBodyBg,
      this.ithemeGradientColor1,
      this.ithemeGradientColor2,
      this.ithemeWarning100,
      this.ithemeWarning80,
      this.ithemeWarning70,
      this.ithemeWarning60,
      this.ithemeWarning50,
      this.ithemeWarning30,
      this.ithemeWarning10,
      this.ithemeWarning5,
      this.ithemeInfo100,
      this.ithemeInfo80,
      this.ithemeInfo70,
      this.ithemeInfo60,
      this.ithemeInfo50,
      this.ithemeInfo30,
      this.ithemeInfo10,
      this.ithemeInfo5,
      this.ithemeRating100,
      this.ithemeRating80,
      this.ithemeRating70,
      this.ithemeRating60,
      this.ithemeRating50,
      this.ithemeRating30,
      this.ithemeRating10,
      this.ithemeRating5,
      this.ithemeBodyBg100,
      this.ithemeBodyBg80,
      this.ithemeBodyBg70,
      this.ithemeBodyBg60,
      this.ithemeBodyBg50,
      this.ithemeBodyBg30,
      this.ithemeBodyBg10,
      this.ithemeBodyBg5,
      this.ithemeBg100,
      this.ithemeBg80,
      this.ithemeBg70,
      this.ithemeBg60,
      this.ithemeBg50,
      this.ithemeBg30,
      this.ithemeBg10,
      this.ithemeBg5,
      this.siteLogo,
      this.siteWhiteLogo,
      this.themeHeader,
      this.themeFooter,
      this.adminLogo,
      this.favicon});

  General.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    siteUrl = json['site_url'];
    appName = json['app_name'];
    themeName = json['theme_name'];
    gstValue = json['gst_value'];
    ithemeColorStyle = json['itheme_color_style'];
    ithemePrimary = json['itheme_primary'];
    ithemePrimary100 = json['itheme_primary_100'];
    ithemePrimary80 = json['itheme_primary_80'];
    ithemePrimary70 = json['itheme_primary_70'];
    ithemePrimary60 = json['itheme_primary_60'];
    ithemePrimary50 = json['itheme_primary_50'];
    ithemePrimary30 = json['itheme_primary_30'];
    ithemePrimary10 = json['itheme_primary_10'];
    ithemePrimary5 = json['itheme_primary_5'];
    ithemeSecondary = json['itheme_secondary'];
    ithemeSecondary100 = json['itheme_secondary_100'];
    ithemeSecondary80 = json['itheme_secondary_80'];
    ithemeSecondary70 = json['itheme_secondary_70'];
    ithemeSecondary60 = json['itheme_secondary_60'];
    ithemeSecondary50 = json['itheme_secondary_50'];
    ithemeSecondary30 = json['itheme_secondary_30'];
    ithemeSecondary10 = json['itheme_secondary_10'];
    ithemeSecondary5 = json['itheme_secondary_5'];
    ithemeBorder = json['itheme_border'];
    ithemeBorder100 = json['itheme_border_100'];
    ithemeBorder80 = json['itheme_border_80'];
    ithemeBorder70 = json['itheme_border_70'];
    ithemeBorder60 = json['itheme_border_60'];
    ithemeBorder50 = json['itheme_border_50'];
    ithemeBorder30 = json['itheme_border_30'];
    ithemeBorder10 = json['itheme_border_10'];
    ithemeBorder5 = json['itheme_border_5'];
    ithemeBody = json['itheme_body'];
    ithemeBody100 = json['itheme_body_100'];
    ithemeBody80 = json['itheme_body_80'];
    ithemeBody70 = json['itheme_body_70'];
    ithemeBody60 = json['itheme_body_60'];
    ithemeBody50 = json['itheme_body_50'];
    ithemeBody30 = json['itheme_body_30'];
    ithemeBody10 = json['itheme_body_10'];
    ithemeBody5 = json['itheme_body_5'];
    ithemeTitle = json['itheme_title'];
    ithemeTitle100 = json['itheme_title_100'];
    ithemeTitle80 = json['itheme_title_80'];
    ithemeTitle70 = json['itheme_title_70'];
    ithemeTitle60 = json['itheme_title_60'];
    ithemeTitle50 = json['itheme_title_50'];
    ithemeTitle30 = json['itheme_title_30'];
    ithemeTitle10 = json['itheme_title_10'];
    ithemeTitle5 = json['itheme_title_5'];
    ithemeBg = json['itheme_bg'];
    ithemeWarning = json['itheme_warning'];
    ithemeInfo = json['itheme_info'];
    ithemeRating = json['itheme_rating'];
    ithemeBodyBg = json['itheme_body_bg'];
    ithemeGradientColor1 = json['itheme_gradient_color_1'];
    ithemeGradientColor2 = json['itheme_gradient_color_2'];
    ithemeWarning100 = json['itheme_warning_100'];
    ithemeWarning80 = json['itheme_warning_80'];
    ithemeWarning70 = json['itheme_warning_70'];
    ithemeWarning60 = json['itheme_warning_60'];
    ithemeWarning50 = json['itheme_warning_50'];
    ithemeWarning30 = json['itheme_warning_30'];
    ithemeWarning10 = json['itheme_warning_10'];
    ithemeWarning5 = json['itheme_warning_5'];
    ithemeInfo100 = json['itheme_info_100'];
    ithemeInfo80 = json['itheme_info_80'];
    ithemeInfo70 = json['itheme_info_70'];
    ithemeInfo60 = json['itheme_info_60'];
    ithemeInfo50 = json['itheme_info_50'];
    ithemeInfo30 = json['itheme_info_30'];
    ithemeInfo10 = json['itheme_info_10'];
    ithemeInfo5 = json['itheme_info_5'];
    ithemeRating100 = json['itheme_rating_100'];
    ithemeRating80 = json['itheme_rating_80'];
    ithemeRating70 = json['itheme_rating_70'];
    ithemeRating60 = json['itheme_rating_60'];
    ithemeRating50 = json['itheme_rating_50'];
    ithemeRating30 = json['itheme_rating_30'];
    ithemeRating10 = json['itheme_rating_10'];
    ithemeRating5 = json['itheme_rating_5'];
    ithemeBodyBg100 = json['itheme_body_bg_100'];
    ithemeBodyBg80 = json['itheme_body_bg_80'];
    ithemeBodyBg70 = json['itheme_body_bg_70'];
    ithemeBodyBg60 = json['itheme_body_bg_60'];
    ithemeBodyBg50 = json['itheme_body_bg_50'];
    ithemeBodyBg30 = json['itheme_body_bg_30'];
    ithemeBodyBg10 = json['itheme_body_bg_10'];
    ithemeBodyBg5 = json['itheme_body_bg_5'];
    ithemeBg100 = json['itheme_bg_100'];
    ithemeBg80 = json['itheme_bg_80'];
    ithemeBg70 = json['itheme_bg_70'];
    ithemeBg60 = json['itheme_bg_60'];
    ithemeBg50 = json['itheme_bg_50'];
    ithemeBg30 = json['itheme_bg_30'];
    ithemeBg10 = json['itheme_bg_10'];
    ithemeBg5 = json['itheme_bg_5'];
    siteLogo = json['site_logo'];
    siteWhiteLogo = json['site_white_logo'];
    themeHeader = json['theme_header'];
    themeFooter = json['theme_footer'];
    adminLogo = json['admin_logo'];
    favicon = json['favicon'];
  }
}
