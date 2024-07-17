import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyla_task/model/doctor_model.dart';

class HomeScreenController with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController qualification = TextEditingController();
  String selectedGender = "All";
  String pickedImg = "";
  String selectedDistrict = "All";
  String selectedGender2 = "All";
  String selectedDistrict2 = "All";

  List<String> genders = [
    "All",
    'Male',
    'Female',
  ];
  List<String> districts = [
    "All",
    'Palakkad',
    'Malapuram',
    'Kasargod',
    'Kozhikode'
  ];
  List<Doctor> filteredData = [];

  //fetched datas list
  List<Doctor> doctorsdata = [];
  Doctor? selectedData;

  //selecting gender
  selectiongender(newValue) {
    selectedGender = newValue!;
    notifyListeners();
  }

  changeGender(String value) {
    selectedGender2 = value;
    filtering();
    notifyListeners();
  }

  changeDistrict(String value) {
    selectedDistrict2 = value;
    filtering();
    notifyListeners();
  }

  //selecting district
  selectiondistrict(newValue) {
    selectedDistrict = newValue!;
    notifyListeners();
  }

  // fun to pick image from the gallery
  Future pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImg = pickedFile.path;
      log(pickedImg);
      notifyListeners();
      return pickedFile.path;
    }
    return '';
  }

  //void savenumbr(String phonenumber) async {}

  ////data send to database

  Future addProfile() async {
    try {
      final imageurl = await uploadImage(File(pickedImg));
      // if (imageurl != "") {
      final ref = FirebaseFirestore.instance.collection("doctor");
      final docref = ref.doc();
      final id = docref.id;
      Map<String, dynamic> body() {
        return {
          "image": imageurl.toString(),
          "id": id.toString(),
          'name': name.text.trim(),
          'district': selectedDistrict,
          'email': email.text.trim(),
          'phone': phoneNumber.text.trim(),
          'gender': selectedGender,
          'qualification': qualification.text.trim(),
        };
      }

      docref.set(body());
      fetchdata();

      return true;
      // }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future editProfile(index) async {
    log(index.toString());
    final imageurl;
    try {
      if (pickedImg == '') {
        log('inmisde 1');
        imageurl = doctorsdata[index].image;
      } else {
        log('inmisde 2');
        imageurl = await uploadImage(File(pickedImg));
      }
      log("inside:${imageurl}");

      if (imageurl != null) {
        final ref = FirebaseFirestore.instance.collection("doctor");
        log("${doctorsdata[index].id}");
        log("inside$imageurl");
        final docref = ref.doc(doctorsdata[index].id);
        final specifiedDoc = await docref.get();
        if (specifiedDoc.exists) {
          Map<String, dynamic> body() {
            return {
              'id': doctorsdata[index].id,
              "image": imageurl.toString(),
              'name': name.text.trim(),
              'district': selectedDistrict,
              'email': email.text.trim(),
              'phone': phoneNumber.text.trim(),
              'gender': selectedGender,
              'qualification': qualification.text.trim(),
            };
          }

          docref.set(body());
          fetchdata();
        } else {
          log('not exist');
        }
      }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///fetch the data
  Future fetchdata() async {
    try {
      final ref = await FirebaseFirestore.instance.collection("doctor").get();
      final data = ref.docs.map((doc) => Doctor.fromJson(doc.data())).toList();
      doctorsdata = filteredData = data;
      log(doctorsdata.toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  //send image to database
  Future<String> uploadImage(File imageFile) async {
    try {
      //  String file = imageFile!.path.split('/').last;
      final refRoot =
          FirebaseStorage.instance.ref().child(imageFile.path.split('/').last);
      //  final storageRef = refRoot.child('images');
      //UploadTask uploadTask=refRoot.putFile(imageFile!);
      //final imgToUpload = refRoot.child(imageFile.path.split('/').last);

      await refRoot.putFile(imageFile);
      final downloadURL = await refRoot.getDownloadURL();
      print('Image uploaded at $downloadURL');

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  ///delete the data
  Future<bool> deleteProfile(String docId) async {
    try {
      final ref = FirebaseFirestore.instance.collection("doctor");
      await ref.doc(docId).delete();
      await fetchdata();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void getEditData(String id) {
    log(id);
    selectedData = doctorsdata.firstWhere(
      (element) => element.id == id,
    );
    name.text = selectedData!.name.toString();
    qualification.text = selectedData!.qualification.toString();
    selectedDistrict = selectedData!.district.toString();
    email.text = selectedData!.email.toString();
    phoneNumber.text = selectedData!.phone.toString();
    selectedGender = selectedData!.gender.toString();
    pickedImg = '';
    notifyListeners();
    log(jsonEncode(selectedData!.toJson()));
  }

////filtering
  void filtering() {
    if (selectedGender2 == "All" && selectedDistrict2 == "All") {
      // Show all data if both filters are set to "All"
      filteredData = doctorsdata;
    } else if (selectedGender2 == "All") {
      // Filter based on district only
      filteredData = doctorsdata
          .where((doctor) =>
              doctor.district?.toLowerCase() == selectedDistrict2.toLowerCase())
          .toList();
    } else if (selectedDistrict2 == "All") {
      // Filter based on gender only
      filteredData = doctorsdata
          .where((doctor) =>
              doctor.gender?.toLowerCase() == selectedGender2.toLowerCase())
          .toList();
    } else {
      // Filter based on both gender and district
      filteredData = doctorsdata
          .where((doctor) =>
              doctor.gender?.toLowerCase() == selectedGender2.toLowerCase() &&
              doctor.district?.toLowerCase() == selectedDistrict2.toLowerCase())
          .toList();
    }

    notifyListeners();
  }
}
