
import 'package:flutter/material.dart';
import 'package:kyla_task/controller/homescreen_controller.dart';
import 'package:kyla_task/model/doctor_model.dart';
import 'package:kyla_task/utlis/colors_constant.dart';
import 'package:kyla_task/view/Edit_screen/add_edit_Screen.dart';
import 'package:kyla_task/view/Edit_screen/widget/Doctors_Card.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    final Homescreenobj =
        Provider.of<HomeScreenController>(context, listen: false);
    Homescreenobj.fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<HomeScreenController>(
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Doctors",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        DropdownButton<String>(
                          underline: Container(),
                          hint: Text(
                            'Gender',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: value.selectedGender2,
                          onChanged: (String? newValues) {
                            value.changeGender(newValues!);
                          },
                          items: value.genders.map((String value1) {
                            return DropdownMenuItem<String>(
                              value: value1,
                              child: Text(
                                value1,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        DropdownButton<String>(
                          underline: Container(),
                          hint: Text(
                            'District',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: value.selectedDistrict2,
                          onChanged: (String? newValue) {
                            value.changeDistrict(newValue!);
                          },
                          items: value.districts.map((String value1) {
                            return DropdownMenuItem<String>(
                              value: value1,
                              child: Text(
                                value1,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Consumer<HomeScreenController>(
                    builder: (context, value, child) => ListView.separated(
                      itemCount: value.filteredData.length,
                      itemBuilder: (context, index) {
                        return DoctorsCard(
                          id: value.filteredData[index].id,
                          index: index,
                          imageurl: value.filteredData[index].image,
                          title: value.filteredData[index].name.toString(),
                          district:
                              value.filteredData[index].district.toString(),
                          qualification: value.filteredData[index].qualification
                              .toString(),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colorsconstant.mygreen,
        child: Icon(
          Icons.add,
          color: Colorsconstant.mywhite,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(isAdd: true),
              ));
        },
      ),
    );
  }
}
