import '../../core/enums/settings_item_type_enum.dart';

class SettingsDataModel {
  final String title;
  final String? tag;
  final List<SettingsDataModel>? items;
  final SettingsItemType type;

  SettingsDataModel({
    required this.title,
    required this.type,
    this.tag,
    this.items,
  });
}
