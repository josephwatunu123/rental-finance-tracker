import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List? items;
  final Function(String?) onChanged;
  final bool isFullWidth;
  final double? width;
  final String hint;
  final String? selectedValue;
  final String? errorText;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    this.isFullWidth = false,
    this.width,
    required this.hint,
    this.selectedValue,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final calculatedWidth =
        isFullWidth
            ? double.infinity
            : (width != null && width! > 0)
            ? size.width * width!
            : size.width * 0.5;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: calculatedWidth,
        height: size.height * 0.1,
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: theme.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 2, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 2, color: Colors.red),
            ),
            errorText: errorText,
          ),
          hint: Text(hint),
          items:
              items
                  ?.map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
