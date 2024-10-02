import 'package:flutter/cupertino.dart';

import '../../../softMaterials.dart';
import 'base/softcore_context/softcore_base_context.dart';

@immutable
abstract class SoftMaterialWidget extends StatefulWidget {
   SoftMaterialWidget({Key? key}) : super(key: key);
  late SoftCoreContext softContext;


  // This is similar to softBuild in MaterialStatelessWidget
  Widget build(SoftCoreContext context);

  @override
  _MaterialStatefulWidgetState createState() {
    return _MaterialStatefulWidgetState();
  }

  // Lifecycle methods for developers to override
  void onInit(SoftCoreContext softContext) {}
  void onResume() {}
  void onPause() {}
  void onStop() {}


}

class _MaterialStatefulWidgetState extends State<SoftMaterialWidget>
    with WidgetsBindingObserver {
  late SoftCoreContext _softContext;

  @override
  void initState() {
    super.initState();
    widget.softContext = _softContext;
    WidgetsBinding.instance.addObserver(this); // Add the observer
    _softContext = _createCoreContext(context);
    widget.onInit(_softContext); // Custom initialization
  }



  @override
  void dispose() {
    widget.onPause();
    WidgetsBinding.instance.removeObserver(this); // Remove the observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onResume();
    } else if (state == AppLifecycleState.paused) {
      widget.onPause();
    } else if (state == AppLifecycleState.detached) {
      widget.onStop(); // Call onStop if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.build( _softContext);
  }

  SoftCoreContext _createCoreContext(BuildContext context) {
    return BaseCoreContext(
      context,
      dialogsManager: DialogsManager(),
      progress: DialogsManager().createProgress(context),
    );
  }
}