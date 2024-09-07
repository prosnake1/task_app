// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      name: json['name'] as String,
      desc: json['desc'] as String,
      notification: json['notification'] as bool,
      date: json['date'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'notification': instance.notification,
      'date': instance.date,
      'time': instance.time,
    };
