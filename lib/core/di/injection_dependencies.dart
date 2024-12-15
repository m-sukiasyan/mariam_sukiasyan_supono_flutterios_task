import 'package:get_it/get_it.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/camera_screen/camera_bloc/camera_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/pass_info_screen/pass_info_screen.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_bloc/preview_bloc.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/preview_screen/preview_screen.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/views/settings_screen/settings_bloc/settings_bloc.dart';

import '../../views/on_boarding_screen/on_boarding_bloc/on_boarding_bloc.dart';
import '../../views/pass_info_screen/pass_info_bloc/pass_info_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  /**
   * ! Other Features
   */
  appContainerDependencies();

  /**
   * ! Blocs
   */
  registerFactoryBloc();

  /**
   * ! Repositories
   */
  registerRepositories();

  /**
   * ! APIs
   */
  registerApis();
}

void appContainerDependencies() {}

void registerFactoryBloc() {
  getIt.registerFactory(() => OnboardingBloc());
  getIt.registerFactory(() => CameraBloc());
  getIt.registerFactory(() => PassInfoBloc());
  getIt.registerFactory(() => PreviewBloc());
  getIt.registerFactory(() => SettingsBloc());
}

void registerRepositories() {
}

void registerApis() {}
