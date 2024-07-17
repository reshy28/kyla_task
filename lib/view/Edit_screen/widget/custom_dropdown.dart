import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  CustomDropdown({
    Key? key,
    required this.hintext,
    required this.selectedvalue,
    required this.itemlist,
    required this.onchanged,
  }) : super(key: key);

  final String hintext;
  String selectedvalue;
  final List<String> itemlist;
  final Function onchanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      hint: Text(
        widget.hintext,
        style: TextStyle(fontSize: 14),
      ),
      value: widget.selectedvalue,
      // onTap: widget.onchanged,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            widget.selectedvalue = newValue;
          });
        }
      },
      items: widget.itemlist.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
    // DropdownButton<String>(
    //   underline: Container(),
    //   hint: Text(
    //     widget.hintext,
    //     style: TextStyle(fontSize: 14),
    //   ),
    //   value: widget.selectedvalue,
    //   onChanged: (String? newValue) {
    //     if (newValue != null) {
    //       setState(() {
    //         widget.selectedvalue = newValue;
    //       });
    //     }
    //   },
    //   items: widget.itemlist.map((String value) {
    //     return DropdownMenuItem<String>(
    //       value: value,
    //       child: Text(
    //         value,
    //         style: TextStyle(fontSize: 14),
    //       ),
    //     );
    //   }).toList(),
    // );
  }
}
