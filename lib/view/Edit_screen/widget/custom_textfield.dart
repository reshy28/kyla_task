import 'package:flutter/material.dart';
import 'package:kyla_task/utlis/colors_constant.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.labeltext,
    required this.controller,
    this.suffixicon,
    this.ontap,
    this.readonly = false,
    this.validator,
  });

  final String labeltext;
  final TextEditingController controller;
  final Widget? suffixicon;
  final VoidCallback? ontap;
  final bool readonly;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Colorsconstant.textformfieldcolor,
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          validator: validator,
          readOnly: readonly,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
              label: Text(
                labeltext,
                style: TextStyle(color: Color.fromARGB(255, 133, 122, 122)),
              ),
              suffixIcon: suffixicon),
          controller: controller,
        ),
      ),
    );
  }
}
