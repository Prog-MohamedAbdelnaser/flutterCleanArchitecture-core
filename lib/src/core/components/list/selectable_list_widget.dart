import 'package:flutter/material.dart';

import '../decorations/decorations.dart';

class SelectableListWidget extends StatefulWidget {
  final Function(int index) onSelect;
  final int count;
  final int? initIndex;


  final List<int>? notAllowedIndexes;
  final double? aspectRatio;
  final ScrollController? scrollController;
  final bool isVertical;
  final bool grid;
  final EdgeInsetsGeometry? padding;

  final Widget Function(int index, bool isSelected) itemBuilder;
  final Widget Function(int index)? notAllowedItemBuilder;

  const SelectableListWidget(
      {super.key,
      this.scrollController,
      required this.onSelect,
      required this.count,
      this.padding,
      this.aspectRatio,
      this.initIndex,
      this.grid = false,
      required this.itemBuilder,
      this.notAllowedItemBuilder,
      this.isVertical = false,
      this.notAllowedIndexes});

  @override
  _SelectableListWidget createState() => _SelectableListWidget();
}

class _SelectableListWidget extends State<SelectableListWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSelect(int index) {
    if (selectedIndex == index) {
      selectedIndex = index;
    } else {
      selectedIndex = index;
    }
    setState(() {});
    widget.onSelect(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == -1 && widget.initIndex != null) {
      selectedIndex = widget.initIndex!;
    }
    return widget.grid ? buildGrid() : buildList();
  }

  Widget buildList() {
    return ListView.builder(
        itemCount: widget.count,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        controller: widget.scrollController,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemBuilder: (c, i) {
          final isSelected = i == selectedIndex;
          return Padding(
              padding: widget.padding != null
                  ? widget.padding!
                  : const EdgeInsetsDirectional.only(end: 16),
              child: itemWidget(i, isSelected));
        });
  }

  Widget itemWidget(index, isSelected) {
    final notAllowed = widget.notAllowedIndexes?.contains(index) == true;
    return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: notAllowed ?null : () {
                onSelect(index);
              },
        child: notAllowed  && widget.notAllowedItemBuilder != null
            ? widget.notAllowedItemBuilder!(index,)
            : widget.itemBuilder(index, isSelected));
  }

  Widget buildGrid() {
    double crossAxisSpacing = 20,
        mainAxisSpacing = 0,
        aspectRatio = widget.aspectRatio ?? 3.5;

    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: aspectRatio,
        ),
        itemCount: widget.count,
        itemBuilder: (c, i) {
          final isSelected = i == selectedIndex;
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: itemWidget(i, isSelected),
          );
        });
  }
}
