class AllGarmentsDataModel {
  Male? male;
  Female? female;

  AllGarmentsDataModel({
    this.male,
    this.female,
  });

  factory AllGarmentsDataModel.fromJson(Map<String, dynamic> json) => AllGarmentsDataModel(
        male: Male.fromJson(json["MALE"]),
        female: Female.fromJson(json["FEMALE"]),
      );
}

class Female {
  List<dynamic>? top;
  List<dynamic>? bottom;
  List<dynamic>? dress;

  Female({
    this.top,
    this.bottom,
    this.dress,
  });

  factory Female.fromJson(Map<String, dynamic> json) => Female(
        top: json["TOP"] == null ? [] : List<dynamic>.from(json["TOP"].map((x) => x)),
        bottom: json["BOTTOM"] == null ? [] : List<dynamic>.from(json["BOTTOM"].map((x) => x)),
        dress: json["DRESS"] == null ? [] : List<dynamic>.from(json["DRESS"].map((x) => x)),
      );
}

class Male {
  List<Garment>? top;
  List<Garment>? bottom;
  List<dynamic>? dress;

  Male({
    this.top,
    this.bottom,
    this.dress,
  });

  factory Male.fromJson(Map<String, dynamic> json) => Male(
        top: json["TOP"] == null ? [] : List<Garment>.from(json["TOP"].map((x) => Garment.fromJson(x))),
        bottom: json["BOTTOM"] == null ? [] : List<Garment>.from(json["BOTTOM"].map((x) => Garment.fromJson(x))),
        dress: json["DRESS"] == null ? [] : List<dynamic>.from(json["DRESS"].map((x) => x)),
      );
}

class Garment {
  String? id;
  String? displayUrl;
  String? name;

  Garment({
    this.id,
    this.displayUrl,
    this.name,
  });

  factory Garment.fromJson(Map<String, dynamic> json) => Garment(
        id: json["id"],
        displayUrl: json["displayUrl"],
        name: json["name"],
      );
}
