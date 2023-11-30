import 'package:equatable/equatable.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class PasswordEntity extends Equatable {
  final String? title;
  final PasswordType? type;
  final String? id;
  final String? describtion;
  final String? username;
  final String? password;
  const PasswordEntity(
      {this.describtion, this.title, this.password,this.id,this.type,this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [title, describtion, password,id,type];
}
