

import 'package:get/get.dart';

import '../../../../main_index.dart';
import 'soft_loading_widget.dart';

class SoftCoreDefaultLoadingView extends SoftLoadingWidget {
  final double ? height ;

  const SoftCoreDefaultLoadingView({super.key,  this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  <Widget>[
              SizedBox(
                height: 30,
                width: 30,
/*
                child: Image.asset('images/loading_gify.gif'),
*/
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: context.theme.primaryColor,
                ),
              ),
            ],
          ),
        ));
  }
}