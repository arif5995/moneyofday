import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monday/utils/gen/colors.gen.dart';

class BottomAppBarItem {
  final String iconData;
  final String textIcon;

  BottomAppBarItem({required this.iconData, required this.textIcon});
}

class FABBottomAppBar extends StatefulWidget {
  final List<BottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final int? initiateIndex;

  FABBottomAppBar(
      {super.key,
      required this.items,
      required this.centerItemText,
      required this.height,
      required this.iconSize,
      required this.backgroundColor,
      required this.color,
      required this.selectedColor,
      this.notchedShape = const CircularNotchedRectangle(),
      required this.onTabSelected,  this.initiateIndex = 0}) {
    assert(items.length == 2 || items.length == 4);
  }

  @override
  State<FABBottomAppBar> createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initiateIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    items.insert(
        items.length >> 1,
        SizedBox(
          width: 50.w,
        ));

    return Container(
      padding: const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(color: widget.backgroundColor, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(2, 3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: ColorName.purple,
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                ),
              ),
            ),
            // SizedBox(height: widget.iconSize),
            // Text(
            //   widget.centerItemText ?? '',
            //   style: TextStyle(color: widget.color),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            borderRadius: BorderRadius.circular(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(item.iconData,
                    color: color, width: 20.w, height: 20.h),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  item.textIcon,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
