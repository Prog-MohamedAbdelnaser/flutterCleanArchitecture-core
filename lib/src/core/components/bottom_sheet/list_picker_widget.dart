
import 'package:flutter/material.dart';


import '../../../config/Themes/colors.dart';
import '../../../config/Themes/text_styles.dart';
import '../base_stateless_widget.dart';
import '../common/common_state.dart';
import '../drop_down/dropdown_filed.dart';
import '../helper/helper_widgets.dart';

class ListPickerWidget extends BaseStatelessWidget {
  static showPicker(
      {required BuildContext context,
      bool? setSearch,
      required String title,
      required List<Item> items,
      final Widget Function(BuildContext context, Item item)? itemBuilder,
      searchHint,
        bool isScrollControlled = true,
      required Function(Item position) onSelectItem}) {
    showAppModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        child: ListPickerWidget(
          items: items,
          onSelectItem: onSelectItem,
          searchHint: searchHint,
          itemBuilder: itemBuilder,
          setSearch: setSearch,
        ),
        title: title);
  }

  final List<Item> items;
  final Function(Item position) onSelectItem;
  final String? searchHint;
  final bool? setSearch;
  final Widget Function(BuildContext context, Item item)? itemBuilder;

  StreamState<List<Item>> searchStream = StreamStateInitial();
  //List<Item> _items;

  ListPickerWidget(
      {Key? key,
      this.setSearch,
      required this.items,
      this.itemBuilder,
      required this.onSelectItem,
      this.searchHint})
      : super(key: key);
  findCityByName(String text) {
    final filter = items
        .where((element) =>
            element.value.toLowerCase().contains(text.toLowerCase()) == true)
        .toList();
    searchStream.setData(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        setSearch == true
            ? buildSearchWidget(
                onChange: (String text) {
                  findCityByName(text);
                },
                hint: searchHint ?? '')
            : Container(),

        Expanded(
          child: StreamBuilder<List<Item>>(
              stream: searchStream.stream,
              initialData: items,
              builder: (context, snapshot) {
                final data = snapshot.requireData;
                return ListView.builder(
                    itemCount: data.length,
                    addAutomaticKeepAlives: true,
                   // padding: EdgeInsets.only(top: 10),
                    itemBuilder: (_, position) {
                      final item = data[position];
                      if (itemBuilder != null) {
                        return TextButton(
                          onPressed: () {
                            print('position field $position ${data[position]}');
                            onSelectItem(item);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            alignment: AlignmentDirectional
                                .centerStart, // <-- had to set alignment
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.zero, // <-- had to set padding to zero
                            ),
                          ),
                          child: itemBuilder!(context, item),
                        );
                      }
                      return Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                onSelectItem(item);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                alignment: AlignmentDirectional
                                    .centerStart, // <-- had to set alignment
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets
                                      .zero, // <-- had to set padding to zero
                                ),
                              ),
                              child: Text(
                                item.value,
                                textAlign: TextAlign.start,
                                style: kTextRegular.copyWith(
                                    fontSize: 12,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: kGreyColor,
                            )
                          ],
                        ),
                      );
                    });
              }),
        ),
      ],
    );
  }
}
