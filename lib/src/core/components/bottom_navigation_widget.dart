import '../../main_index.dart';

class BottomNavigationWidget extends StatefulWidget {
  final List<BottomNavigationWidgetModel> items;
  final AppBar ? appBar ;
  const BottomNavigationWidget({Key? key, required this.items , this.appBar})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigationWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar kAppBar({String title = 'Profile'}) {
    // final isMain  = routeName == MainPage.routeName ;
    return AppBar(
      elevation: 0,
      toolbarHeight: 60,
      leading: null,
      leadingWidth: 0,
      title: Text(
        title,
        style: kTextSemiBold.copyWith(color: kFontBlackColor,fontSize: 30),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8,end: 8),
          child: SvgPicture.asset(Assets.imagesNotification),
        ) ,

        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8,end: 20),
          child: SvgPicture.asset(Assets.imagesSetting),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kWhitThree,
      appBar:kAppBar(title: widget.items[_selectedIndex].label) ,
      body: SafeArea(
        child: Center(
          child: widget.items.elementAt(_selectedIndex).widget,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // This is all you need!
            backgroundColor: Colors.white,

            unselectedItemColor: kBorderColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: const IconThemeData(
              color: kPrimary,
            ),
            selectedLabelStyle:
                kTextRegular.copyWith(color: kBorderColor, fontSize: 12),
            unselectedLabelStyle:
                kTextRegular.copyWith(color: kPrimary, fontSize: 12),
            items: widget.items
                .map((e) => e.builder(_selectedIndex == widget.items.indexOf(e)))
                .toList(),
            currentIndex: _selectedIndex,
            selectedItemColor: kPrimary,
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

  BottomNavigationItemBuilder builder(bool selected) {
    return BottomNavigationItemBuilder(this, selected);
  }
}

class BottomNavigationItemBuilder extends BottomNavigationBarItem {
  BottomNavigationItemBuilder(BottomNavigationWidgetModel model,
      [bool? selected])
      : super(
            icon: Column(
              children: [
                SizedBox(height: 12,),
                model.icon != null
                    ? model.icon!
                    : model.iconPath!.endsWith('svg') == true
                        ? SvgPicture.asset(
                            model.iconPath!,
                            height: 24,
                            color: selected == true ? kPrimary : kBorderColor,
                          )
                        : Image.asset(model.iconPath!),
                const SizedBox(
                  height: 4,
                )
              ],
            ),
            label: model.label);
}
