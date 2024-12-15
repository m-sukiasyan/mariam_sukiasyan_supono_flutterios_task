import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/custom_colors.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/navigator_extension.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/camera_screen/camera_screen.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_bloc/pass_info_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_bloc/pass_info_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_bloc/pass_info_states.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_birthday_step_widget.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_date_field_widget.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_gender_step_widget.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_nick_name_step_widget.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen_widgets/pass_info_photo_step_widget.dart';
import '../../core/custom_widgets/custom_circular_progress_indicator.dart';
import '../../core/custom_widgets/show_circular_progress.dart';
import '../../core/di/injection_dependencies.dart';
import '../../core/enums/pass_info_step_enum.dart';
import '../../core/utils/helper_methods.dart';
import '../../core/utils/images.dart';
import '../../data/models/gender_options_model.dart';
import '../../data/models/photo_instructions_model.dart';

class PassInfoScreen extends StatefulWidget {
  const PassInfoScreen({super.key});

  @override
  State<PassInfoScreen> createState() => _PassInfoScreenState();
}

class _PassInfoScreenState extends State<PassInfoScreen> {
  final PassInfoBloc _passInfoBloc = getIt<PassInfoBloc>();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _init(BuildContext providerContext) async {}


  double _calculateProgress(PassInfoStates state) {
    final currentIndex = state.passInfoSteps.indexOf(state.currentStep);
    final totalSteps = state.passInfoSteps.length;
    if (currentIndex == -1 || totalSteps == 0) {
      return 0.0;
    }

    return (currentIndex + 1) / totalSteps;
  }

  void _onBirthdayEntered(String day, String month, String year) {
    DateTime? birthday;
    if (day.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
      birthday = DateTime(int.parse(year), int.parse(month), int.parse(day));
    }
    _passInfoBloc.add(PassInfoSaveBirthdayEvent(birthday));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _passInfoBloc,
      child: BlocConsumer<PassInfoBloc, PassInfoStates>(
        listener: (context, state) {
          if (state.passInfoStatesEnum == PassInfoStatesEnum.genderUpdated) {
            _passInfoBloc.add(PassInfoLoadNextStepEvent());
          }
        },
        builder: (providerContext, state) {
          return _buildViewPerState(state, providerContext);
        },
      ),
    );
  }

  Widget _buildViewPerState(PassInfoStates states,
      BuildContext providerContext) {
    if (states.passInfoStatesEnum == PassInfoStatesEnum.initial) {
      _init(providerContext);
    } else if (states.passInfoStatesEnum == PassInfoStatesEnum.loading) {
      return Stack(
        children: [
          _buildView(),
          const ShowCircularProgress(),
        ],
      );
    }
    return Stack(
      children: [_buildView()],
    );
  }

  Widget _buildView() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Image.asset(
              HelperMethods.getBackgroundImage(_passInfoBloc.state.currentStep),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 25.w,
            top: 59.h,
            child: GestureDetector(
                child: SvgPicture.asset(
                  _passInfoBloc.state.currentStep ==
                      PassInfoStepEnum.birthday
                      ? Images.icCloseSVG
                      : Images.icBackSVG,
                  width: 44.w,
                  height: 44.h,
                ),
                onTap: () =>
                {
                  _passInfoBloc.state.currentStep ==
                      PassInfoStepEnum.birthday
                      ? Navigator.pop(context)
                      : _passInfoBloc.add(
                      PassInfoLoadPreviousStepEvent()),
                }
            ),
          ),
          Positioned(
            right: 25.w,
            top: 59.h,
            child: CircularProgressIndicatorWidget(
              progress: _calculateProgress(_passInfoBloc.state),
            ),
          ),
          SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Gap(152.h),
                      AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _getStepWidget(
                              _passInfoBloc.state.currentStep)
                      ),
                      Gap(16.h),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, bottom: 16.0),
                        child: ElevatedButton(
                          onPressed: _passInfoBloc.state.isStepDataValid()
                              ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _passInfoBloc.add(PassInfoLoadNextStepEvent());
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ]
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _getStepWidget(PassInfoStepEnum step) {
    switch (step) {
      case PassInfoStepEnum.birthday:
        return _buildBirthdayStep();
      case PassInfoStepEnum.nickname:
        return _buildNicknameStep();
      case PassInfoStepEnum.gender:
        return _buildGenderStep();
      case PassInfoStepEnum.photo:
        return _buildPhotoStep();
    }
  }

  Widget _buildBirthdayStep() {
    return PassInfoBirthdayStepWidget(
      onDateEntered: _onBirthdayEntered,
    );
  }

  Widget _buildNicknameStep() {
    return PassInfoNicknameStepWidget(
      nicknameController: _nicknameController,
      onNicknameChanged: (nickname) {
        _passInfoBloc.add(PassInfoSaveNicknameEvent(nickname));
      },
    );
  }

  Widget _buildGenderStep() {
    return PassInfoGenderStepWidget(
      selectedGender: _passInfoBloc.state.userEntity?.gender,
      onGenderSelected: (gender) {
        _passInfoBloc.add(PassInfoSelectGenderEvent(gender));
      },
      genderOptionsModel: GenderOptionsModel.defaultOptions(context),
    );
  }

  Widget _buildPhotoStep() {
    return PassInfoPhotoStepWidget(
      onPhotoButtonPressed: () {
        context.pushNavigator(CameraScreen(
          userEntity: _passInfoBloc.state.userEntity,
        ));
      },
      instructionsModel: PhotoInstructionsModel.defaultInstructions(context),
    );
  }
}
