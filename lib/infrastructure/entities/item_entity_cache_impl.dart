import 'package:github_search/domain/entities/item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_entity_cache_impl.g.dart';

@JsonSerializable()
class ItemEntityCacheImpl extends ItemEntity {
  ItemEntityCacheImpl(
    super.id, {
    required super.name,
    super.isFavorite,
  });

  factory ItemEntityCacheImpl.fromJson(Map<String, dynamic> json) =>
      _$ItemEntityCacheImplFromJson(json);

  factory ItemEntityCacheImpl.fromItemEntity(ItemEntity itemEntity) =>
      ItemEntityCacheImpl(
        itemEntity.id,
        name: itemEntity.name,
        isFavorite: itemEntity.isFavorite,
      );

  Map<String, dynamic> toJson() => _$ItemEntityCacheImplToJson(this);
}
