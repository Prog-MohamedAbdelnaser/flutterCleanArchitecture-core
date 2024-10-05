import 'package:softcore/errorManager.dart';
import 'package:softcore/main_index.dart';

abstract class SoftLoadingWidget extends SoftStatelessWidget {
  final double? height;

  const SoftLoadingWidget({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context);
}
