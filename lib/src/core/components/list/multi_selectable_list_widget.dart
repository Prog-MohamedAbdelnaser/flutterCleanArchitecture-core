import 'package:flutter/material.dart';

class MultiSelectableListWidget extends StatefulWidget {
  final Function(List<int> index) onSelect;
  final int count;
  final int maxSelectable;
  final List<int>? initIndexes;
  final double? aspectRatio;
  final ScrollController? scrollController;
  final bool isVertical;
  final bool grid;
  final EdgeInsetsGeometry? padding;

  final Widget Function(int index, bool isSelected) itemBuilder;

  const MultiSelectableListWidget(
      {super.key,
      this.scrollController,
      required this.onSelect,
      required this.count,
      this.padding,
      this.aspectRatio,
      this.maxSelectable = 1,
      this.initIndexes,
      this.grid = false,
      required this.itemBuilder,
      this.isVertical = false});

  @override
  createState() => _MultiSelectableListWidget();
}

class _MultiSelectableListWidget extends State<MultiSelectableListWidget> {
  List<int> selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    print('SetState MMMMMM');
  }

  onBuild() {
    if (mounted) {
      if (selectedIndexes.isEmpty && widget.initIndexes != null) {
        selectedIndexes = widget.initIndexes!;
      }
      if (selectedIndexes.isNotEmpty &&
          widget.maxSelectable < selectedIndexes.length) {
        selectedIndexes = [];
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSelect(int index) {
    print(
        'maxSelectable ${widget.maxSelectable} => ${selectedIndexes.length} = ${widget.maxSelectable == selectedIndexes.length}');
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      if (widget.maxSelectable == selectedIndexes.length) return;
      selectedIndexes.add(index);
    }
    setState(() {});
    widget.onSelect(selectedIndexes);
  }

  @override
  Widget build(BuildContext context) {
    onBuild();
    return widget.grid ? buildGrid() : buildList();
  }

  Widget buildList() {
    print('SetState MMMMMM');

    return ListView.builder(
        itemCount: widget.count,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        controller: widget.scrollController,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemBuilder: (c, i) {
          final isSelected = selectedIndexes.contains(i);
          return Padding(
            padding: widget.padding != null
                ? widget.padding!
                : const EdgeInsetsDirectional.only(end: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                onSelect(i);
              },
              child: widget.itemBuilder(i, isSelected),
            ),
          );
        });
  }

  Widget buildGrid() {
    double crossAxisSpacing = 20,
        mainAxisSpacing = 0,
        aspectRatio = widget.aspectRatio ?? 3.5;

    return Container(
      child: GridView.builder(
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
            final isSelected = selectedIndexes.contains(i);
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: InkWell(
                  onTap: () {
                    onSelect(i);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: widget.itemBuilder(i, isSelected)),
            );
          }),
    );
  }
}
