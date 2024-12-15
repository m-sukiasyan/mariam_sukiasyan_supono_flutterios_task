import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_bloc/pass_info_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_bloc/pass_info_states.dart';

import '../../../core/enums/pass_info_step_enum.dart';
import '../../../data/database/init_database/entities/user_entity.dart';


class PassInfoBloc extends Bloc<PassInfoEvents, PassInfoStates> {

  PassInfoBloc() : super(PassInfoStates(userEntity: UserEntity())) {
    on<PassInfoLoadNextStepEvent>(onPassInfoLoadNextStepEvent);
    on<PassInfoLoadPreviousStepEvent>(onPassInfoLoadPreviousStepEvent);
    on<PassInfoSelectGenderEvent>(onPassInfoSelectGenderEvent);
    on<PassInfoSaveBirthdayEvent>(onPassInfoSaveBirthdayEvent);
    on<PassInfoSaveNicknameEvent>(onPassInfoSaveNicknameEvent);
  }

  void onPassInfoLoadNextStepEvent(PassInfoLoadNextStepEvent event,
      Emitter<PassInfoStates> emit) {
    emit(state.copyWith(passInfoStatesEnum: PassInfoStatesEnum.loading));
    PassInfoStepEnum nextStep = _getNextStep(state.currentStep);
    emit(state.copyWith(
        currentStep: nextStep,
        passInfoStatesEnum: PassInfoStatesEnum.loaded));
  }

  void onPassInfoLoadPreviousStepEvent(PassInfoLoadPreviousStepEvent event,
      Emitter<PassInfoStates> emit) {
    emit(state.copyWith(passInfoStatesEnum: PassInfoStatesEnum.loading));
    PassInfoStepEnum previousStep = _getPreviousStep(state.currentStep);
    emit(state.copyWith(
        currentStep: previousStep,
        passInfoStatesEnum: PassInfoStatesEnum.loaded));
  }

  void onPassInfoSelectGenderEvent(PassInfoSelectGenderEvent event,
      Emitter<PassInfoStates> emit) {
    emit(state.copyWith(passInfoStatesEnum: PassInfoStatesEnum.loading));
    final updatedUserEntity = state.userEntity;
    updatedUserEntity.gender = event.newGender;

    emit(state.copyWith(
        userEntity: updatedUserEntity,
        passInfoStatesEnum: PassInfoStatesEnum.genderUpdated));
  }

  void onPassInfoSaveBirthdayEvent(
      PassInfoSaveBirthdayEvent event, Emitter<PassInfoStates> emit) {
    emit(state.copyWith(passInfoStatesEnum: PassInfoStatesEnum.loading));

    final updatedUserEntity = state.userEntity;
    updatedUserEntity.birthday = event.birthday?.toIso8601String();

    emit(state.copyWith(
      userEntity: updatedUserEntity,
      passInfoStatesEnum: PassInfoStatesEnum.loaded,
    ));
  }

  void onPassInfoSaveNicknameEvent(
      PassInfoSaveNicknameEvent event, Emitter<PassInfoStates> emit) {
    emit(state.copyWith(passInfoStatesEnum: PassInfoStatesEnum.loading));

    final updatedUserEntity = state.userEntity;
    updatedUserEntity.userName = event.nickname;

    emit(state.copyWith(
      userEntity: updatedUserEntity,
      passInfoStatesEnum: PassInfoStatesEnum.loaded,
    ));
  }

  PassInfoStepEnum _getNextStep(PassInfoStepEnum currentStep) {
    final currentIndex = state.passInfoSteps.indexOf(currentStep);
    if (currentIndex == -1 || currentIndex == state.passInfoSteps.length - 1) {
      return PassInfoStepEnum.birthday;
    }
    return state.passInfoSteps[currentIndex + 1];
  }

  PassInfoStepEnum _getPreviousStep(PassInfoStepEnum currentStep) {
    final currentIndex = state.passInfoSteps.indexOf(currentStep);

    if (currentIndex <= 0) {
      return PassInfoStepEnum.birthday;
    }
    return state.passInfoSteps[currentIndex - 1];
  }
}