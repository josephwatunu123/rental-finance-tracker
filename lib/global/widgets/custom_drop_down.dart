import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List? items;
  final Function(String?) onChanged;
  final bool isFullWidth;
  final double? width;
  final String hint;
  const CustomDropDown({super.key, required this.items, required this.onChanged, this.isFullWidth=false, this.width, required this.hint});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.items!.isNotEmpty) {
      selectedItem = widget.items?.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final calculatedWidth = widget.isFullWidth
        ? double.infinity
        : (widget.width != null && widget.width! > 0)
        ? size.width * widget.width!
        : size.width * 0.5;
    return SizedBox(
      width:  calculatedWidth ,
      height: size.height * 0.1,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color:theme.primaryColor )
          )
        ),
          hint: Text(widget.hint),
          items: widget.items?.map((item)=>
              DropdownMenuItem<String>(
                value: item,
                  child: Text(item)
              )
          ).toList(),
        onChanged: (item) {
          setState(() {
            selectedItem = item;
          });
          widget.onChanged(item);
        },
      ),
    );
  }
}
