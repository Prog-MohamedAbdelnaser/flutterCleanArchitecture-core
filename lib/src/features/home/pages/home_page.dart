import 'package:flutter/material.dart';
import 'package:support/src/features/home/pages/home_screen.dart';

import '../../../config/assets/app_icons.dart';
import '../../../core/components/base/actions_widgets.dart';
import '../../../core/components/base/app_scaffold.dart';
import '../../../core/components/buttons/app_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      drawer: Drawer(
        child: AppIconButton(
          icon: AppIcons.menu,
          onPressed: () {},
        ),
      ),
      actions: [ActionsWidgets()],
      body: HomeScreen(),
    );
  }
}
