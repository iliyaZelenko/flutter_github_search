// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_entity_cache_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemEntityCacheImpl _$ItemEntityCacheImplFromJson(Map<String, dynamic> json) =>
    ItemEntityCacheImpl(
      json['id'] as int,
      name: json['name'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemEntityCacheImplToJson(
        ItemEntityCacheImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFavorite': instance.isFavorite,
    };
