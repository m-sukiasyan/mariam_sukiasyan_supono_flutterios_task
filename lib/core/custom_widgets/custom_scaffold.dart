import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mariam_sukiasyan_supono_flutterios_task/core/enums/page_state_enum.dart';

import '../utils/custom_colors.dart';

class CustomScaffold extends StatelessWidget {
  ///Use to track the current state of the page
  final PageState? pageState;

  ///The main body of the page
  final WidgetBuilder? builder;

  ///If the page state is `noData` or `error` this function is called on the retry button
  final Function? onRetry;

  final Key? key;

  ///The message displayed if `pageState`'s value is `noData`
  final String? noDataMessage;

  const CustomScaffold({
    this.key,
    this.pageState ,
    this.builder,
    this.onRetry,
    this.noDataMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      body: _buildBodyAccordingToState(context),
    );
  }

  ///Checks on the current state and builds the body based on the state.
  Widget _buildBodyAccordingToState(BuildContext context) {
    Widget pageBody = const SizedBox.shrink();
    switch (pageState ?? PageState.loaded) {
      case PageState.loading:
        pageBody = _LoadingWidget();
        break;
      case PageState.loaded:
        pageBody = Builder(
          builder: builder!,
        );
        break;
      case PageState.error:
        pageBody = _ErrorWidget(
          onRetry: onRetry,
        );
        break;
      case PageState.noData:
        pageBody = _NoDataWidget(
          onRetry: onRetry,
          noDataMessage: noDataMessage!,
        );
        break;
    }
    return pageBody;
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: CustomColors.color959595,
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Function? onRetry;

  const _ErrorWidget({
    Key? key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Text(AppLocalizations.of(context).genericError),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: null,
            child: Text(AppLocalizations.of(context)!.retry), //onRetry,
          )
        ],
      ),
    );
  }
}

class _NoDataWidget extends StatelessWidget {
  final Function? onRetry;
  final String? noDataMessage;

  const _NoDataWidget({
    Key? key,
    this.onRetry,
    this.noDataMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(noDataMessage ?? ''),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: null,
            child: Text(AppLocalizations.of(context)!.retry), //onRetry,
          )
        ],
      ),
    );
  }
}
