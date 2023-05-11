import 'package:itflowapp/constants/constants.dart';

enum UserType {
  standard,
  enterprise,
}

class UserModel {
  String name;
  UserType userType;
  String description;
  String? phone;
  String? location;
  String? address;
  String? siteUrl;
  List<dynamic>? bookmarks;

  UserModel({
    required this.name,
    required this.userType,
    required this.description,
    this.phone,
    this.location,
    this.address,
    this.siteUrl,
    this.bookmarks,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> info) {
    return UserModel(
      name: info[kNameDocName],
      userType: info[kUserTypeDocName] == kUserTypeStandard
          ? UserType.standard
          : UserType.enterprise,
      description: info[kDescriptionDocName],
      phone: info[kPhoneDocName],
      location: info[kLocationDocName],
      address: info[kAddressDocName],
      siteUrl: info[kSiteUrlDocName],
      bookmarks: info[kBookmarksDocName],
    );
  }

  Map<String, dynamic>? toFirestore() {
    if (userType == UserType.standard) {
      if (location == null) return null;
      return {
        kNameDocName: name,
        kPhoneDocName: phone,
        kUserTypeDocName: kUserTypeStandard,
        kDescriptionDocName: description,
        kLocationDocName: location,
        kBookmarksDocName: bookmarks ?? [],
      };
    } else {
      if (address == null || siteUrl == null) return null;
      return {
        kNameDocName: name,
        kPhoneDocName: phone,
        kUserTypeDocName: kUserTypeEnterprise,
        kDescriptionDocName: description,
        kAddressDocName: address,
        kSiteUrlDocName: siteUrl,
      };
    }
  }
}
