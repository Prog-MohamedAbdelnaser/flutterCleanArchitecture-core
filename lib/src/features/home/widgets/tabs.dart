import 'package:support/src/core/components/buttons/app_icon.dart';

import '../../../config/assets/app_icons.dart';
import '../../../main_index.dart';
import '../pages/gates/gate_list.dart';

class TabView extends BaseStatelessWidget {
  final Function(int)?   onTabChange  ;
  TabView({Key? key, this.onTabChange}) : super(key: key);
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return  SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: SizedBox(),
            elevation: 0,
            flexibleSpace: TabBar(
              isScrollable: true,
             labelStyle: theme.textTheme.displaySmall!,
              unselectedLabelColor: Colors.grey,
             labelColor: theme.primaryColor,
             indicatorColor: theme.primaryColor,
              tabs: [
                Tab(
                  child: CustomTab(title: strings.gates, icon: AppIcons.gate)
                ),
                Tab(
                  child: CustomTab(title: strings.mosques, icon: AppIcons.mosque)
                ),
                Tab(
                  child: CustomTab(title: strings.restaurants, icon: AppIcons.restaurant)
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GatesList(),
              Container(color: Colors.green,),
              Container(color: Colors.blue,),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final String icon;
  const CustomTab({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        AppIcon(
          icon: icon,
        ),
        Text(title),
      ],
    );
  }
}
