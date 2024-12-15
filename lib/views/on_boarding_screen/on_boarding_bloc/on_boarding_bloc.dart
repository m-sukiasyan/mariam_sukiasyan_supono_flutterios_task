import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_events.dart';
import 'on_boarding_states.dart';

class OnboardingBloc extends Bloc<OnboardingEvents, OnboardingStates> {

  OnboardingBloc() : super(OnboardingStates()) {
  }
}