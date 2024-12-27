import 'package:courtly/core/constants/constants.dart';
import 'package:flutter/material.dart';

void showBottomModalSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: PAGE_PADDING_MOBILE,
                  right: PAGE_PADDING_MOBILE,
                  top: PAGE_PADDING_MOBILE,
                  bottom: PAGE_PADDING_MOBILE * 2),
              child: content,
            )
          ],
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      useSafeArea: true);
}
