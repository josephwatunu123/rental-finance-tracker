import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final Function? onChanged;
  final Function? onTap;
  final String? value;
  final TextInputType? inputType;
  final Function? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? isDense;
  final FocusNode? focusNode;
  final String? label;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool readOnly;
  final String? errorText;
  final List<String>? autoFillHints;

  const CustomInputField({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.onTap,
    this.value,
    this.inputType,
    this.validator,
    this.controller,
    this.isDense = true,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.focusNode,
    this.style,
    this.textInputAction,
    this.maxLines,
    this.errorText,
    this.autoFillHints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        readOnly: readOnly,
        autofillHints: autoFillHints,
        maxLines: maxLines ?? 1,
        initialValue: controller != null ? null : value,
        controller: controller,
        textAlign: TextAlign.left,
        onChanged: (String? data) {
          if (onChanged != null) {
            onChanged!(data);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        style:
        ((style ??
            theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ))),
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: isDense,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          label: label != null ? Text(label!) : const SizedBox(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          errorText: errorText,
          errorStyle: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.error,
          ),
          hintStyle: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.outline,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
        validator: (String? value) {
          if (validator == null) return null;
          return validator!(value);
        },
        keyboardType: inputType,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction,
      ),
    );
  }
}
