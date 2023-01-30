
import 'package:support/src/config/assets/app_icons.dart';

import '../../../../core/components/buttons/app_icon.dart';
import '../../../../main_index.dart';

class HeaderGateItem extends BaseStatelessWidget {
 HeaderGateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        AppIcon(
          icon: AppIcons.gate,
        ),
        Text(strings.gate_number('1'), style: theme.textTheme.displaySmall!.copyWith(color: kPrimaryLight)),
        Spacer(),
        AppIcon(
          icon: AppIcons.clarityEmployee,
        ),
        SizedBox(width: 5),
        Text(strings.required_number('3'), style: theme.textTheme.displaySmall!.copyWith(color: kPrimaryLight)),

      ],
    );
  }
}
