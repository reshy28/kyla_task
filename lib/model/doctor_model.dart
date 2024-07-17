class Doctor {
  String? id;
  String? image;
  String? name;
  String? qualification;
  String? district;
  String? gender;
  String? email;
  String? phone;

  Doctor({
    this.image,
    this.name,
    this.qualification,
    this.district,
    this.gender,
    this.email,
    this.phone,
    this.id,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        image: json['image'],
        name: json['name'],
        qualification: json['qualification'],
        district: json['district'],
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'qualification': qualification,
        'district': district,
        'gender': gender,
        'email': email,
        'phone': phone,
        'id': id,
      };
}
