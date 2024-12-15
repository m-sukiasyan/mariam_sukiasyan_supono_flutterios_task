import 'package:mariam_sukiasyan_supono_flutterios_task/data/database/init_database/entities/user_entity.dart';

import '../../../core/enums/pass_info_step_enum.dart';

enum PassInfoStatesEnum { initial, loading, loaded, genderUpdated, error}

class PassInfoStates {
  final PassInfoStatesEnum passInfoStatesEnum;
  final String? errorMessage;
  final PassInfoStepEnum currentStep;
  final UserEntity userEntity;
  final List<PassInfoStepEnum> passInfoSteps;

  PassInfoStates({
    this.passInfoStatesEnum = PassInfoStatesEnum.initial,
    this.currentStep = PassInfoStepEnum.birthday,
    required this.userEntity,
    this.passInfoSteps = const [
      PassInfoStepEnum.birthday,
      PassInfoStepEnum.nickname,
      PassInfoStepEnum.gender,
      PassInfoStepEnum.photo,
    ],
    this.errorMessage,
  });

  PassInfoStates copyWith({
    PassInfoStatesEnum? passInfoStatesEnum,
    PassInfoStepEnum? currentStep,
    UserEntity? userEntity,
    String? errorMessage,
  }) {
    return PassInfoStates(
      passInfoStatesEnum: passInfoStatesEnum ?? this.passInfoStatesEnum,
      currentStep: currentStep ?? this.currentStep,
      userEntity: userEntity ?? this.userEntity,
      passInfoSteps: passInfoSteps,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isStepDataValid() {
    switch (currentStep) {
      case PassInfoStepEnum.birthday:
        return userEntity.birthday != null && userEntity.birthday!.isNotEmpty;
      case PassInfoStepEnum.nickname:
        return userEntity.userName != null && userEntity.userName!.isNotEmpty;
      case PassInfoStepEnum.gender:
        return userEntity.gender != null && userEntity.gender!.isNotEmpty;
      case PassInfoStepEnum.photo:
        return userEntity.photo != null && userEntity.photo!.isNotEmpty;
    }
  }
}