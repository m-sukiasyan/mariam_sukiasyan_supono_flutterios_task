import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/navigator_extension.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/camera_screen/camera_bloc/camera_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/camera_screen/camera_bloc/camera_states.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/custom_widgets/show_circular_progress.dart';
import '../../core/di/injection_dependencies.dart';
import '../../core/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/database/init_database/entities/user_entity.dart';
import 'camera_bloc/camera_bloc.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final UserEntity? userEntity;

  const CameraScreen({super.key, this.userEntity});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  final CameraBloc _cameraBloc = getIt<CameraBloc>();
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndReinitializeCamera();
    }
  }

  Future<void> _checkAndReinitializeCamera() async {
    var cameraPermissionStatus = await Permission.camera.status;
    var microphonePermissionStatus = await Permission.microphone.status;

    if (cameraPermissionStatus.isGranted &&
        microphonePermissionStatus.isGranted) {
      initializeCamera();
    } else {
      debugPrint("Permissions are still denied.");
    }
  }

  void _init(BuildContext providerContext) async {
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    var cameraPermissionStatus = await Permission.camera.request();
    var microphonePermissionStatus = await Permission.microphone.request();

    if (cameraPermissionStatus.isDenied ||
        microphonePermissionStatus.isDenied) {
      _showPermissionDeniedDialog();
      return;
    }

    if (cameraPermissionStatus.isPermanentlyDenied ||
        microphonePermissionStatus.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
      return;
    }

    if (cameraPermissionStatus.isGranted &&
        microphonePermissionStatus.isGranted) {
      var cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController?.initialize();
      _cameraBloc.add(SetCamerasEvent(cameras));
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.permissionRequired),
          content: Text(
            AppLocalizations.of(context)!.cameraPermissionDSC,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: Text(AppLocalizations.of(context)!.openSettings),
            ),
          ],
        );
      },
    );
  }

  Future<void> takePhoto() async {
    if (_cameraBloc.state.isTakingPhoto || _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    setState(() {
      _cameraBloc.state.isTakingPhoto = true;
    });

    try {
      final image = await _cameraController?.takePicture();
      if (image != null) {
        context.pushNavigator(
          PreviewScreen(
            userEntity: widget.userEntity,
            imagePath: image.path,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    } finally {
      setState(() {
        _cameraBloc.state.isTakingPhoto = false;
      });
    }
  }

  Future<void> _onTapToFocus(TapDownDetails details,
      BuildContext context) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    RenderBox box = context.findRenderObject() as RenderBox;
    Offset tapPosition = box.globalToLocal(details.globalPosition);
    Size size = box.size;

    double x = tapPosition.dx / size.width;
    double y = tapPosition.dy / size.height;

    await _cameraController!.setFocusPoint(Offset(x, y));
    _cameraBloc.add(SetFocusPointEvent(tapPosition, true));

    Future.delayed(const Duration(seconds: 1), () {
      _cameraBloc.add(SetFocusPointEvent(tapPosition, false));
    });
  }

  Future<void> changeCameraMode() async {
    if (_cameraBloc.state.cameras != null &&
        _cameraBloc.state.cameras!.length > 1) {
      final newCamera = _cameraController!.description.lensDirection ==
          CameraLensDirection.front
          ? _cameraBloc.state.cameras!.firstWhere(
              (camera) =>
          camera.lensDirection == CameraLensDirection.back)
          : _cameraBloc.state.cameras!.firstWhere(
              (camera) =>
          camera.lensDirection == CameraLensDirection.front);

      await _cameraController?.dispose();

      _cameraController =
          CameraController(newCamera, ResolutionPreset.high);

      await _cameraController?.initialize();

      _cameraBloc.add(
          SetUpdatedCameraEvent(selectedCameraDescription: newCamera));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _cameraBloc,
      child: BlocConsumer<CameraBloc, CameraStates>(
        listener: (context, state) {
          if (state.cameraStatesEnum == CameraStatesEnum.loaded) {}
        },
        builder: (providerContext, state) {
          return buildViewPerState(state, providerContext);
        },
      ),
    );
  }

  Widget buildViewPerState(CameraStates states, BuildContext providerContext) {
    if (states.cameraStatesEnum == CameraStatesEnum.initial) {
      _init(providerContext);
    } else if (states.cameraStatesEnum == CameraStatesEnum.loading) {
      return Stack(
        children: [
          buildView(),
          const ShowCircularProgress(),
        ],
      );
    }
    return buildView();
  }

  Widget buildView() {
    return Scaffold(
        body: GestureDetector(
          onTapDown: (details) => _onTapToFocus(details, context),
          child: Stack(
            children: [
              if (_cameraController != null &&
                  _cameraController!.value.isInitialized)
                Positioned.fill(
                  child: CameraPreview(_cameraController!),
                ),
              if (_cameraBloc.state.showFocusIndicator &&
                  _cameraBloc.state.focusPoint != null)
                Positioned(
                  top: _cameraBloc.state.focusPoint!.dy - 25,
                  left: _cameraBloc.state.focusPoint!.dx - 25,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.yellow,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              if (widget.userEntity != null)
                Positioned(
                  top: 59,
                  left: 25,
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      Images.icBackSVG,
                      width: 44.w,
                      height: 44.h,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              // Switch camera button
              Positioned(
                top: 59,
                right: 25,
                child: GestureDetector(
                  child: Image.asset(
                    Images.icSwipePNG,
                    width: 44.w,
                    height: 44.h,
                  ),
                  onTap: () {
                    changeCameraMode();
                  },
                ),
              ),
              // Capture button
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      takePhoto();
                    },
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
