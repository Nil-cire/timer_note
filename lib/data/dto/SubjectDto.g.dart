// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectDto _$SubjectDtoFromJson(Map<String, dynamic> json) => SubjectDto(
      json['uuid'] as String,
      json['title'] as String,
      (json['notes'] as List<dynamic>?)
          ?.map((e) => NoteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectDtoToJson(SubjectDto instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'notes': instance.notes?.map((e) => e.toJson()).toList(),
    };
