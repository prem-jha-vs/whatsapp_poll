import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  @override
  final Widget child;
  @override
  final Function()? onTap;

  CustomPopupMenuItem({
    super.key,
    required this.child,
    this.onTap,
  }) : super(
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
          onTap: onTap,
        );
}
