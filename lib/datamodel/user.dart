class User {
  String? idNumber;
  String? accountID;
  String? fullName;
  String? phoneNumber;
  Null? imageURL;
  String? birthDay;
  String? gender;
  String? schoolYear;
  String? schoolKey;
  String? dateCreated;
  bool? status;

  User(
      {this.idNumber,
        this.accountID,
        this.fullName,
        this.phoneNumber,
        this.imageURL,
        this.birthDay,
        this.gender,
        this.schoolYear,
        this.schoolKey,
        this.dateCreated,
        this.status});

  User.fromJson(Map<String, dynamic> json) {
    idNumber = json['idNumber'];
    accountID = json['accountID'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    imageURL = json['imageURL'];
    birthDay = json['birthDay'];
    gender = json['gender'];
    schoolYear = json['schoolYear'];
    schoolKey = json['schoolKey'];
    dateCreated = json['dateCreated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNumber'] = this.idNumber;
    data['accountID'] = this.accountID;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['imageURL'] = this.imageURL;
    data['birthDay'] = this.birthDay;
    data['gender'] = this.gender;
    data['schoolYear'] = this.schoolYear;
    data['schoolKey'] = this.schoolKey;
    data['dateCreated'] = this.dateCreated;
    data['status'] = this.status;
    return data;
  }
}