import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdminUser extends Equatable{

  const AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photo,
    required this.isActive,
}
      );

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String photo;
  final bool isActive;


  factory AdminUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdminUser(
      id: doc.id,
      name: data["name"] as String? ?? "مسؤول",
      email: data["email"] as String? ?? "admin@jenan.com",
      phoneNumber: data["phoneNumber"] as String? ?? "0000000000",
      photo: data["photo"] as String? ?? "https://res.cloudinary.com/dsptbzrkd/image/upload/v1791315811/logo1_gbr53x.png",
      isActive: data["isActive"] as bool? ?? false,
    );
  }


  @override
  List<Object?> get props => [id, name, email, phoneNumber, photo, isActive];


}