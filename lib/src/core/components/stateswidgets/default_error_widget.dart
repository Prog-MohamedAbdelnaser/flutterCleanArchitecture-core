import 'package:flutter/cupertino.dart';

import '../../managers/app_error.dart';
import '../../managers/error_handler_manage.dart';
import 'soft_error_widget.dart';

class DefaultErrorWidget extends SoftErrorWidget {
  final String? title;
  final Color? color;
  final bool showImage;
  final String? barTitle;
  final Widget? placeHolderView;

  const DefaultErrorWidget({
    Key? key,
    this.placeHolderView,
    this.title,
    this.barTitle,
    this.showImage = true,
    this.color,
    super.height, required super.error, super.onRetry
  });


  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              titleWidget(context),
              const SizedBox(
                height: 16,
              ),
              messageWidget(),
              _buildButtonWidget(context)
            ],
          ),
        ));
  }



  void retryButtonAction(BuildContext context) {
    if (onRetry != null) {
      onRetry!();
    }
  }

  Widget titleWidget(BuildContext context) {
    return title != null || error.title != null
        ? Text(title ?? error.title ?? '', style: textTheme.titleMedium)
        : const SizedBox.shrink();
  }

  Widget _buildButtonWidget(BuildContext context) {
    return onRetry != null || error.defaultAction==true
        ? buttonWidget(context)
        : const SizedBox.shrink();
  }

  Widget buttonWidget(BuildContext context){
    return CupertinoButton(

      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      onPressed: () {
        retryButtonAction(context);
      }, child: Text(error.buttonName??''),
    );
  }
  Widget messageWidget() {
    return  Text(
       error.message??'',
      style: textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}
