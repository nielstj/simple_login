import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.phoneNumber);

  final String id;
  final String phoneNumber;

  @override
  List<Object> get props => [id, phoneNumber];

  static const empty = User('-', '-');
}
