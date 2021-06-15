class SocialModel {
  bool status;
  String errNum;
  String msg;
  List<SocialMedia> socialMedia;

  SocialModel({this.status, this.errNum, this.msg, this.socialMedia});

  SocialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['social_media'] != null) {
      socialMedia = new List<SocialMedia>();
      json['social_media'].forEach((v) {
        socialMedia.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialMedia {
  int id;
  String name;
  String logo;
  String link;

  SocialMedia({this.id, this.name, this.logo, this.link});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['link'] = this.link;
    return data;
  }
}
