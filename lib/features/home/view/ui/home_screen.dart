import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../config/theme/text_style.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_assets.dart';
import '../view_model/home_screen_states.dart';
import '../view_model/home_screen_view_model.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/notification_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenViewModel viewModel = getIt.get<HomeScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    final List<SalomonBottomBarItem> items = [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: Text(locale!.home),
      ),
      SalomonBottomBarItem(
        icon: const ImageIcon(AssetImage(AppIcons.results)),
        title: Text(locale.results),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: Text(locale.profile),
      ),
    ];

    return BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: FadeInLeft(
              child: Text(locale.traitLengs, style: TextStyles.font32BlueBold),
            ),
            actions: [
              FadeInRight(child: const NotificationWidget()),
            ],
          ),
          body: viewModel.tabs[viewModel.currentIndex],
          floatingActionButton: viewModel.currentIndex == 0
              ? const CustomFloatingActionButton()
              : null,
          bottomNavigationBar: CustomBottomNavigationBar(
            viewModel: viewModel,
            items: items,
          ),
        );
      },
    );
  }
}
