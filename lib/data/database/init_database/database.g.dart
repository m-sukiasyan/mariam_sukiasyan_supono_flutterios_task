// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class User extends Table with TableInfo<User, UserTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  User(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY DEFAULT 1',
      defaultValue: const CustomExpression('1'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
      'birthday', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
      'photo', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL');
  @override
  List<GeneratedColumn> get $columns => [id, username, birthday, gender, photo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo']!, _photoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birthday']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      photo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo']),
    );
  }

  @override
  User createAlias(String alias) {
    return User(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class UserTable extends DataClass implements Insertable<UserTable> {
  final int id;
  final String? username;
  final String? birthday;
  final String? gender;
  final String? photo;
  const UserTable(
      {required this.id,
      this.username,
      this.birthday,
      this.gender,
      this.photo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      photo:
          photo == null && nullToAbsent ? const Value.absent() : Value(photo),
    );
  }

  factory UserTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTable(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      gender: serializer.fromJson<String?>(json['gender']),
      photo: serializer.fromJson<String?>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String?>(username),
      'birthday': serializer.toJson<String?>(birthday),
      'gender': serializer.toJson<String?>(gender),
      'photo': serializer.toJson<String?>(photo),
    };
  }

  UserTable copyWith(
          {int? id,
          Value<String?> username = const Value.absent(),
          Value<String?> birthday = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> photo = const Value.absent()}) =>
      UserTable(
        id: id ?? this.id,
        username: username.present ? username.value : this.username,
        birthday: birthday.present ? birthday.value : this.birthday,
        gender: gender.present ? gender.value : this.gender,
        photo: photo.present ? photo.value : this.photo,
      );
  UserTable copyWithCompanion(UserCompanion data) {
    return UserTable(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      gender: data.gender.present ? data.gender.value : this.gender,
      photo: data.photo.present ? data.photo.value : this.photo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTable(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, birthday, gender, photo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTable &&
          other.id == this.id &&
          other.username == this.username &&
          other.birthday == this.birthday &&
          other.gender == this.gender &&
          other.photo == this.photo);
}

class UserCompanion extends UpdateCompanion<UserTable> {
  final Value<int> id;
  final Value<String?> username;
  final Value<String?> birthday;
  final Value<String?> gender;
  final Value<String?> photo;
  const UserCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.photo = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.photo = const Value.absent(),
  });
  static Insertable<UserTable> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? birthday,
    Expression<String>? gender,
    Expression<String>? photo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (birthday != null) 'birthday': birthday,
      if (gender != null) 'gender': gender,
      if (photo != null) 'photo': photo,
    });
  }

  UserCompanion copyWith(
      {Value<int>? id,
      Value<String?>? username,
      Value<String?>? birthday,
      Value<String?>? gender,
      Value<String?>? photo}) {
    return UserCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      photo: photo ?? this.photo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final User user = User(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user];
}

typedef $UserCreateCompanionBuilder = UserCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> birthday,
  Value<String?> gender,
  Value<String?> photo,
});
typedef $UserUpdateCompanionBuilder = UserCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String?> birthday,
  Value<String?> gender,
  Value<String?> photo,
});

class $UserFilterComposer extends Composer<_$AppDb, User> {
  $UserFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photo => $composableBuilder(
      column: $table.photo, builder: (column) => ColumnFilters(column));
}

class $UserOrderingComposer extends Composer<_$AppDb, User> {
  $UserOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photo => $composableBuilder(
      column: $table.photo, builder: (column) => ColumnOrderings(column));
}

class $UserAnnotationComposer extends Composer<_$AppDb, User> {
  $UserAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);
}

class $UserTableManager extends RootTableManager<
    _$AppDb,
    User,
    UserTable,
    $UserFilterComposer,
    $UserOrderingComposer,
    $UserAnnotationComposer,
    $UserCreateCompanionBuilder,
    $UserUpdateCompanionBuilder,
    (UserTable, BaseReferences<_$AppDb, User, UserTable>),
    UserTable,
    PrefetchHooks Function()> {
  $UserTableManager(_$AppDb db, User table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $UserFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $UserOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $UserAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> birthday = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> photo = const Value.absent(),
          }) =>
              UserCompanion(
            id: id,
            username: username,
            birthday: birthday,
            gender: gender,
            photo: photo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> birthday = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> photo = const Value.absent(),
          }) =>
              UserCompanion.insert(
            id: id,
            username: username,
            birthday: birthday,
            gender: gender,
            photo: photo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $UserProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    User,
    UserTable,
    $UserFilterComposer,
    $UserOrderingComposer,
    $UserAnnotationComposer,
    $UserCreateCompanionBuilder,
    $UserUpdateCompanionBuilder,
    (UserTable, BaseReferences<_$AppDb, User, UserTable>),
    UserTable,
    PrefetchHooks Function()>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $UserTableManager get user => $UserTableManager(_db, _db.user);
}
