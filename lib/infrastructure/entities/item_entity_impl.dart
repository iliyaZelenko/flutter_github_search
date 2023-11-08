import 'package:github_search/domain/entities/item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_entity_impl.g.dart';

@JsonSerializable(createToJson: false)
class ItemEntityImpl extends ItemEntity {
  @override
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  bool isFavorite;

  @override
  @JsonKey(name: 'full_name')
  String name;

  ItemEntityImpl(
    id, {
    required this.name,
    this.isFavorite = false,
  }) : super(id, name: name);

  factory ItemEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$ItemEntityImplFromJson(json);
}
