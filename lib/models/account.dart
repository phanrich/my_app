import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? phone;

  const Account({required this.id, this.email, this.name, this.phone});

  static const empty = Account(id: "");

  bool get isEmptyAccount => this == Account.empty;
  bool get isNotEmptyAccount => this != Account.empty;

  @override
  List<Object?> get props => [id, name, phone];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}
