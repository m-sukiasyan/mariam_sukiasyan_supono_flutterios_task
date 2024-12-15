import 'package:drift/drift.dart';

import '../database.dart';

class UserEntity {
  int? id;
  String? userName;
  String? birthday;
  String? gender;
  String? photo;

  UserEntity({
    this.id,
    this.userName,
    this.birthday,
    this.gender,
    this.photo,
  });

  UserCompanion toCompanionEntry(bool isLoginMerchant) {
    return UserCompanion(
      id: Value(id ?? -1),
      username: Value(userName ?? ""),
      birthday: Value(birthday ?? ""),
      gender: Value(gender ?? ""),
      photo: Value(photo ?? ""),
    );
  }

  static Future<UserEntity> addUserProfile(UserEntity userEntity,
      {bool isLoginMerchant = false}) async {
    final db = AppDb.instance;
    await db
        .into(db.user)
        .insertOnConflictUpdate(userEntity.toCompanionEntry(isLoginMerchant));

    return userEntity;
  }

  static Future<UserEntity?> get myProfile async {
    final db = AppDb.instance;
    UserTable? userTable = await (db.select(db.user))
        .getSingleOrNull();
    return UserEntity._convertTableToEntity(userTable);
  }

  static Future<UserEntity?> getUserProfileById(int id) async {
    final db = AppDb.instance;
    UserTable? userTable = await (db.select(db.user)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return UserEntity._convertTableToEntity(userTable);
  }

  static UserEntity? _convertTableToEntity(UserTable? userTable) {
    UserEntity? userEntity;
    if (userTable != null) {
      userEntity = UserEntity();
      userEntity.id = userTable.id;
      userEntity.userName = userTable.username;
      userEntity.birthday = userTable.birthday;
      userEntity.gender = userTable.gender;
      userEntity.photo = userTable.photo;
    }
    return userEntity;
  }
}
