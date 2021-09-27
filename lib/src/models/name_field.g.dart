// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_field.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NameFieldAdapter extends TypeAdapter<NameField> {
  @override
  final int typeId = 2;

  @override
  NameField read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NameField(
      arabic: fields[0] as String,
      english: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NameField obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.arabic)
      ..writeByte(1)
      ..write(obj.english);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameFieldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
