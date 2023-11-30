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
  Map<String, dynamic> fromJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'image': image,
    };
  }

  UserModel.toJson(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        age = res['age'],
        gender = res['gender'],
        image = res['image'];
}
