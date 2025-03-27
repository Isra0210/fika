enum GenderType { man, woman, nonBinary, other }

enum GenderTypeLookingFor { man, woman, all }

enum ChoiceSetupApp { movie, restaurant }

class RegisterModel {
  RegisterModel({
    this.genderType,
    this.birthday,
    this.genderTypeLookingFor,
    this.maxDistance,
    this.minAgeRange,
    this.maxAgeRange,
    this.latitude,
    this.longitude,
    this.choiceSetupApp = ChoiceSetupApp.movie,
  });

  final GenderType? genderType;
  final String? birthday;
  final GenderTypeLookingFor? genderTypeLookingFor;
  final int? maxDistance;
  final int? minAgeRange;
  final int? maxAgeRange;
  final int? latitude;
  final int? longitude;
  final ChoiceSetupApp choiceSetupApp;

  RegisterModel copyWith({
    GenderType? genderType,
    String? birthday,
    GenderTypeLookingFor? genderTypeLookingFor,
    int? maxDistance,
    int? minAgeRange,
    int? maxAgeRange,
    int? latitude,
    int? longitude,
    ChoiceSetupApp? choiceSetupApp,
  }) {
    return RegisterModel(
      genderType: genderType ?? this.genderType,
      birthday: birthday ?? this.birthday,
      genderTypeLookingFor: genderTypeLookingFor ?? this.genderTypeLookingFor,
      maxDistance: maxDistance ?? this.maxDistance,
      minAgeRange: minAgeRange ?? this.minAgeRange,
      maxAgeRange: maxAgeRange ?? this.maxAgeRange,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      choiceSetupApp: choiceSetupApp ?? this.choiceSetupApp,
    );
  }

  @override
  String toString() {
    return 'RegisterModel(genderType: $genderType, birthday: $birthday, genderTypeLookingFor: $genderTypeLookingFor, maxDistance: $maxDistance, minAgeRange: $minAgeRange, maxAgeRange: $maxAgeRange, latitude: $latitude, longitude: $longitude,choiceSetupApp: $choiceSetupApp)';
  }

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.genderType == genderType &&
        other.birthday == birthday &&
        other.genderTypeLookingFor == genderTypeLookingFor &&
        other.maxDistance == maxDistance &&
        other.minAgeRange == minAgeRange &&
        other.maxAgeRange == maxAgeRange &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.choiceSetupApp == choiceSetupApp;
  }

  @override
  int get hashCode {
    return genderType.hashCode ^
        birthday.hashCode ^
        genderTypeLookingFor.hashCode ^
        maxDistance.hashCode ^
        minAgeRange.hashCode ^
        maxAgeRange.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        choiceSetupApp.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genderType': genderType?.name,
      'birthday': birthday,
      'genderTypeLookingFor': genderTypeLookingFor?.name,
      'maxDistance': maxDistance,
      'minAgeRange': minAgeRange,
      'maxAgeRange': maxAgeRange,
      'latitude': latitude,
      'longitude': longitude,
      'choiceSetupApp': choiceSetupApp.name,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      genderType:
          map['genderType'] != null ? getGenderByName(map['genderType']) : null,
      birthday: map['birthday'],
      genderTypeLookingFor: map['genderTypeLookingFor'] != null
          ? getGenderLookingFroByName(map['genderTypeLookingFor'])
          : null,
      maxDistance:
          map['maxDistance'] != null ? map['maxDistance'] as int : null,
      minAgeRange:
          map['minAgeRange'] != null ? map['minAgeRange'] as int : null,
      maxAgeRange:
          map['maxAgeRange'] != null ? map['maxAgeRange'] as int : null,
      latitude: map['latitude'],
      longitude: map['longitude'],
      choiceSetupApp: getChoiceSetupApp(map['choiceSetupApp']),
    );
  }

  static GenderType getGenderByName(String type) {
    return switch (type) {
      'man' => GenderType.man,
      'woman' => GenderType.woman,
      'nonBinary' => GenderType.nonBinary,
      _ => GenderType.other,
    };
  }

  static GenderTypeLookingFor getGenderLookingFroByName(String type) {
    return switch (type) {
      'man' => GenderTypeLookingFor.man,
      'woman' => GenderTypeLookingFor.woman,
      _ => GenderTypeLookingFor.all,
    };
  }

  static ChoiceSetupApp getChoiceSetupApp(String type) {
    return switch (type) {
      'movie' => ChoiceSetupApp.movie,
      _ => ChoiceSetupApp.restaurant,
    };
  }
}
