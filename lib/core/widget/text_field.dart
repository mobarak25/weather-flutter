import 'package:flutter/material.dart';
import 'package:qbidding/core/utils/colors.dart';
import 'package:qbidding/core/utils/text_styles.dart';
import 'package:qbidding/core/widget/text.dart';

class TextFieldB extends StatefulWidget {
  const TextFieldB(
      {Key? key,
      this.hintText = "",
      this.fieldTitle = "",
      this.textStyle = const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      this.labelText,
      this.errorText = '',
      this.helperText = '',
      this.isAccountType = false,
      this.maxLines = 1,
      this.maxLength,
      this.controller,
      required this.focusNode,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.suffixIcon,
      this.textAlign = TextAlign.start,
      this.paddingHeight = 5,
      this.paddingWidth = 15,
      this.onTouch,
      this.height,
      this.bgColor,
      required this.onChanged,
      this.isReadOnly = false,
      this.isMandatory = false,
      this.hintColor})
      : super(key: key);

  final String? hintText, fieldTitle, labelText, errorText, helperText;
  final double? paddingHeight, paddingWidth, height;
  final TextStyle? textStyle;
  final bool? isAccountType, isReadOnly;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final VoidCallback? onTouch;
  final Function onChanged;
  final Color? bgColor, hintColor;
  final bool isMandatory;

  @override
  State<StatefulWidget> createState() {
    return _TextField();
  }
}

class _TextField extends State<TextFieldB> {
  @override
  Widget build(BuildContext context) {
    widget.focusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldTitle != "")
          Row(
            children: [
              TextB(
                text: widget.fieldTitle!,
                textStyle: bStyle,
                fontColor: bDark,
              ),
              const SizedBox(width: 5),
              if (widget.isMandatory)
                const TextB(
                  text: '*',
                  textStyle: bStyle,
                  fontColor: bRed,
                ),
            ],
          ),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            boxShadow: widget.focusNode.hasFocus
                ? [
                    BoxShadow(
                      color: const Color(0XFF6673F5).withOpacity(0.2),
                      offset: const Offset(0, 4), //(x,y)
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
          child: TextField(
            readOnly: widget.isReadOnly!,
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType!,
            onTap: widget.onTouch,
            onChanged: (value) {
              widget.onChanged(value);
            },
            textInputAction: TextInputAction.next,
            cursorColor: bGray,
            style: widget.textStyle!,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: widget.textAlign!,
            decoration: InputDecoration(
              counterText: widget.maxLength == null ? '' : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.paddingWidth!,
                vertical: widget.paddingHeight!,
              ),
              suffixIcon: widget.suffixIcon,
              suffixIconColor: widget.focusNode.hasFocus ||
                      widget.controller != null &&
                          widget.controller!.text.isNotEmpty
                  ? bExtraLightBlue
                  : bGray,
              labelText: widget.labelText,
              labelStyle: const TextStyle(color: bDarkGray, fontSize: 16),
              hintText: widget.hintText!,
              hintStyle: TextStyle(color: bDarkGray.withOpacity(.75)),
              fillColor: widget.focusNode.hasFocus ||
                      widget.controller != null &&
                          widget.controller!.text.isNotEmpty
                  ? Colors.white
                  : widget.bgColor ?? const Color(0XFFEFEFEF),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: bExtraLightBlue),
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: bExtraLightGray),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
        if (widget.errorText != "")
          TextB(
            text: widget.errorText!,
            fontSize: 12,
            fontColor: bRed,
          ),
      ],
    );
  }
}
