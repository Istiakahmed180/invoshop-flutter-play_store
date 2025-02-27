class TermsAndConditionModel {
  bool? success;
  Data? data;

  TermsAndConditionModel({this.success, this.data});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? margin;
  String? content;
  String? padding;
  bool? showTitle;
  String? textAlign;
  String? backgroundColor;

  ContentData(
      {this.title,
      this.margin,
      this.content,
      this.padding,
      this.showTitle,
      this.textAlign,
      this.backgroundColor});

  ContentData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    margin = json['margin'];
    content = json['content'];
    padding = json['padding'];
    showTitle = json['show_title'];
    textAlign = json['text_align'];
    backgroundColor = json['background_color'];
  }
}
