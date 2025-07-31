import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../aux_classes/file_info.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';
import '../utilities/files.dart';

class User {
  String id;
  String? name;
  DateTime? birthDate;
  String? email;
  String? documentNumber;
  String? phone;
  FileInfo? profileImageData;
  PlatformFile? profileImage;
  bool isSuperAdmin = false;
  String? preferredCurrency;
  String? preferredLanguage;
  String? timezone;
  String? dateFormat;
  String? countryCode;
  String? thousandsSeparator;
  String? decimalSeparator;

  User({
    required this.id,
    this.name,
    this.birthDate,
    this.email,
    this.documentNumber,
    this.phone,
    this.profileImageData,
    this.profileImage,
    this.preferredCurrency,
    this.preferredLanguage,
    this.timezone,
    this.dateFormat,
    this.countryCode,
    this.thousandsSeparator,
    this.decimalSeparator,
    this.isSuperAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      email: json['email'],
      documentNumber: json['document_number'],
      phone: json['phone_number'],
      preferredCurrency: json['preferred_currency'],
      preferredLanguage: json['preferred_language'],
      timezone: json['timezone'],
      dateFormat: json['date_format'],
      countryCode: json['country_code'],
      thousandsSeparator: json['thousands_separator'],
      decimalSeparator: json['decimal_separator'],
      profileImageData: json['profile_image_data'] != null
          ? FileInfo.fromJson(json['profile_image_data'])
          : null,
      isSuperAdmin: json['is_super_admin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birth_date': birthDate?.toIso8601String(),
      'email': email,
      'document_number': documentNumber,
      'phone_number': phone,
      'preferred_currency': preferredCurrency,
      'preferred_language': preferredLanguage,
      'timezone': timezone,
      'date_format': dateFormat,
      'country_code': countryCode,
      'thousands_separator': thousandsSeparator,
      'decimal_separator': decimalSeparator,
      'profile_image_data': profileImageData,
      'is_super_admin': isSuperAdmin,
    };
  }

  Future<void> refresh() async {
    User updated = await UserService.find(id);
    id = updated.id;
    name = updated.name;
    birthDate = updated.birthDate;
    email = updated.email;
    documentNumber = updated.documentNumber;
    phone = updated.phone;
    preferredCurrency = updated.preferredCurrency;
    preferredLanguage = updated.preferredLanguage;
    timezone = updated.timezone;
    dateFormat = updated.dateFormat;
    countryCode = updated.countryCode;
    thousandsSeparator = updated.thousandsSeparator;
    decimalSeparator = updated.decimalSeparator;
    profileImageData = updated.profileImageData;
    isSuperAdmin = updated.isSuperAdmin;
  }

  bool isCurrentUser(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == id;
  }

  Future<PlatformFile?> loadProfileImage() async {
    return profileImage = await loadFile(profileImageData);
  }
}
