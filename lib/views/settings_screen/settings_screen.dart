import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_events.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_states.dart';
import '../../core/custom_widgets/show_circular_progress.dart';
import '../../core/di/injection_dependencies.dart';
import '../../core/enums/settings_item_type_enum.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/custom_colors.dart';
import '../../core/utils/date_format_converter.dart';
import '../../core/utils/images.dart';
import '../../core/utils/text_style_theme.dart';
import '../../data/models/settings_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  Function returnFunction;

  SettingsScreen({super.key, required this.returnFunction});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final SettingsBloc _settingsBloc = getIt<SettingsBloc>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _init(BuildContext providerContext) async {
    _settingsBloc.add(CreateSettingsMenu(context: providerContext));
  }

  void _handleItemClick(String tag) {
    switch (tag) {
      case Constants.unlockApp_tag:
        _showUnlockDialog();
        break;
      case Constants.rateUs_tag:
        _openRateUsDialog();
        break;
      default:
        break;
    }
  }

  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(AppLocalizations.of(context)!.unlockApp),
            content: Text(AppLocalizations.of(context)!
                .doYouWantToUnlockTheAppAndRemoveAds),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.noThanks),
              ),
              TextButton(
                onPressed: () {
                  _settingsBloc.add(RemoveUnlockStatus(context: context));
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.yes),
              ),
            ],
          ),
    );
  }

  void _openRateUsDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.rateUsDialogOpened),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _settingsBloc,
      child: BlocConsumer<SettingsBloc, SettingsStates>(
        listener: (context, state) {
          if (state.settingsStatesEnum == SettingsStatesEnum.loaded) {}
        },
        builder: (providerContext, state) {
          return _buildViewPerState(state, providerContext);
        },
      ),
    );
  }

  Widget _buildViewPerState(SettingsStates states,
      BuildContext providerContext) {
    if (states.settingsStatesEnum == SettingsStatesEnum.initial) {
      _init(providerContext);
    } else if (states.settingsStatesEnum == SettingsStatesEnum.loading) {
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
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(padding: EdgeInsets.only(left: 25.h),
            child: GestureDetector(
                child: SvgPicture.asset(
                  Images.icBackSVG,
                  width: 44.w,
                  height: 44.h,
                  fit: BoxFit.scaleDown,
                ),
                onTap: () =>
                {
                  widget.returnFunction()
                }
            ),
          )
      ),
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return ListView.builder(
      itemCount: _settingsBloc.state.settingsList.length,
      itemBuilder: (context, index) {
        final item = _settingsBloc.state.settingsList[index];

        if (item.type == SettingsItemType.section) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(item.title),
              Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  decoration: BoxDecoration(
                    color: CustomColors.color221d26,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      ...item.items!
                          .asMap()
                          .entries
                          .map((entry) {
                        final subItem = entry.value;
                        final isLast = entry.key == item.items!.length - 1;

                        return Column(
                          children: [
                            _buildItem(subItem),
                            if (!isLast) _buildLine(),
                          ],
                        );
                      }).toList(),
                    ],
                  )
              )
            ],
          );
        } else {
          return _buildItem(item);
        }
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyleTheme.instance.getStyle(
          TextStyleTheme.latoW500S13,
          CustomColors.color959595,
        ),
      ),
    );
  }

  Widget _buildItem(SettingsDataModel item) {
    String birthday = DateFormatConverter.formatDateToDayMonthYear(
        _settingsBloc.state.userEntity?.birthday ?? "");

    return GestureDetector(
      onTap: () =>
      {
        if (item.tag != null) {_handleItemClick(item.tag!)}
      },
      child: Container(
        height: 55.h,
        margin: EdgeInsets.only(left: 25.w, right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.title,
              style: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoW600S16,
                CustomColors.colorWhite,
              ),
            ),
            Text(
              item.tag == Constants.username_tag ?
              _settingsBloc.state.userEntity?.userName ?? "" :
              item.tag == Constants.birthday_tag ?
              birthday : "",
              style: TextStyleTheme.instance.getStyle(
                TextStyleTheme.latoW600S15,
                CustomColors.color959595,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      height: 1.0,
      color: CustomColors.color3E3744,
    );
  }
}
