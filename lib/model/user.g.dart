// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as String,
    )..typeUser = fields[2] as TypeUser;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.typeUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeUserAdapter extends TypeAdapter<TypeUser> {
  @override
  final int typeId = 1;

  @override
  TypeUser read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeUser.none;
      case 1:
        return TypeUser.viewer;
      case 2:
        return TypeUser.editor;
      case 3:
        return TypeUser.admin;
      case 4:
        return TypeUser.superuser;
      default:
        return TypeUser.none;
    }
  }

  @override
  void write(BinaryWriter writer, TypeUser obj) {
    switch (obj) {
      case TypeUser.none:
        writer.writeByte(0);
        break;
      case TypeUser.viewer:
        writer.writeByte(1);
        break;
      case TypeUser.editor:
        writer.writeByte(2);
        break;
      case TypeUser.admin:
        writer.writeByte(3);
        break;
      case TypeUser.superuser:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['password'] as String,
    )
      ..typeUser = $enumDecode(_$TypeUserEnumMap, json['typeUser'])
      ..allowedGroup = (json['allowedGroup'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'typeUser': _$TypeUserEnumMap[instance.typeUser]!,
      'allowedGroup': instance.allowedGroup,
    };

const _$TypeUserEnumMap = {
  TypeUser.none: 'none',
  TypeUser.viewer: 'viewer',
  TypeUser.editor: 'editor',
  TypeUser.admin: 'admin',
  TypeUser.superuser: 'superuser',
};
