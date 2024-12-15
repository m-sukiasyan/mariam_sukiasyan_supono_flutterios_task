
import 'dart:ui';

import 'package:camera/camera.dart';

class CameraEvents {
  const CameraEvents();
}

class SetCamerasEvent extends CameraEvents {
  List<CameraDescription>? cameras;

  SetCamerasEvent(this.cameras);
}

class SetUpdatedCameraEvent extends CameraEvents {
  CameraDescription? selectedCameraDescription;

  SetUpdatedCameraEvent({this.selectedCameraDescription});
}

class SetFocusPointEvent extends CameraEvents {
  final Offset focusPoint;
  final bool showFocusIndicator;

  SetFocusPointEvent(this.focusPoint, this.showFocusIndicator);
}

class TakePhotoEvent extends CameraEvents {
  bool isTakingPhoto;

  TakePhotoEvent(this.isTakingPhoto);
}
