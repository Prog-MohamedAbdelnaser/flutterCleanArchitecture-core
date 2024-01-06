import 'package:get/get.dart';

import '../../../main_index.dart';

class BottomNavigationWidget extends StatefulWidget {
  final List<BottomNavigationWidgetModel> items;
  final AppBar? appBar;
  final Color? backgroundColor;
  final Color? barColor;
  final double? barElevation;
  final EdgeInsetsGeometry?  itemsPadding ;
  final Widget Function(BuildContext context, Widget bar)? builder;

  const BottomNavigationWidget(
      {Key? key,
      required this.items,
      this.appBar,
      this.itemsPadding,
      this.backgroundColor,
      this.barColor,
      this.builder,
      this.barElevation})
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
      bottomNavigationBar: widget.builder != null
          ? widget.builder!(context, navigations())
          : navigations(),
    );
  }

  Widget navigations() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // This is all you need!
      backgroundColor: widget.barColor ?? Colors.white,
      elevation: widget.barElevation,
      unselectedItemColor: context.theme.unselectedWidgetColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: context.theme.iconTheme,
      selectedLabelStyle: context.textTheme.bodyMedium!
          .copyWith(color: context.theme.primaryColor),
      unselectedLabelStyle: context.textTheme.labelMedium
          ?.copyWith(color: context.theme.unselectedWidgetColor),
      items: widget.items
          .map((e) =>
              e.builder(_selectedIndex == widget.items.indexOf(e), context,widget.itemsPadding))
          .toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: context.theme.primaryColor,
      onTap: _onItemTapped,
    );
  }
}

class BottomNavigationWidgetModel {
  final Widget widget;
  final String? label;
  final String? iconPath;
  final Widget? icon;
  final double? iconSize;
  
  
  final Widget Function(bool selected)? iconBuilder;

  BottomNavigationWidgetModel(
      {required this.widget, required this.label, this.iconPath, this.iconBuilder,this.iconSize,this.icon})
      : assert(iconBuilder == null || iconPath == null|| icon == null,
            'Cannot provide both a iconBuilder , iconPath and icon');

  BottomNavigationItemBuilder builder(bool selected, BuildContext context,EdgeInsetsGeometry ? itemsPadding) {
    return BottomNavigationItemBuilder(
      this,
      context,
      selected,
      itemsPadding
    );
  }
}

class BottomNavigationItemBuilder extends BottomNavigationBarItem {
  BottomNavigationItemBuilder(
      BottomNavigationWidgetModel model, BuildContext context, [bool? selected,EdgeInsetsGeometry ? itemsPadding])
      : super(
            icon: Padding(
              padding: itemsPadding?? const EdgeInsets.all(8),
              child: _buildItem(model,selected==true,context),
            ),
            label: model.label);

 static Widget _buildItem( BottomNavigationWidgetModel model,bool selected,BuildContext context) {
    return model.iconBuilder != null
        ? model.iconBuilder!(selected==true):
    model.icon != null
        ? model.icon!
        : model.iconPath!.endsWith('svg') == true
        ? SvgPicture.asset(
      model.iconPath!,
      height: model.iconSize??24,
      colorFilter: selected == true
          ? ColorFilter.mode(
          context.theme.primaryColor, BlendMode.color)
          : ColorFilter.mode(
          context.theme.unselectedWidgetColor,
          BlendMode.color),
    )
        : Image.asset(model.iconPath!);
  }
}
