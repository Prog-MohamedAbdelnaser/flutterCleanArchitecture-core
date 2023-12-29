import '../../../../main_index.dart';
import '../../managers/app_error.dart';
import '../../managers/error_handler_manage.dart';
import '../buttons/app_cupertino_button.dart';

// ignore: must_be_immutable
class ErrorPlaceHolderWidget extends BaseStatelessWidget {
  final String? title;
  final Function()? onRetryButton;
  final Function()? onCallBack;
  final AppError   error;
  final Color? color;
  final bool showImage;
  final double? height;
  final String? barTitle;

  final Widget? placeHolderView;

  ErrorPlaceHolderWidget({
    Key? key,
    required this.error,
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
    return Container(
        color: color,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              placeHolderImage(context),
              titleWidget(context),
              const SizedBox(
                height: 16,
              ),
              messageWidget(),
              buttonWidget(context)
            ],
          ),
        ));
  }

  ErrorHandlerManager manager(BuildContext context) {
    return ErrorHandlerManager(context);
  }

  Widget handleExceptionPlaceHolderImage(String? path) {
    if (path == null) return const SizedBox.shrink();
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

  void retryButtonAction(BuildContext context) {
    if (onRetryButton != null) {
      onRetryButton!();
    }
  }

  Widget placeHolderImage(BuildContext context) {
    return showImage == false
        ? const SizedBox.shrink()
        : placeHolderView != null
            ? Container(
                color: color,
                margin: const EdgeInsets.only(bottom: 16),
                child: placeHolderView,
              )
            : handleExceptionPlaceHolderImage(error.asset);
  }

  Widget titleWidget(BuildContext context) {
    return title != null || error.title != null
        ? Text(title ?? error.title ?? '', style: textTheme.titleMedium)
        : const SizedBox.shrink();
  }

  Widget buttonWidget(BuildContext context) {
    return onRetryButton != null || error.defaultAction==true
        ? AppCupertinoButton(
            text: error.buttonName,
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            onPressed: () {
              retryButtonAction(context);
            },
          )
        : const SizedBox.shrink();
  }

  Widget messageWidget() {
    return  Text(
       error.message??'',
      style: textTheme.displayLarge,
      textAlign: TextAlign.center,
    );
  }
}
