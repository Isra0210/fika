import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_model.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.createdAt,
    required this.email,
    this.notificationId,
    this.updatedAt,
    this.genderType,
    this.birthday,
    this.genderTypeLookingFor,
    this.maxDistance,
    this.minAgeRange,
    this.maxAgeRange,
    this.latitude,
    this.longitude,
    this.choiceSetupApp,
    this.id,
  });

  final String name;
  final String email;
  final String? id;
  final Timestamp createdAt;
  final Timestamp? updatedAt;
  final String? notificationId;
  final GenderType? genderType;
  final Timestamp? birthday;
  final GenderTypeLookingFor? genderTypeLookingFor;
  final int? maxDistance;
  final int? minAgeRange;
  final int? maxAgeRange;
  final int? latitude;
  final int? longitude;
  final ChoiceSetupApp? choiceSetupApp;

  UserModel copyWith({
    String? name,
    String? email,
    String? id,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? notificationId,
    GenderType? genderType,
    Timestamp? birthday,
    GenderTypeLookingFor? genderTypeLookingFor,
    int? maxDistance,
    int? minAgeRange,
    int? maxAgeRange,
    int? latitude,
    int? longitude,
    ChoiceSetupApp? choiceSetupApp,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notificationId: notificationId ?? this.notificationId,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'notificationId': notificationId,
      'genderType': genderType?.name,
      'birthday': birthday,
      'genderTypeLookingFor': genderTypeLookingFor?.name,
      'maxDistance': maxDistance,
      'minAgeRange': minAgeRange,
      'maxAgeRange': maxAgeRange,
      'latitude': latitude,
      'longitude': longitude,
      'choiceSetupApp': choiceSetupApp?.name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      id: map['id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      notificationId: map['notificationId'],
      genderType: map['genderType'] != null
          ? RegisterModel.getGenderByName(map['genderType'])
          : null,
      birthday: map['birthday'],
      genderTypeLookingFor: map['genderTypeLookingFor'] != null
          ? RegisterModel.getGenderLookingFroByName(map['genderTypeLookingFor'])
          : null,
      maxDistance: map['maxDistance'],
      minAgeRange: map['minAgeRange'],
      maxAgeRange: map['maxAgeRange'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      choiceSetupApp: map['choiceSetupApp'] != null
          ? RegisterModel.getChoiceSetupApp(map['choiceSetupApp'])
          : null,
    );
  }

  Map<String, dynamic> toStorageMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'notificationId': notificationId,
      'genderType': genderType?.name,
      'birthday': birthday?.millisecondsSinceEpoch,
      'genderTypeLookingFor': genderTypeLookingFor?.name,
      'maxDistance': maxDistance,
      'minAgeRange': minAgeRange,
      'maxAgeRange': maxAgeRange,
      'latitude': latitude,
      'longitude': longitude,
      'choiceSetupApp': choiceSetupApp?.name,
    };
  }

  factory UserModel.fromStorageMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      id: map['id'],
      email: map['email'],
      createdAt: Timestamp.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      notificationId: map['notificationId'],
      genderType: map['genderType'] != null
          ? RegisterModel.getGenderByName(map['genderType'])
          : null,
      birthday: map['birthday'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      genderTypeLookingFor: map['genderTypeLookingFor'] != null
          ? RegisterModel.getGenderLookingFroByName(map['genderTypeLookingFor'])
          : null,
      maxDistance: map['maxDistance'],
      minAgeRange: map['minAgeRange'],
      maxAgeRange: map['maxAgeRange'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      choiceSetupApp: map['choiceSetupApp'] != null
          ? RegisterModel.getChoiceSetupApp(map['choiceSetupApp'])
          : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, notificationId: $notificationId, genderType: $genderType, birthday: $birthday, genderTypeLookingFor: $genderTypeLookingFor, maxDistance: $maxDistance, minAgeRange: $minAgeRange, maxAgeRange: $maxAgeRange, latitude: $latitude, longitude: $longitude, choiceSetupApp: $choiceSetupApp)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.notificationId == notificationId &&
        other.genderType == genderType &&
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
    return name.hashCode ^
        id.hashCode ^
        email.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        notificationId.hashCode ^
        genderType.hashCode ^
        birthday.hashCode ^
        genderTypeLookingFor.hashCode ^
        maxDistance.hashCode ^
        minAgeRange.hashCode ^
        maxAgeRange.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        choiceSetupApp.hashCode;
  }
}
