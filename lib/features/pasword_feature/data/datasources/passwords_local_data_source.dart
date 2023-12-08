import 'package:ramzino/core/errors/exceptions.dart';
import 'package:ramzino/core/utils/const.dart';
import 'package:ramzino/features/pasword_feature/data/models/password_model.dart';
import 'package:ramzino/features/pasword_feature/skeleton/page_resources.dart';

abstract class PasswordsLocalDatabase {
  Future<bool> addToDB(PasswordModel passwordModel);
  Future<List<dynamic>> getAllPasswords();
  Future<bool> deletePassword(String passID);
  Future<bool> updatePassword(PasswordModel passwordModel);
  Future<bool> mostUse(String passID);
}

class PasswordsLocalDatabaseImpl implements PasswordsLocalDatabase {
  @override
  Future<bool> addToDB(PasswordModel passwordModel) async {
    try {
      await passwordsbox.add(passwordModel);
      return true;
    } catch (e) {
      print('unsaved:$e');
      throw DataBaseException();
    }
  }

  @override
  Future<bool> deletePassword(String passID) async {
    try {
      int modelIndex = passwordsbox.values
          .toList()
          .indexWhere((passModel) => passModel.id == passID);
      await passwordsbox.deleteAt(modelIndex);

      return true;
    } catch (e) {
      print('unDelete:$e');
      throw DataBaseException();
    }
  }

  @override
  Future<List<dynamic>> getAllPasswords() async {
    try {
      List passLists = passwordsbox.values.toList();
      // print('passwords:$allPass');
      return passLists;
    } catch (e) {
      print('get all error $e');
      throw DataBaseException();
    }
  }

  @override
  Future<bool> updatePassword(
    PasswordModel passwordModel,
  ) async {
    try {
      int modelIndex = passwordsbox.values
          .toList()
          .indexWhere((passModel) => passModel.id == passwordModel.id);
      await passwordsbox.putAt(modelIndex, passwordModel);
      return true;
    } catch (e) {
      print('update error $e');
      throw DataBaseException();
    }
  }

  @override
  Future<bool> mostUse(String passID) async {
    try {
      // passwordModel.isMostUse = !passwordModel.isMostUse;
      int modelIndex = passwordsbox.values
          .toList()
          .indexWhere((passModel) => passModel.id == passID);
      PasswordModel passwordModel = passwordsbox.getAt(modelIndex);
      passwordModel.isMostUse = !passwordModel.isMostUse!;
      await passwordsbox.putAt(modelIndex, passwordModel);

      print(passwordModel.isMostUse);
      // await passwordsbox.putAt(modelIndex, passwordModel);
      return true;
    } catch (e) {
      print('most use error $e');
      throw DataBaseException();
    }
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
