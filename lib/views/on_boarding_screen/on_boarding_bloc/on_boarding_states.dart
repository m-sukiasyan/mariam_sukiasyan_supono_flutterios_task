enum OnboardingStatesEnum { initial, loading, loaded, error}

class OnboardingStates {
  final OnboardingStatesEnum onboardingStatesEnum;
  final String? errorMessage;

  const OnboardingStates({
    this.onboardingStatesEnum = OnboardingStatesEnum.initial,
    this.errorMessage});

  OnboardingStates copyWith({
    required OnboardingStatesEnum onboardingStatesEnum,
    String? errorMessage}) {
    return OnboardingStates(
      onboardingStatesEnum: onboardingStatesEnum,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
