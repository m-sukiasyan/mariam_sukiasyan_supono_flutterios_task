import 'package:mariam_sukiasyan_supono_flutterios_task/data/database/init_database/database.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/data/database/init_database/entities/user_entity.dart';

import '../../../data/models/settings_data_model.dart';

enum SettingsStatesEnum { initial, loading, loaded, error}

class SettingsStates {
  final SettingsStatesEnum settingsStatesEnum;
  final String? errorMessage;
  UserEntity? userEntity;
  List<SettingsDataModel> settingsList = [];

  SettingsStates({
    this.settingsStatesEnum = SettingsStatesEnum.initial,
    this.userEntity,
    this.settingsList = const [],
    this.errorMessage});

  SettingsStates copyWith({
    required SettingsStatesEnum settingsStatesEnums,
    List<SettingsDataModel>? settingsList,
    UserEntity? userEntity,
    String? errorMessage}) {
    return SettingsStates(
        settingsStatesEnum: settingsStatesEnum,
        userEntity: userEntity ?? this.userEntity,
        errorMessage: errorMessage ?? this.errorMessage,
        settingsList: settingsList ?? this.settingsList
    );
  }
}
