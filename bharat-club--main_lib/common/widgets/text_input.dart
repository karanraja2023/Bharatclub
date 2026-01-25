import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class TextInputWidget extends StatefulWidget {
  final String placeHolder;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? errorText;
  final bool? hidePassword;
  final bool? showFloatingLabel;
  final bool? isReadOnly;
  final String? suffixIconType;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final Color? borderColor;
  final TextCapitalization? textCapitalization;
  final int? maxCharLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function? onClick;
  final Function? onTextChange;
  final int maxLines;
  final List<TextInputFormatter>? onFilteringTextInputFormatter;

  const TextInputWidget({
    super.key,
    required this.placeHolder,
    required this.hintText,
    required this.controller,
    required this.errorText,
    this.isReadOnly = false,
    this.suffixIconType,
    this.hidePassword = false,
    this.showFloatingLabel = true,
    this.textInputType = TextInputType.text,
    this.borderColor,
    this.hintTextColor,
    this.labelTextColor,
    this.textCapitalization,
    this.maxCharLength = 300,
    this.prefixIcon,
    this.suffixIcon,
    this.onClick,
    this.onTextChange,
    this.onFilteringTextInputFormatter = const [],
    this.maxLines = 1,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          if (_isFocused || widget.errorText != null)
            BoxShadow(
              color: widget.errorText != null
                  ? Colors.red.withOpacity(0.2)
                  : AppColors.cAppColors.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          else
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        elevation: _isFocused ? 2 : 0,
        borderRadius: BorderRadius.circular(12.r),
        shadowColor: AppColors.cAppColors.withOpacity(0.2),
        child: TextField(
          focusNode: _focusNode,
          onChanged: (value) {
            if (widget.onTextChange != null) {
              widget.onTextChange!(value.toString());
            }
          },
          onTap: () {
            if (widget.onClick != null) {
              widget.onClick!("click");
            }
          },
          readOnly: widget.isReadOnly ?? false,
          enableSuggestions: false,
          autocorrect: false,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          maxLines: widget.maxLines,
          obscureText: widget.hidePassword ?? false,
          inputFormatters:
              widget.onFilteringTextInputFormatter ?? <TextInputFormatter>[],
          style: getTextMedium(colors: AppColors.cAppColors, size: 16.sp),
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
            floatingLabelBehavior: (widget.showFloatingLabel ?? true)
                ? FloatingLabelBehavior.auto
                : FloatingLabelBehavior.never,
            labelText: widget.placeHolder,
            hintText: widget.hintText,
            hintStyle: getTextRegular(
              colors: Colors.grey.shade500,
              size: 15.sp,
            ),
            errorText: widget.errorText,
            errorStyle: getTextRegular(colors: Colors.red, size: 12.sp),
            labelStyle: getTextRegular(
              colors: _isFocused ? AppColors.cAppColors : Colors.grey.shade600,
              size: 15.sp,
            ),
            floatingLabelStyle: getTextMedium(
              colors: _isFocused ? AppColors.cAppColors : Colors.grey.shade600,
              size: 13.sp, 
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: Icon(
                      widget.prefixIcon,
                      size: 22.sp,
                      color: _isFocused
                          ? AppColors.cAppColors
                          : Colors.grey.shade500,
                    ),
                  ),
            suffixIcon: widget.suffixIcon == null
                ? null
                : GestureDetector(
                    onTap: () {
                      if (widget.onClick != null) {
                        widget.onClick!("suffixIcon");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 8.w),
                      child: Icon(
                        widget.suffixIcon,
                        size: 22.sp,
                        color: _isFocused
                            ? AppColors.cAppColors
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.grey.shade300,
                width: 1.5.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.cAppColors,
                width: 2.w, // Reduced from 2.5 to prevent cutting
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.w, // Reduced from 2.5
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            filled: true,
            fillColor: widget.isReadOnly == true
                ? Colors.grey.shade50
                : (_isFocused ? Colors.white : Colors.grey.shade50),
            // FIXED: Increased vertical padding to prevent label cutting
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h, // Increased from 18.h to 20.h
            ),
            // FIXED: Added this to prevent label from being cut
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
        ),
      ),
    );
  }
}
