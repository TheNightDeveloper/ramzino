import 'package:hive_flutter/adapters.dart';
import 'package:ramzino/core/utils/enums.dart';
import 'package:ramzino/features/pasword_feature/business/entities/password_entity.dart';

part 'password_model.g.dart';

@HiveType(typeId: 1)
class PasswordModel extends PasswordEntity {
  @HiveField(0)
   String? title;
  @HiveField(1)
   PasswordType? type;
  @HiveField(2)
  final String? id;
  @HiveField(3)
   String? username;
  @HiveField(4)
   String? describtion;
  @HiveField(5)
   String? password;
  @HiveField(6,defaultValue: false)
   bool? isMostUse;
  
   PasswordModel({this.username, 
      this.describtion,
      this.title,
      this.password,
      this.id,
      this.type,
      this.isMostUse=false})
      : super(
            id: id,
            title: title,
            type: type,
            describtion: describtion,
            username: username,
            password: password,
            isMostUse: isMostUse);
}














/*
import '../../../../../core/constants/constants.dart';
import '../../business/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  const TemplateModel({
    required String template,
  }) : super(
          template: template,
        );

  factory TemplateModel.fromJson({required Map<String, dynamic> json}) {
    return TemplateModel(
      template: json[kTemplate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTemplate: template,
    };
  }
}
*/
