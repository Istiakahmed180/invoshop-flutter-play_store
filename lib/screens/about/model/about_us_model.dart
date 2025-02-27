class AboutUsModel {
  bool? success;
  Data? data;

  AboutUsModel({this.success, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? pageType;
  String? introText;
  String? description;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  String? featuredImage;
  String? pageOptions;
  PageSettings? pageSettings;
  String? status;
  String? visibility;
  String? publishedAt;
  int? isSystemDefault;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  PageContents? pageContents;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.pageType,
      this.introText,
      this.description,
      this.metaTitle,
      this.metaDescription,
      this.metaKeywords,
      this.featuredImage,
      this.pageOptions,
      this.pageSettings,
      this.status,
      this.visibility,
      this.publishedAt,
      this.isSystemDefault,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pageContents});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    pageType = json['page_type'];
    introText = json['intro_text'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    featuredImage = json['featured_image'];
    pageOptions = json['page_options'];
    pageSettings = json['page_settings'] != null
        ? PageSettings.fromJson(json['page_settings'])
        : null;
    status = json['status'];
    visibility = json['visibility'];
    publishedAt = json['published_at'];
    isSystemDefault = json['is_system_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pageContents = json['page_contents'] != null
        ? PageContents.fromJson(json['page_contents'])
        : null;
  }
}

class PageSettings {
  PageHeader? pageHeader;

  PageSettings({this.pageHeader});

  PageSettings.fromJson(Map<String, dynamic> json) {
    pageHeader = json['page_header'] != null
        ? PageHeader.fromJson(json['page_header'])
        : null;
  }
}

class PageHeader {
  String? padding;
  String? textAlign;
  String? headerLogo;
  String? themeHeader;
  String? topbarTitle;
  String? backgroundColor;
  bool? showCartButton;
  bool? showHeaderTopbar;
  bool? showCompareButton;
  bool? showWishlistButton;

  PageHeader(
      {this.padding,
      this.textAlign,
      this.headerLogo,
      this.themeHeader,
      this.topbarTitle,
      this.backgroundColor,
      this.showCartButton,
      this.showHeaderTopbar,
      this.showCompareButton,
      this.showWishlistButton});

  PageHeader.fromJson(Map<String, dynamic> json) {
    padding = json['padding'];
    textAlign = json['text_align'];
    headerLogo = json['header_logo'];
    themeHeader = json['theme_header'];
    topbarTitle = json['topbar_title'];
    backgroundColor = json['background_color'];
    showCartButton = json['show_cart_button'];
    showHeaderTopbar = json['show_header_topbar'];
    showCompareButton = json['show_compare_button'];
    showWishlistButton = json['show_wishlist_button'];
  }
}

class PageContents {
  List<LayoutSections>? layoutSections;

  PageContents({this.layoutSections});

  PageContents.fromJson(Map<String, dynamic> json) {
    if (json['layoutSections'] != null) {
      layoutSections = <LayoutSections>[];
      json['layoutSections'].forEach((v) {
        layoutSections!.add(LayoutSections.fromJson(v));
      });
    }
  }
}

class LayoutSections {
  String? id;
  String? name;
  Settings? settings;
  List<Containers>? containers;

  LayoutSections({this.id, this.name, this.settings, this.containers});

  LayoutSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    if (json['containers'] != null) {
      containers = <Containers>[];
      json['containers'].forEach((v) {
        containers!.add(Containers.fromJson(v));
      });
    }
  }
}

class Settings {
  String? bgColor;
  String? padding;
  String? textAlign;

  Settings({this.bgColor, this.padding, this.textAlign});

  Settings.fromJson(Map<String, dynamic> json) {
    bgColor = json['bgColor'];
    padding = json['padding'];
    textAlign = json['textAlign'];
  }
}

class Containers {
  String? id;
  int? grid;
  String? name;
  List<Widgets>? widgets;

  Containers({this.id, this.grid, this.name, this.widgets});

  Containers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grid = json['grid'];
    name = json['name'];
    if (json['widgets'] != null) {
      widgets = <Widgets>[];
      json['widgets'].forEach((v) {
        widgets!.add(Widgets.fromJson(v));
      });
    }
  }
}

class Widgets {
  String? id;
  String? img;
  String? name;
  int? defaultId;
  int? sectionId;
  int? containerId;
  ContentData? contentData;

  Widgets(
      {this.id,
      this.img,
      this.name,
      this.defaultId,
      this.sectionId,
      this.containerId,
      this.contentData});

  Widgets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    defaultId = json['defaultId'];
    sectionId = json['sectionId'];
    containerId = json['containerId'];
    contentData = json['contentData'] != null
        ? ContentData.fromJson(json['contentData'])
        : null;
  }
}

class ContentData {
  String? margin;
  String? padding;
  String? subTitle;
  String? aboutLink;
  String? bannerImg;
  bool? showImage;
  bool? showButton;
  String? aboutLayout;
  String? buttonTitle;
  String? aboutContent;
  String? aboutHeading;
  bool? showListItems;
  String? aboutThumbText;
  String? backgroundColor;
  bool? showSectionContent;
  bool? showAboutThumbMeta;
  bool? showIcon;
  bool? showLink;
  String? textAlign;
  bool? showHeading;
  String? bannerColumn;
  List<InfoBoxContent>? infoBoxContent;
  bool? showDescription;
  bool? showBackgroundImg;
  bool? showBackgroundColor;
  String? headline;
  bool? showDesc;
  String? videoUrl;
  bool? showHeadline;
  String? backgroundImg;
  String? videoBodyText;
  List<Null>? sliderItems;
  bool? activeSlider;
  bool? applyPadding;
  String? sliderNumber;
  List<ImageContents>? imageContents;
  bool? showYear;
  bool? showTitle;
  List<HistoryContents>? historyContents;
  String? leftImg;
  String? rightImg;
  bool? applyMargin;
  String? ctaBodyText;
  String? ctaSubTitle;
  bool? showLeftImg;
  bool? showBodyText;
  bool? showRightImg;
  bool? showSubTitle;
  String? ctaButtonLink;
  String? ctaButtonTitle;
  String? ctaHeadingText;
  bool? showRating;
  List<CardContents>? cardContents;
  String? sectionTitle;
  bool? sliderActive;
  bool? showQuoteIcon;
  String? backgroundImage;
  List<Null>? sliderBreakpoint;
  bool? showSectionTitle;
  bool? showBackgroundImage;
  bool? activeBackgroundColor;
  bool? showSectionTitleBorder;

  ContentData(
      {this.margin,
      this.padding,
      this.subTitle,
      this.aboutLink,
      this.bannerImg,
      this.showImage,
      this.showButton,
      this.aboutLayout,
      this.buttonTitle,
      this.aboutContent,
      this.aboutHeading,
      this.showListItems,
      this.aboutThumbText,
      this.backgroundColor,
      this.showSectionContent,
      this.showAboutThumbMeta,
      this.showIcon,
      this.showLink,
      this.textAlign,
      this.showHeading,
      this.bannerColumn,
      this.infoBoxContent,
      this.showDescription,
      this.showBackgroundImg,
      this.showBackgroundColor,
      this.headline,
      this.showDesc,
      this.videoUrl,
      this.showHeadline,
      this.backgroundImg,
      this.videoBodyText,
      this.activeSlider,
      this.applyPadding,
      this.sliderNumber,
      this.imageContents,
      this.showYear,
      this.showTitle,
      this.historyContents,
      this.leftImg,
      this.rightImg,
      this.applyMargin,
      this.ctaBodyText,
      this.ctaSubTitle,
      this.showLeftImg,
      this.showBodyText,
      this.showRightImg,
      this.showSubTitle,
      this.ctaButtonLink,
      this.ctaButtonTitle,
      this.ctaHeadingText,
      this.showRating,
      this.cardContents,
      this.sectionTitle,
      this.sliderActive,
      this.showQuoteIcon,
      this.backgroundImage,
      this.sliderBreakpoint,
      this.showSectionTitle,
      this.showBackgroundImage,
      this.activeBackgroundColor,
      this.showSectionTitleBorder});

  ContentData.fromJson(Map<String, dynamic> json) {
    margin = json['margin'];
    padding = json['padding'];
    subTitle = json['sub_title'];
    aboutLink = json['about_link'];
    bannerImg = json['banner_img'];
    showImage = json['show_image'];
    showButton = json['show_button'];
    aboutLayout = json['about_layout'];
    buttonTitle = json['button_title'];
    aboutContent = json['about_content'];
    aboutHeading = json['about_heading'];
    showListItems = json['show_list_items'];
    aboutThumbText = json['about_thumb_text'];
    backgroundColor = json['background_color'];
    showSectionContent = json['show_section_content'];
    showAboutThumbMeta = json['show_about_thumb_meta'];
    showIcon = json['show_icon'];
    showLink = json['show_link'];
    textAlign = json['text_align'];
    showHeading = json['show_heading'];
    bannerColumn = json['banner_column'];
    if (json['info_box_content'] != null) {
      infoBoxContent = <InfoBoxContent>[];
      json['info_box_content'].forEach((v) {
        infoBoxContent!.add(InfoBoxContent.fromJson(v));
      });
    }
    showDescription = json['show_description'];
    showBackgroundImg = json['show_background_img'];
    showBackgroundColor = json['show_background_color'];
    headline = json['headline'];
    showDesc = json['show_desc'];
    videoUrl = json['video_url'];
    showHeadline = json['show_headline'];
    backgroundImg = json['background_img'];
    videoBodyText = json['video_body_text'];
    activeSlider = json['active_slider'];
    applyPadding = json['apply_padding'];
    sliderNumber = json['slider_number'];
    if (json['image_contents'] != null) {
      imageContents = <ImageContents>[];
      json['image_contents'].forEach((v) {
        imageContents!.add(ImageContents.fromJson(v));
      });
    }
    showYear = json['show_year'];
    showTitle = json['show_title'];
    if (json['history_contents'] != null) {
      historyContents = <HistoryContents>[];
      json['history_contents'].forEach((v) {
        historyContents!.add(HistoryContents.fromJson(v));
      });
    }
    leftImg = json['left_img'];
    rightImg = json['right_img'];
    applyMargin = json['apply_margin'];
    ctaBodyText = json['cta_body_text'];
    ctaSubTitle = json['cta_sub_title'];
    showLeftImg = json['show_left_img'];
    showBodyText = json['show_body_text'];
    showRightImg = json['show_right_img'];
    showSubTitle = json['show_sub_title'];
    ctaButtonLink = json['cta_button_link'];
    ctaButtonTitle = json['cta_button_title'];
    ctaHeadingText = json['cta_heading_text'];
    showRating = json['show_rating'];
    if (json['card_contents'] != null) {
      cardContents = <CardContents>[];
      json['card_contents'].forEach((v) {
        cardContents!.add(CardContents.fromJson(v));
      });
    }
    sectionTitle = json['section_title'];
    sliderActive = json['slider_active'];
    showQuoteIcon = json['show_quote_icon'];
    backgroundImage = json['background_image'];
    showSectionTitle = json['show_section_title'];
    showBackgroundImage = json['show_background_image'];
    activeBackgroundColor = json['active_background_color'];
    showSectionTitleBorder = json['show_section_title_border'];
  }
}

class InfoBoxContent {
  String? boxIcon;
  String? boxHeading;
  String? boxLinkUrl;
  String? boxLinkTitle;
  String? boxDescription;
  String? backgroundImage;

  InfoBoxContent(
      {this.boxIcon,
      this.boxHeading,
      this.boxLinkUrl,
      this.boxLinkTitle,
      this.boxDescription,
      this.backgroundImage});

  InfoBoxContent.fromJson(Map<String, dynamic> json) {
    boxIcon = json['box_icon'];
    boxHeading = json['box_heading'];
    boxLinkUrl = json['box_link_url'];
    boxLinkTitle = json['box_link_title'];
    boxDescription = json['box_description'];
    backgroundImage = json['background_image'];
  }
}

class ImageContents {
  String? link;
  String? image;
  String? backgroundImage;

  ImageContents({this.link, this.image, this.backgroundImage});

  ImageContents.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    image = json['image'];
    backgroundImage = json['background_image'];
  }
}

class HistoryContents {
  String? year;
  String? image;
  String? title;
  String? description;

  HistoryContents({this.year, this.image, this.title, this.description});

  HistoryContents.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }
}

class CardContents {
  String? image;
  String? title;
  String? rating;
  String? subTitle;
  String? previewUrl;
  String? description;

  CardContents(
      {this.image,
      this.title,
      this.rating,
      this.subTitle,
      this.previewUrl,
      this.description});

  CardContents.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    rating = json['rating'];
    subTitle = json['sub_title'];
    previewUrl = json['previewUrl'];
    description = json['description'];
  }
}
