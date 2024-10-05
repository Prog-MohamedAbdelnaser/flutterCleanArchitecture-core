import 'package:softcore/errorManager.dart';
import 'package:softcore/main_index.dart';

abstract class SoftErrorWidget extends SoftStatelessWidget {
  final AppError error;
  final Function()? onRetry;
  final double? height;

  const SoftErrorWidget({
    Key? key,
    required this.error,this.height,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context);
}
