import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

enum CameraStatesEnum { initial, loading, loaded, error }

class CameraStates {
  final CameraStatesEnum cameraStatesEnum;
  final String? errorMessage;
  final List<CameraDescription>? cameras;
  final CameraDescription? selectedCameraDescription;

  final Offset? focusPoint;
  final bool showFocusIndicator;
  bool isTakingPhoto = false;

  CameraStates({
    this.cameraStatesEnum = CameraStatesEnum.initial,
    this.cameras,
    this.selectedCameraDescription,
    this.isTakingPhoto = false,
    this.errorMessage,
    this.focusPoint,
    this.showFocusIndicator = false,
  });

  CameraStates copyWith({
    CameraStatesEnum? cameraStatesEnum,
    List<CameraDescription>? cameras,
    CameraDescription? selectedCameraDescription,
    String? errorMessage,
    bool? isTakingPhoto,
    Offset? focusPoint,
    bool? showFocusIndicator,
  }) {
    return CameraStates(
      cameraStatesEnum: cameraStatesEnum ?? this.cameraStatesEnum,
      cameras: cameras ?? this.cameras,
      selectedCameraDescription: selectedCameraDescription ??
          this.selectedCameraDescription,
      errorMessage: errorMessage ?? this.errorMessage,
      isTakingPhoto: isTakingPhoto ?? this.isTakingPhoto,
      focusPoint: focusPoint ?? this.focusPoint,
      showFocusIndicator: showFocusIndicator ?? this.showFocusIndicator,
    );
  }
}
