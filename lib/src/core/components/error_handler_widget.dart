import '../managers/error_handler_manage.dart';
import '/src/main_index.dart';
import 'buttons/app_cupertino_button.dart';
// ignore: must_be_immutable
abstract class ErrorPlaceHolderWidget extends BaseStatelessWidget {

  final String? error;
  final String? title;
  final Function()? onRetryButton;
  final Function()? onCallBack;
  final dynamic exception;
  final Color? color;
  final bool showImage;
  final double? height;
  final String? barTitle;

  final Widget? placeHolderView;
  ErrorPlaceHolderWidget({
    Key? key,
    this.error,
    this.exception,
    this.placeHolderView,
    this.onCallBack,
    this.title,
    this.barTitle,
    this.onRetryButton,
    this.showImage = true,
    this.color,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorModel = manager(context).appErrorFromException(exception);
    final message = error ?? errorModel.message;
    return  Container(
        color: color ?? Colors.white,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  showImage == false
                      ? const SizedBox.shrink()
                      : placeHolderView != null
                      ? Container(
                    color: color ?? Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: placeHolderView,
                  )
                      : handleExceptionPlaceHolderImage(errorModel.asset),
                  title != null || errorModel.title != null
                      ? Text(title ?? errorModel.title ?? '',
                      style: textTheme.titleMedium)
                      : Container(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    message.toString().trim(),
                    style: textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onRetryButton != null || errorModel.defaultAction
                  ? AppCupertinoButton(
                text: errorModel.buttonName,
                margin: const EdgeInsets.symmetric(
                    vertical: 24, horizontal: 16),
                onPressed: () {
                  if (onRetryButton != null) {
                    onRetryButton!();
                  } else {
                    retryButtonAction(context);
                  }
                },
              )
                  : const SizedBox.shrink()
            ],
          ),
        ));
  }

  @protected
  ErrorHandlerManager manager(BuildContext context);

  Widget handleExceptionPlaceHolderImage(String path) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: path.endsWith('svg')
          ? SvgPicture.asset(
        path,
        height: height != null ? (height! / 3) : 150,
      )
          : Image.asset(path),
    );
  }

  void retryButtonAction(BuildContext context);

}

