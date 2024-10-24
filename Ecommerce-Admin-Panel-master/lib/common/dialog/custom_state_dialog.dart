import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomStateDialog {
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    String description = emptyString,
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: isError
              ? SvgPicture.asset(
                  '${imagePath}error.svg',
                )
              : SvgPicture.asset(
                  '${imagePath}success.svg',
                ),
          iconPadding: const EdgeInsets.all(16.0),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(
              60.0,
            ),
          ),
          title: Container(
            margin: const EdgeInsets.only(
              top: 20.0,
              bottom: 5,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          content: IntrinsicHeight(
            child: IntrinsicWidth(
              child: SizedBox(
                width: 340.0,
                child: Text(
                  description,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          titlePadding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
          ),
          contentPadding: const EdgeInsets.only(
            top: 13.0,
            left: 20.0,
            bottom: 20.0,
          ),
        );
      },
    );
  }
}
