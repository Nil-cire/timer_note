// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteDto _$NoteDtoFromJson(Map<String, dynamic> json) => NoteDto(
      json['uuid'] as String,
      json['subject'] as String,
      json['content'] as String,
      json['timeSecond'] as int,
      json['date'] as String,
      json['temperature'] as String?,
      json['weather'] as String?,
      json['score'] as String,
      customData: (json['customData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$NoteDtoToJson(NoteDto instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'subject': instance.subject,
      'content': instance.content,
      'timeSecond': instance.timeSecond,
      'date': instance.date,
      'temperature': instance.temperature,
      'weather': instance.weather,
      'score': instance.score,
      'customData': instance.customData,
    };
