class Data {
  String? appName;
  String? appIcon;
  String? cover;
  String? mainColor;
  String? contact;
  String? about;
  String? privacy;
  String? terms;
  List<Intro>? intro;
  List<Wallpapers>? wallpapers;
  List<String>? pinned;

  Data(
      {this.appName,
      this.appIcon,
      this.cover,
      this.mainColor,
      this.contact,
      this.about,
      this.privacy,
      this.terms,
      this.intro,
      this.wallpapers,
      this.pinned});

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appIcon = json['app_icon'];
    cover = json['cover'];
    mainColor = json['main_color'];
    contact = json['contact'];
    about = json['about'];
    privacy = json['privacy'];
    terms = json['terms'];
    if (json['intro'] != null) {
      intro = <Intro>[];
      json['intro'].forEach((v) {
        intro!.add(Intro.fromJson(v));
      });
    }
    if (json['wallpapers'] != null) {
      wallpapers = <Wallpapers>[];
      json['wallpapers'].forEach((v) {
        wallpapers!.add(Wallpapers.fromJson(v));
      });
    }
    pinned = json['pinned'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_icon'] = appIcon;
    data['cover'] = cover;
    data['main_color'] = mainColor;
    data['contact'] = contact;
    data['about'] = about;
    data['privacy'] = privacy;
    data['terms'] = terms;
    if (intro != null) {
      data['intro'] = intro!.map((v) => v.toJson()).toList();
    }
    if (wallpapers != null) {
      data['wallpapers'] = wallpapers!.map((v) => v.toJson()).toList();
    }
    data['pinned'] = pinned;
    return data;
  }
}

class Intro {
  String? title;
  String? description;
  String? icon;

  Intro({this.title, this.description, this.icon});

  Intro.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Wallpapers {
  String? category;
  String? icon;
  List<String>? images;

  Wallpapers({this.category, this.icon, this.images});

  Wallpapers.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    icon = json['icon'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['icon'] = icon;
    data['images'] = images;
    return data;
  }
}
