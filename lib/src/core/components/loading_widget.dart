

import 'package:get/get.dart';

import '../../../main_index.dart';

class LoadingView extends StatelessWidget {
  final double ? height ;

  const LoadingView({super.key,  this.height});
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

class SmallLoadingView extends StatelessWidget {
  final double? height;

  const SmallLoadingView({this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
                height: 15.0,
                width: 15.0,
              ),
            ],
          ),
        ));
  }
}
