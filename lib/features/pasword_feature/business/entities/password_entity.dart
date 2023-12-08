import 'package:equatable/equatable.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

class PasswordEntity extends Equatable {
   String? title;
  final PasswordType? type;
  final String? id;
   String? describtion;
   String? username;
   String? password;
   bool? isMostUse;
   PasswordEntity(
      {this.describtion,
      this.title,
      this.password,
      this.id,
      this.type,
      this.username,
      this.isMostUse=false});

  @override
  // TODO: implement props
  List<Object?> get props => [title, describtion, password, id, type,isMostUse];
}
