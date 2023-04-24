class ScreenShotModel {
  ScreenShotModel({
    this.backdrops,
    this.id,
    this.logos,
    this.posters,
  });

  List<dynamic>? backdrops;
  int? id;
  List<dynamic>? logos;
  List<dynamic>? posters;

  ScreenShotModel.fromJson(Map<String, dynamic> json) {
    backdrops = List.castFrom<dynamic, dynamic>(json['backdrops']);
    id = json['id'];
    logos = List.castFrom<dynamic, dynamic>(json['logos']);
    posters = List.castFrom<dynamic, dynamic>(json['posters']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['backdrops'] = backdrops;
    data['id'] = id;
    data['logos'] = logos;
    data['posters'] = posters;
    return data;
  }
}
