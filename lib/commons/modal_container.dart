import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class ModalContainer extends StatefulWidget {
  const ModalContainer({
    super.key,
    this.height,
    required this.child,
    this.isScrollable = false,
    this.title = 'Title',
  });
  final double? height;
  final String title;
  final bool isScrollable;

  final Widget child;

  @override
  State<ModalContainer> createState() => _ModalContainerState();
}

class _ModalContainerState extends State<ModalContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: widget.height,
      child: SingleChildScrollView(
        physics: widget.isScrollable
            ? ScrollPhysics()
            : NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.title}",
                    style: textTheme().titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            widget.child
          ],
        ),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    );
  }
}
