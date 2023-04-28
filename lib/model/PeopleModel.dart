class PeopleModel {
  PeopleModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  PeopleModel.fromJson(dynamic json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'] != null
        ? json['also_known_as'].cast<String>()
        : [];
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['also_known_as'] = alsoKnownAs;
    map['biography'] = biography;
    map['birthday'] = birthday;
    map['deathday'] = deathday;
    map['gender'] = gender;
    map['homepage'] = homepage;
    map['id'] = id;
    map['imdb_id'] = imdbId;
    map['known_for_department'] = knownForDepartment;
    map['name'] = name;
    map['place_of_birth'] = placeOfBirth;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    return map;
  }
}
