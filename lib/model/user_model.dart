class UserModel {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.image,
  });
  // using for insert data
  Map<String, dynamic> fromJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'image': image,
    };
  }

  // using for get data
  UserModel.toJson(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        age = res['age'],
        gender = res['gender'],
        image = res['image'];
}
