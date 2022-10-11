import 'package:flutter/material.dart';
import 'package:telemetria/theme/theme.dart';

class SearchTextForm extends StatelessWidget {
  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;
  final Function() onPressed;
  final Function(String)? onChanged;
  final String labelText;
  final double iconSize;

  const SearchTextForm(
      {Key? key,
      required this.width,
      required this.height,
      required this.borderColor,
      required this.backgroundColor,
      required this.labelText,
      required this.onPressed,
      required this.iconSize,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          color: ColorTheme.thetextBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          enableSuggestions: false,
          onChanged: onChanged,
          style: TextStyle(
            color: ColorTheme.thetextColor,
          ),
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: TextStyle(color: ColorTheme.thetextColor),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              color: ColorTheme.iconsColor,
              onPressed: onPressed,
              iconSize: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
