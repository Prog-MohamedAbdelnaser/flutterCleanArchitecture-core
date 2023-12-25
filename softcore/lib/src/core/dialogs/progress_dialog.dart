import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProgressDialog {
  static CustomProgressDialog createProgress(BuildContext context) {
    return CustomProgressDialog(context,
        dismissable: false,
        loadingWidget: const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        onDismiss: () {},
        transitionDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color(0x33000000),
        blur: 2,
        dialogTransitionType: DialogTransitionType.Shrink);
  }


}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 100.0,
          width: 100.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: CircularProgressIndicator(),
        ));
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        child: SizedBox(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}

///Blur background of dialog, you can use this class to make your custom dialog background blur
class DialogBackground extends StatelessWidget {
  ///Widget of dialog, you can use ars_dialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget? dialog;

  ///Because blur dialog cover the barrier, you have to declare here
  final bool? dismissable;

  ///Action before dialog dismissed
  final Function? onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double? blur;

  final Color? barrierColor;

  @Deprecated("Use barrierColor instead")
  final Color? color;

  const DialogBackground(
      {Key? key,
      this.dialog,
      this.color,
      this.dismissable,
      this.blur,
      this.onDismiss,
      this.barrierColor})
      : super(key: key);

  ///Show dialog directly
  // Future show<T>(BuildContext context) => showDialog<T>(context: context, builder: (context) => this, barrierColor: barrierColor, barrierDismissible: dismissable ?? true);

  Future<T?> show<T>(BuildContext context,
          {DialogTransitionType? transitionType,
          bool? dismissable,
          Duration? transitionDuration}) =>
      DialogUtils(
        child: this,
        dialogTransitionType: transitionType,
        dismissable: dismissable,
        barrierColor: barrierColor ?? Colors.black.withOpacity(.5),
        transitionDuration: transitionDuration,
      ).show(context) as Future<T?>;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          if (dismissable ?? true) {
            if (onDismiss != null) onDismiss!();
            Navigator.pop(context);
          }
          return false;
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: dismissable ?? true
                  ? () {
                      if (onDismiss != null) {
                        onDismiss!();
                      }
                      Navigator.pop(context);
                    }
                  : () {},
              child: (blur ?? 0) < 1
                  ? Container()
                  : TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.1, end: blur ?? 0),
                      duration: Duration(milliseconds: 300),
                      builder: (context, double? val, Widget? child) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: val ?? 0,
                            sigmaY: val ?? 0,
                          ),
                          child: Container(color: Colors.transparent),
                        );
                      },
                    ),
            ),
            dialog!
          ],
        ),
      ),
    );
  }
}

class DialogUtils {
  final bool? dismissable;
  final Widget child;
  final DialogTransitionType? dialogTransitionType;
  final Color? barrierColor;
  final RouteSettings? routeSettings;
  final bool? useRootNavigator;
  final bool? useSafeArea;
  final Duration? transitionDuration;

  DialogUtils({
    required this.child,
    this.useSafeArea,
    this.barrierColor,
    this.dismissable,
    this.dialogTransitionType,
    this.routeSettings,
    this.transitionDuration,
    this.useRootNavigator,
  });

  ///Show dialog directly
  Future show<T>(BuildContext context) => showGeneralDialog<T>(
        context: context,
        routeSettings: routeSettings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            (useSafeArea ?? true) ? SafeArea(child: child) : child,
        barrierColor: barrierColor ?? Color(0x00ffffff),
        barrierDismissible: dismissable ?? true,
        barrierLabel: "",
        transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            _animationWidget(animation, child),
        useRootNavigator: useRootNavigator ?? false,
      );

  Widget _animationWidget(Animation<double> animation, Widget child) {
    switch (dialogTransitionType ?? DialogTransitionType.NONE) {
      case DialogTransitionType.Bubble:
        return DialogTransition.bubble(animation, child);
      case DialogTransitionType.LeftToRight:
        return DialogTransition.transitionFromLeft(animation, child);
      case DialogTransitionType.RightToLeft:
        return DialogTransition.transitionFromRight(animation, child);
      case DialogTransitionType.TopToBottom:
        return DialogTransition.transitionFromTop(animation, child);
      case DialogTransitionType.BottomToTop:
        return DialogTransition.transitionFromBottom(animation, child);
      case DialogTransitionType.Shrink:
        return DialogTransition.shrink(animation, child);
      default:
    }
    return child;
  }
}

///Dialog style to custom your dialog
class DialogStyle {
  /// Divider on title
  final bool? titleDivider;

  ///Set circular border radius for your dialog
  final BorderRadius? borderRadius;

  ///Set semanticslabel for Title
  final String? semanticsLabel;

  ///Set padding for your Title
  final EdgeInsets? titlePadding;

  ///Set padding for your  Content
  final EdgeInsets? contentPadding;

  ///Set TextStyle for your Title
  final TextStyle? titleTextStyle;

  ///Set TextStyle for your Content
  final TextStyle? contentTextStyle;

  ///Elevation for dialog
  final double? elevation;

  ///Background color of dialog
  final Color? backgroundColor;

  ///Shape for dialog, ignored if you set BorderRadius
  final ShapeBorder? shape;

  ///Bubble animation when your dialog will popup
  @Deprecated("Use animatePopup on .show() instead")
  final bool? animatePopup;

  ///Dialog Transition Type
  // final DialogTransitionType dialogTransitionType;

  DialogStyle({
    this.titleDivider,
    // this.dialogTransitionType,
    this.borderRadius,
    this.semanticsLabel,
    this.titlePadding,
    this.contentPadding,
    this.titleTextStyle,
    this.contentTextStyle,
    this.elevation,
    this.backgroundColor,
    this.animatePopup,
    this.shape,
  });
}

enum DialogTransitionType {
  Shrink,
  Bubble,
  LeftToRight,
  RightToLeft,
  TopToBottom,
  BottomToTop,
  NONE
}

class DialogTransition {
  static Widget transitionFromLeft(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromTop(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromBottom(
      Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget bubble(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: Tween<double>(begin: 0, end: 1).animate(animation),
          curve: Curves.elasticOut),
      alignment: Alignment.center,
      child: child,
    );
  }

  static Widget shrink(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(animation),
      alignment: Alignment.center,
      child: child,
    );
  }
}

///Typedef of Progress while on Progress Error
typedef OnProgressError(dynamic error);

///Typedef of Progress while on Progress Finish
typedef OnProgressFinish<T>(T data);

///Typedef of Progress while on Progress Cancel
typedef OnProgressCancel();

abstract class _ProgressDialog {
  ///You can set title of dialog using this function,
  ///even the dialog already pop up
  void setTitle(Widget title);

  ///You can set loading widget of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default CircularProgressIndicator or loadingWidget that already you set before
  void setLoadingWidget(Widget loadingWidget);

  ///You can set background / barrier color of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default
  void setBackgroundColor(Color color);

  ///You can set message of dialog using this function,
  ///even the dialog already pop up
  void setMessage(Widget message);
}

abstract class _CustomProgressDialog {
  ///You can set loading widget of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default loadingWidget that already you set before
  void setLoadingWidget(Widget loadingWidget);

  ///You can set background / barrier color of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default
  void setBackgroundColor(Color color);
}

///Simple progress dialog with blur background and popup animations, use DialogStyle to custom it
///inspired by ProgressDialog from Android Native, and it very simple to use

class CustomProgressDialog implements _CustomProgressDialog {
  ///The context
  final BuildContext context;

  ///Show as the progress, nullable to aplied to default loading widget
  final Widget? loadingWidget;

  ///The (optional) on cancel button that will display at the bottom of the dialog.
  ///Note : Do not use POP to cancel the dialog, just put your cancel code there
  final Function? onCancel;

  ///Is your dialog dismissable, because its warp by BlurDialogBackground,
  ///you have to declare here instead on showDialog
  final bool? dismissable;

  ///Action on dialog dismissing
  final Function? onDismiss;

  final double? blur;

  final Color? backgroundColor;
  final DialogTransitionType? dialogTransitionType;
  final Duration? transitionDuration;

  bool _show = false;
  late _CustomProgressDialogWidget _progressDialogWidget;

  CustomProgressDialog(
    this.context, {
    this.backgroundColor,
    this.blur,
    this.onCancel,
    this.dismissable,
    this.onDismiss,
    this.loadingWidget,
    this.dialogTransitionType,
    this.transitionDuration,
  }) {
    _initProgress();
  }

  @override
  void setLoadingWidget(Widget loadingWidget) {
    _progressDialogWidget.getDialogState().setLoadingWidget(loadingWidget);
  }

  @override
  void setBackgroundColor(Color color) {
    _progressDialogWidget.getDialogState().setBackgroundColor(color);
  }

  ///Show progress dialog
  void show({bool useSafeArea = true}) async {
    if (!_show) {
      _show = true;
      await DialogUtils(
        dismissable: dismissable,
        barrierColor: backgroundColor,
        child: _progressDialogWidget,
        dialogTransitionType: dialogTransitionType,
        transitionDuration: transitionDuration,
        useSafeArea: useSafeArea,
      ).show(context);
      _show = false;
    }
  }

  ///Dismiss the dialog
  void dismiss() {
    print(_show);
    if (_show) {
      _show = false;
      Navigator.pop(context);
    }
  }

  void _initProgress() {
    _progressDialogWidget = _CustomProgressDialogWidget(
      blur: blur,
      onCancel: onCancel,
      dismissable: dismissable,
      backgroundColor: backgroundColor,
      onDismiss: onDismiss,
      loadingWidget: loadingWidget,
    );
  }

  ///future function let you show ProgressDialog until future (param)
  ///reach the end of its action
  static Future future<T>(
    BuildContext context, {
    required Future future,
    OnProgressError? onProgressError,
    OnProgressFinish? onProgressFinish,
    OnProgressCancel? onProgressCancel,
    Color? backgroundColor,
    double? blur,
    Function? onDismiss,
    bool? dismissable,
    Widget? loadingWidget,
    DialogTransitionType? dialogTransitionType,
    Duration? transitionDuration,
    bool useSafeArea = true,
  }) async {
    CustomProgressDialog pDialog = CustomProgressDialog(
      context,
      loadingWidget: loadingWidget,
      dismissable: dismissable,
      backgroundColor: backgroundColor,
      blur: blur,
      onDismiss: onDismiss,
      onCancel: onProgressCancel,
      dialogTransitionType: dialogTransitionType,
      transitionDuration: transitionDuration,
    );

    pDialog.show(useSafeArea: useSafeArea);

    var output;
    try {
      await future.then((data) {
        if (onProgressFinish != null) {
          onProgressFinish = onProgressFinish!(data);
        }
        output = data;
      }).catchError((error) {
        if (onProgressError != null) onProgressError = onProgressError!(error);
      });
    } catch (e) {}
    pDialog.dismiss();

    return output;
  }
}

//ignore:must_be_immutable
class _CustomProgressDialogWidget extends StatefulWidget {
  final Function? onCancel;
  final Widget? loadingWidget;
  final Function? onDismiss;
  final double? blur;
  final Color? backgroundColor;
  final bool? dismissable;
  _CustomProgressDialogWidgetState _dialogWidgetState =
      _CustomProgressDialogWidgetState();

  _CustomProgressDialogWidget({
    Key? key,
    this.onCancel,
    this.dismissable,
    this.onDismiss,
    this.backgroundColor,
    this.loadingWidget,
    this.blur,
  }) : super(key: key);

  @override
  _CustomProgressDialogWidgetState createState() {
    _dialogWidgetState = _CustomProgressDialogWidgetState();
    return _dialogWidgetState;
  }

  _CustomProgressDialogWidgetState getDialogState() {
    _dialogWidgetState = _CustomProgressDialogWidgetState();
    return _dialogWidgetState;
  }
}

class _CustomProgressDialogWidgetState
    extends State<_CustomProgressDialogWidget>
    implements _CustomProgressDialog {
  Widget? _loadingWidget;
  Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _backgroundColor ??
        (widget.backgroundColor ?? Colors.black.withOpacity(.5));
    Widget loadingWidget = (this._loadingWidget ?? widget.loadingWidget) ??
        Container(
          padding: EdgeInsets.all(10.0),
          height: 100.0,
          width: 100.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: CircularProgressIndicator(),
        );

    return DialogBackground(
      blur: widget.blur ?? 0,
      dismissable: widget.dismissable ?? true,
      onDismiss: widget.onDismiss,
      barrierColor: backgroundColor,
      dialog: Padding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Center(
          child: loadingWidget,
        ),
      ),
    );
  }

  @override
  void setLoadingWidget(Widget loadingWidget) async {
    this._loadingWidget = loadingWidget;
    if (mounted) setState(() {});
  }

  @override
  void setBackgroundColor(Color color) async {
    this._backgroundColor = color;
    if (mounted) setState(() {});
  }
}
