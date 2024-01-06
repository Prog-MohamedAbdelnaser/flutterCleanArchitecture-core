import 'package:get/get.dart';

import '../../../main_index.dart';

class BottomNavigationWidget extends StatefulWidget {
  final List<BottomNavigationWidgetModel> items;
  final AppBar? appBar;
  final Color ?backgroundColor ;

  const BottomNavigationWidget({Key? key, required this.items, this.appBar,this.backgroundColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigationWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Center(
          child: widget.items.elementAt(_selectedIndex).widget,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // This is all you need!
            backgroundColor: Colors.white,

            unselectedItemColor: context.theme.unselectedWidgetColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: context.theme.iconTheme,
            selectedLabelStyle: context.textTheme.bodyMedium!
                .copyWith(color: context.theme.primaryColor),
            unselectedLabelStyle: context.textTheme.labelMedium
                ?.copyWith(color: context.theme.unselectedWidgetColor),
            items: widget.items
                .map(
                    (e) => e.builder(_selectedIndex == widget.items.indexOf(e),context))
                .toList(),
            currentIndex: _selectedIndex,
            selectedItemColor: context.theme.primaryColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class BottomNavigationWidgetModel {
  final Widget widget;
  final String label;
  final String? iconPath;
  final Widget? icon;

  BottomNavigationWidgetModel(
      {required this.widget, required this.label, this.iconPath, this.icon})
      : assert(icon == null || iconPath == null,
            'Cannot provide both a icon and a icon');

  BottomNavigationItemBuilder builder(bool selected, BuildContext context) {
    return BottomNavigationItemBuilder(
      this,
      context,
      selected,
    );
  }
}

class BottomNavigationItemBuilder extends BottomNavigationBarItem {
  BottomNavigationItemBuilder(
      BottomNavigationWidgetModel model, BuildContext context,
      [bool? selected])
      : super(
            icon: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                model.icon != null
                    ? model.icon!
                    : model.iconPath!.endsWith('svg') == true
                        ? SvgPicture.asset(
                            model.iconPath!,
                            height: 24,
                            colorFilter: selected == true
                                ? ColorFilter.mode(
                                    context.theme.primaryColor, BlendMode.color)
                                : ColorFilter.mode(
                                    context.theme.unselectedWidgetColor,
                                    BlendMode.color),
                          )
                        : Image.asset(model.iconPath!),
                const SizedBox(
                  height: 4,
                )
              ],
            ),
            label: model.label);
}
