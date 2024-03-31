// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveItemsAdapter extends TypeAdapter<HiveItems> {
  @override
  final int typeId = 0;

  @override
  HiveItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveItems(
      itemName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveItems obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.itemName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
