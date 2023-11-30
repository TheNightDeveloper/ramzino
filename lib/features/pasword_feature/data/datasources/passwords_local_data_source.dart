import 'package:ramzino/core/errors/exceptions.dart';
import 'package:ramzino/core/utils/const.dart';
import 'package:ramzino/features/pasword_feature/data/models/password_model.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

abstract class PasswordsLocalDatabase {
  Future<bool> addToDB(PasswordModel passwordModel);
  Future<List<dynamic>> getAllPasswords();
  Future<bool> deletePassword(int index);
  Future<bool> updatePassword(int index, String? newValue);
}

class PasswordsLocalDatabaseImpl implements PasswordsLocalDatabase {
  @override
  Future<bool> addToDB(PasswordModel passwordModel) async {
    try {
      await passwordsbox.add(passwordModel);
      print('saved');
      return true;
    } catch (e) {
      print('unsaved:$e');
      throw DataBaseException();
    }
  }

  @override
  Future<bool> deletePassword(int index) async {
    try {
      await passwordsbox.deleteAt(index);
      print('deleted');
      return true;
    } catch (e) {
      print('unDelete:$e');
      throw DataBaseException();
    }
  }

  @override
  Future<List<dynamic>> getAllPasswords() async {
    List passLists = passwordsbox.values.toList();
    // print('passwords:$allPass');
    return passLists;
  }

  @override
  Future<bool> updatePassword(
    int index,
    dynamic newValue,
  ) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}






/*
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  final SharedPreferences sharedPreferences;

  TemplateLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sharedPreferences.getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(TemplateModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedTemplate,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
*/
