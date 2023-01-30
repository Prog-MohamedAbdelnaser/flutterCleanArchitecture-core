
import '../../../../core/components/decorations/decorations.dart';
import '../../../../main_index.dart';

class DatesWidget extends StatelessWidget {
  const DatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DatesItem(),

        DatesItem(),
      ],
    );
  }
}

class DatesItem extends StatelessWidget {
  const DatesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: Decorations.decorationWithGradient(),
      child: Column(
        children: [
          Text('اليوم', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kPrimaryLight)),
          const SizedBox(height: 10,),
          Text('۱٥  يناير ۲۰۲۳', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kPrimaryLight)),
        ],
      ),
    );
  }
}

