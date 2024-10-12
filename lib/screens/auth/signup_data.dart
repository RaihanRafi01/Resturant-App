class SignUpData {
  String fullName1;
  String fullName2;
  String userType;
  String email;
  String location;
  String password;
  String confirmPassword;
  String dob;
  String phoneNumber;
  String gender;
  List<String>? occasionList;
  List<String>? dateList;
  int? preferredPriceRange; // To store the selected price range
  String? cuisinePreference; // To store the selected cuisine preference
  bool? newsletterSubscription; // To store the user's newsletter preference
  int? preferredCommunicationMethod; // To store the user's preferred communication method



  SignUpData({
    required this.fullName1,
    required this.fullName2,
    required this.userType,
    required this.email,
    required this.location,
    required this.password,
    required this.confirmPassword,
    required this.dob,
    required this.phoneNumber,
    required this.gender,
    required this.occasionList,
    required this.dateList,
    required this.preferredPriceRange,
    required this.cuisinePreference,
    required this.newsletterSubscription,
    required this.preferredCommunicationMethod
  });
}
