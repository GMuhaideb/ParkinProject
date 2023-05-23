import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final bool isIos, decoratedBox;
  final BuildContext screenCtx;
  final Widget content;
  final String? doneActionTitle;
  final Function? doneAction;
  final String? cancelTxt;
  final Function? cancelAction;
  final dynamic customBtn;
  final double? height, width;

  const AppDialog(this.isIos,
      {super.key,
      required this.screenCtx,
      required this.content,
      this.doneActionTitle,
      this.doneAction,
      this.cancelTxt,
      this.cancelAction,
      this.customBtn,
      this.height,
      this.width,
      this.decoratedBox = false});

  @override
  Widget build(BuildContext context) {
    log('cancelTxt is $cancelTxt isIOS $isIos');
    if (isIos) {
      return CupertinoAlertDialog(
        // backgroundColor: Colors.transparent,
        // insetPadding: EdgeInsets.zero,
        content: SizedBox(
            height: height,
            width: width,
            child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: content)),
        actions: [
          if (customBtn != null)
            CupertinoButton(
                onPressed: (customBtn as CupertinoButton).onPressed,
                child: (customBtn as CupertinoButton).child),
          if (cancelTxt != null)
            CupertinoButton(
              child: Text(
                cancelTxt!,
                // style: TextStyle(fontFamily: appStyle.appFontFamily),
              ),
              onPressed: () {
                if (cancelAction != null) {
                  cancelAction!();
                }
                Navigator.pop(context);
              },
            ),
          if (doneActionTitle != null && doneAction != null)
            CupertinoButton(
              onPressed: () => doneAction!(),
              child: Text(
                doneActionTitle!,
                // style: TextStyle(
                //     color: appClrs.mainClr, fontFamily: appStyle.appFontFamily),
              ),
            ),
        ],
      );
    } else {
      return AlertDialog(
        backgroundColor:
            decoratedBox && !Platform.isIOS ? Colors.white : Colors.transparent,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: height,
            width: width,
            child: Container(
                decoration: decoratedBox && !Platform.isIOS
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20))
                    : null,
                child: content)),
        scrollable: true,
        actions: [
          if (customBtn != null)
            MaterialButton(
                onPressed: (customBtn as MaterialButton).onPressed,
                child: (customBtn as MaterialButton).child),
          if (cancelTxt != null)
            MaterialButton(
              child: Text(
                cancelTxt!,
                // style: TextStyle(fontFamily: appStyle.appFontFamily, color: Colors.black),
              ),
              onPressed: () {
                if (cancelAction != null) {
                  cancelAction!();
                }
                Navigator.pop(context);
              },
            ),
          if (doneActionTitle != null && doneAction != null)
            MaterialButton(
              onPressed: () => doneAction!(),
              child: Text(
                doneActionTitle!,
                // style: TextStyle(
                //     color: appClrs.mainClr, fontFamily: appStyle.appFontFamily),
              ),
            ),
        ],
      );
    }
  }
}
