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
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      photo: data['photo'] as String? ?? '',
      isActive: data['isActive'] as bool? ?? false,
    );
  }


  @override
  List<Object?> get props => [id, name, email, phoneNumber, photo, isActive];


}