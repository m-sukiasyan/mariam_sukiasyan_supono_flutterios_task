import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/constants.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/data/database/init_database/entities/user_entity.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/data/secure_storage/secure_storage.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/enums/settings_item_type_enum.dart';
import '../../../data/models/settings_data_model.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsStates> {

  SettingsBloc() : super(SettingsStates()) {
    on<CreateSettingsMenu>(_onCreateSettingsMenu);
    on<RemoveUnlockStatus>(_onRemoveUnlockStatus);
  }

  FutureOr<void> _onCreateSettingsMenu(CreateSettingsMenu event,
      Emitter<SettingsStates> emit) async {
    emit(state.copyWith(settingsStatesEnums: SettingsStatesEnum.loading));

    bool isUnlocked = await SecureStorage.readUnlockData() ?? false;

    List<SettingsDataModel> settingsList = [
      SettingsDataModel(
        title: AppLocalizations.of(event.context)!.settings,
        type: SettingsItemType.section,
        items: [
          if(!isUnlocked)
            SettingsDataModel(
                title: AppLocalizations.of(event.context)!.unlockApp,
                tag: Constants.unlockApp_tag,
                type: SettingsItemType.item),
          SettingsDataModel(title: AppLocalizations.of(event.context)!.rateUs,
              tag: Constants.rateUs_tag,
              type: SettingsItemType.item),
        ],
      ),
      SettingsDataModel(
        title: AppLocalizations.of(event.context)!.myAccount,
        type: SettingsItemType.section,
        items: [
          SettingsDataModel(title: AppLocalizations.of(event.context)!.username,
              tag: Constants.username_tag,
              type: SettingsItemType.item),
          SettingsDataModel(title: AppLocalizations.of(event.context)!.birthday,
              tag: Constants.birthday_tag,
              type: SettingsItemType.item),
        ],
      ),
    ];
    UserEntity? userEntity = await UserEntity.myProfile;

    emit(state.copyWith(
      settingsList: settingsList,
      userEntity: userEntity,
      settingsStatesEnums: SettingsStatesEnum.loaded,
    ));
  }

  Future<void> _onRemoveUnlockStatus(RemoveUnlockStatus event,
      Emitter<SettingsStates> emit) async {
    emit(state.copyWith(
      settingsStatesEnums: SettingsStatesEnum.loading,
    ));

    List<SettingsDataModel> _settingsList = state.settingsList;
    _settingsList.removeWhere((item) => item.tag == Constants.unlockApp_tag);

    await SecureStorage.saveUnlockData();

    emit(state.copyWith(
      settingsList: _settingsList,
      settingsStatesEnums: SettingsStatesEnum.loaded,
    ));
  }
}