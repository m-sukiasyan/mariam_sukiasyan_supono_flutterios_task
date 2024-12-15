

import 'package:flutter/cupertino.dart';

class SettingsEvents {
  const SettingsEvents();
}

class CreateSettingsMenu extends SettingsEvents {
  final BuildContext context;

  CreateSettingsMenu({required this.context});
}


class RemoveUnlockStatus extends SettingsEvents {
  final BuildContext context;

  RemoveUnlockStatus({required this.context});
}
