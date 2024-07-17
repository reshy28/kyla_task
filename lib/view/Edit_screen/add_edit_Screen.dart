import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kyla_task/controller/homescreen_controller.dart';
import 'package:kyla_task/model/doctor_model.dart';
import 'package:kyla_task/utlis/colors_constant.dart';
import 'package:provider/provider.dart';

import 'widget/custom_textfield.dart';

String trim = "";

class EditScreen extends StatefulWidget {
  EditScreen({
    super.key,
    this.isAdd = false,
    this.index,
    this.id,
  });
  final bool isAdd;
  final int? index;
  final String? id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false; // Track whether the form has been submitted

  @override
  void initState() {
    super.initState();
    final Homescreenobj =
        Provider.of<HomeScreenController>(context, listen: false);
    if (widget.isAdd) {
      Homescreenobj.name.clear();
      Homescreenobj.qualification.clear();
      Homescreenobj.selectedDistrict = "All";
      Homescreenobj.selectedGender = "All";
      Homescreenobj.email.clear();
      Homescreenobj.phoneNumber.clear();
      Homescreenobj.pickedImg = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Homescreenobj = Provider.of<HomeScreenController>(context);
    final size = MediaQuery.of(context).size;

    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.isAdd ? "Add Profile" : "Edit Doctor",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Homescreenobj.deleteProfile(
                    Homescreenobj.doctorsdata[widget.index!].id.toString());
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colorsconstant.myred,
              ),
            ),
            // Icon(
            //   Icons.delete,
            //   color: Colorsconstant.myred,
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled, // Initial autovalidate mode
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            (!widget.isAdd && Homescreenobj.pickedImg == "")
                                ? (Homescreenobj.filteredData[widget.index!]
                                            .image ==
                                        "")
                                    ? AssetImage('assets/noimage1.jpg')
                                    : NetworkImage(Homescreenobj
                                        .filteredData[widget.index!].image
                                        .toString())
                                : Homescreenobj.pickedImg != ''
                                    ? FileImage(File(Homescreenobj.pickedImg))
                                    : AssetImage('assets/Group 35.png')
                                        as ImageProvider,
                      ),
                      Positioned(
                        right: 1,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            Homescreenobj.pickImageFromGallery();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset("assets/edit_icon.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    labeltext: "Full Name",
                    controller: Homescreenobj.name,
                    validator: (value) {
                      if (_submitted && (value == null || value.isEmpty)) {
                        return 'Please enter your full name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value ?? "")) {
                        return 'Name should only contain alphabets';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    labeltext: "Qualification",
                    controller: Homescreenobj.qualification,
                    validator: (value) {
                      if (_submitted && (value == null || value.isEmpty)) {
                        return 'Please enter your qualification';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  FormField<String>(
                    validator: (value) {
                      if (_submitted &&
                          Homescreenobj.selectedDistrict == null) {
                        return 'Please select a district';
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colorsconstant.textformfieldcolor,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            border: InputBorder.none,
                          ),
                          isEmpty: Homescreenobj.selectedDistrict == null,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                'Select District',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 133, 122, 122)),
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              value: Homescreenobj.selectedDistrict,
                              onChanged: (String? newValue) {
                                setState(() {
                                  Homescreenobj.selectiondistrict(newValue);
                                  state.didChange(newValue);
                                });
                              },
                              items:
                                  Homescreenobj.districts.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value == "All"
                                        ? "Select a district"
                                        : value,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: value == "All"
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    labeltext: "Email",
                    controller: Homescreenobj.email,
                    validator: (value) {
                      if (_submitted && (value == null || value.isEmpty)) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    labeltext: "Phone Number",
                    controller: Homescreenobj.phoneNumber,
                    validator: (value) {
                      if (_submitted && (value == null || value.isEmpty)) {
                        return 'Please enter your phone number';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value ?? "")) {
                        return 'Phone number should contain only digits';
                      }
                      // if (Homescreenobj.phoneNumber.text.startsWith("+91")) {
                      //   trim = Homescreenobj.phoneNumber.text.substring(3);
                      // }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  FormField<String>(
                    validator: (value) {
                      if (_submitted && Homescreenobj.selectedGender == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                    builder: (FormFieldState<String> state) {
                      return Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colorsconstant.textformfieldcolor,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          isEmpty: Homescreenobj.selectedGender == null,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                'Select Gender',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 122, 122),
                                ),
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              value: Homescreenobj.selectedGender,
                              onChanged: (String? newValue) {
                                setState(() {
                                  Homescreenobj.selectiongender(newValue);
                                  state.didChange(newValue);
                                });
                              },
                              items: Homescreenobj.genders.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value == "All" ? "Select a gender" : value,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: value == "All"
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _submitted = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        if (Homescreenobj.pickedImg != "") {
                          if (widget.isAdd) {
                            if (Homescreenobj.selectedDistrict == "All" ||
                                Homescreenobj.selectedGender == "All") {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please select the gender and district'),
                                ),
                              );
                            } else {
                              final isSuccess =
                                  await Homescreenobj.addProfile();
                              if (isSuccess) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            }
                          } else {
                            if (Homescreenobj.selectedDistrict == "All" ||
                                Homescreenobj.selectedGender == "All") {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please select the gender and district'),
                                ),
                              );
                            } else {
                              log(Homescreenobj.doctorsdata[widget.index!].image
                                  .toString());
                              log(Homescreenobj.doctorsdata[widget.index!].id
                                  .toString());
                              final isSuccess = await Homescreenobj.editProfile(
                                  widget.index!);
                              if (isSuccess) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            }
                          }
                        } else {
                          Navigator.pop(context);
                          SnackBar(content: Text("choose a image"));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all required fields'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 52,
                      width: size.width,
                      child: Center(
                          child: Text(
                        "Save",
                        style: TextStyle(color: Colorsconstant.mywhite),
                      )),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colorsconstant.mygreen),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
