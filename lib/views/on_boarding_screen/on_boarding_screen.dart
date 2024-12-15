import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/utils/navigator_extension.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/on_boarding_screen/on_boarding_bloc/on_boarding_states.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen.dart';
import '../../core/custom_widgets/show_circular_progress.dart';
import '../../core/di/injection_dependencies.dart';
import '../../core/utils/images.dart';
import 'on_boarding_bloc/on_boarding_bloc.dart';
import 'on_boarding_screen_widgets/bottom_container_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingBloc _onboardingBloc = getIt<OnboardingBloc>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _init(BuildContext providerContext) async {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _onboardingBloc,
      child: BlocConsumer<OnboardingBloc, OnboardingStates>(
        listener: (context, state) {
          if (state.onboardingStatesEnum == OnboardingStatesEnum.loaded) {}
        },
        builder: (providerContext, state) {
          return _buildViewPerState(state, providerContext);
        },
      ),
    );
  }

  Widget _buildViewPerState(OnboardingStates states,
      BuildContext providerContext) {
    if (states.onboardingStatesEnum == OnboardingStatesEnum.initial) {
      _init(providerContext);
    } else if (states.onboardingStatesEnum == OnboardingStatesEnum.loading) {
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Images.bgFirstScreenPNG,
              fit: BoxFit.cover,
            ),
          ),
          BottomContainerWidget(
            onPressed: () {
              context.pushNavigator(const PassInfoScreen());
            },
          )
        ],
      ),
    );
  }
}
