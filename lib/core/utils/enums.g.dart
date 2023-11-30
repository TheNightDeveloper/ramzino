// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordTypeAdapter extends TypeAdapter<PasswordType> {
  @override
  final int typeId = 2;

  @override
  PasswordType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PasswordType.social;
      // case 1:
      //   return PasswordType.application;
      case 1:
        return PasswordType.creditCard;
      case 2:
        return PasswordType.webSite;
      // case 4:
      //   return PasswordType.device;
      case 3:
        return PasswordType.other;
      default:
        return PasswordType.social;
    }
  }

  @override
  void write(BinaryWriter writer, PasswordType obj) {
    switch (obj) {
      case PasswordType.social:
        writer.writeByte(0);
        break;
      // case PasswordType.application:
      //   writer.writeByte(1);
      //   break;
      case PasswordType.creditCard:
        writer.writeByte(1);
        break;
      case PasswordType.webSite:
        writer.writeByte(2);
        break;
      // case PasswordType.device:
      //   writer.writeByte(4);
      //   break;
      case PasswordType.other:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
