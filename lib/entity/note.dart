import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/domain/constants.dart';

part "note.g.dart";

@HiveType(typeId: notesTypeId)
class Note extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String mainText;
  @HiveField(2)
  String dayRating;
  @HiveField(3)
  List<Uint8List> images;

  Note({
    required this.name,
    required this.mainText,
    required this.dayRating,
    required this.images,
  });
}
