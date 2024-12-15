import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_states.dart';

import '../../../core/utils/nullable.dart';
import '../../../data/database/init_database/entities/user_entity.dart';

class PreviewBloc extends Bloc<PreviewEvents, PreviewStates> {

  PreviewBloc() : super(PreviewStates()) {
    on<SaveUserEvent>(onSaveUserEvent);
    on<UpdateAdBannerEvent>(_onUpdateAdBannerEvent);
  }

  Future<void> onSaveUserEvent(SaveUserEvent event,
      Emitter<PreviewStates> emit) async {
    emit(state.copyWith(previewStatesEnum: PreviewStatesEnum.loading));
    UserEntity? userEntity;
    userEntity = event.userEntity != null
        ? event.userEntity!
        : await UserEntity.myProfile;
    userEntity?.photo = event.base64Photo;
    if (userEntity != null) {
      await UserEntity.addUserProfile(userEntity);
    }
    emit(state.copyWith(previewStatesEnum: PreviewStatesEnum.loaded));
  }

  void _onUpdateAdBannerEvent(UpdateAdBannerEvent event,
      Emitter<PreviewStates> emit) {
    if (event.bannerAd == null) {
      emit(state.copyWith(
          previewStatesEnum: PreviewStatesEnum.bannerAddUpdated,
          nullableBannerAd: Nullable(null)));
    } else {
      emit(state.copyWith(
          previewStatesEnum: PreviewStatesEnum.bannerAddUpdated,
          bannerAd: event.bannerAd));
    }
  }
}