import 'package:flutter_bloc/flutter_bloc.dart';
import 'camera_events.dart';
import 'camera_states.dart';

class CameraBloc extends Bloc<CameraEvents, CameraStates> {

  CameraBloc() : super(CameraStates()) {
    on<SetCamerasEvent>(_onSetCamerasEvent);
    on<SetUpdatedCameraEvent>(_onSetUpdatedCameraEvent);
    on<SetFocusPointEvent>(_onSetFocusPointEvent);
    on<TakePhotoEvent>(onTakePhotoEvent);
  }

  void onTakePhotoEvent(TakePhotoEvent event, Emitter<CameraStates> emit) {
    emit(state.copyWith(
        cameraStatesEnum: CameraStatesEnum.loaded,
        isTakingPhoto: event.isTakingPhoto));
  }

  _onSetCamerasEvent(SetCamerasEvent event, Emitter<CameraStates> emit) {
    emit(state.copyWith(
      cameraStatesEnum: CameraStatesEnum.loaded,
      cameras: event.cameras,
    ));
  }

  _onSetUpdatedCameraEvent(SetUpdatedCameraEvent event,
      Emitter<CameraStates> emit) {
    emit(state.copyWith(
      cameraStatesEnum: CameraStatesEnum.loaded,
      selectedCameraDescription: event.selectedCameraDescription,
    ));
  }

  _onSetFocusPointEvent(SetFocusPointEvent event, Emitter<CameraStates> emit) {
    emit(state.copyWith(
        cameraStatesEnum: CameraStatesEnum.loaded,
        focusPoint: event.focusPoint,
        showFocusIndicator: event.showFocusIndicator
    ));
  }
}
