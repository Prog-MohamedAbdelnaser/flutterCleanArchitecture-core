
import '../../../main_index.dart';
import 'gates/date_widget.dart';
import '../widgets/tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text('المشروع النخيل مول', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kPrimaryLight)),
          const SizedBox(height: 20,),
          DatesWidget(),
          const SizedBox(height: 20,),
          TabView(
              onTabChange: (index) {
                print(index);
              }
          ),
        ],
      )
    );
  }
}
