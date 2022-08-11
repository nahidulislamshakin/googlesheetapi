class UserFields{

  static  String name = "name";
  static  String number = "number";
  static List<String> getFields() => [name,number];
}
class User{

  final String name;
  final String number;

  User({required this.name,required this.number});

  Map<String, dynamic> toJson() => {

    UserFields.name: name,
    UserFields.number: number,
  };
}