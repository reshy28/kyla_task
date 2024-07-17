import 'package:flutter/material.dart';
import 'package:kyla_task/controller/homescreen_controller.dart';
import 'package:kyla_task/utlis/colors_constant.dart';
import 'package:kyla_task/view/Edit_screen/add_edit_Screen.dart';
import 'package:provider/provider.dart';

class DoctorsCard extends StatelessWidget {
  const DoctorsCard({
    super.key,
    required this.title,
    required this.qualification,
    required this.district,
    this.imageurl,
    this.index,
    this.id,
  });
  final String title;
  final String qualification;
  final String district;
  final String? imageurl;
  final int? index;
  final String? id;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageurl != ""
                            ? NetworkImage(
                                imageurl.toString(),
                              )
                            : AssetImage("assets/noimage1.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                  ),
                  Text(
                    qualification,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    district,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Provider.of<HomeScreenController>(context, listen: false)
                      .getEditData(Provider.of<HomeScreenController>(context,
                              listen: false)
                          .doctorsdata[index!]
                          .id
                          .toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          index: index,
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colorsconstant.mygreen,
                      borderRadius: BorderRadius.circular(5)),
                  height: 20,
                  width: 70,
                  child: Center(
                      child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
