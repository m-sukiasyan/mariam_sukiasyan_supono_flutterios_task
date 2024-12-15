

class PassInfoEvents {
  const PassInfoEvents();
}

class PassInfoLoadNextStepEvent extends PassInfoEvents {
  const PassInfoLoadNextStepEvent();
}

class PassInfoLoadPreviousStepEvent extends PassInfoEvents {
  const PassInfoLoadPreviousStepEvent();
}

class PassInfoSelectGenderEvent extends PassInfoEvents {
  String newGender;

  PassInfoSelectGenderEvent(this.newGender);
}

class PassInfoSaveBirthdayEvent extends PassInfoEvents {
  DateTime? birthday;

  PassInfoSaveBirthdayEvent(this.birthday);
}

class PassInfoSaveNicknameEvent extends PassInfoEvents {
  String nickname;

  PassInfoSaveNicknameEvent(this.nickname);
}