class UserInfo {
  final String address;
  final String city;
  final String phone;
  final int id;

  UserInfo({
    required this.address,
    required this.city,
    required this.phone,
    required this.id,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json, String infoKey) {
    if (infoKey == "admin_info") {
      return UserInfo(address: "NONE", city: "NONE", phone: "NONE", id: -1);
    }
    return UserInfo(
      address: json[infoKey][0] as String,
      city: json[infoKey][1] as String,
      phone: json[infoKey][2] as String,
      id: json[infoKey][3] as int,
    );
  }
}

class User {
  final int id;
  final String name;
  final String surname;
  final String username;
  final String pwd;
  final UserInfo customerInfo;
  final bool isAdmin;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.pwd,
      required this.customerInfo,
      required this.isAdmin});

  factory User.fromJson(List<dynamic> json) {
    Map<String, dynamic> infoMap = json[5] as Map<String, dynamic>;
    String infoKey =
        infoMap.containsKey('customer_info') ? 'customer_info' : 'admin_info';
    bool admin = infoMap.containsKey('customer_info') ? false : true;
    return User(
        id: json[0] as int,
        name: json[1] as String,
        surname: json[2] as String,
        username: json[3] as String,
        pwd: json[4] as String,
        customerInfo:
            UserInfo.fromJson(json[5] as Map<String, dynamic>, infoKey),
        isAdmin: admin);
  }
}
