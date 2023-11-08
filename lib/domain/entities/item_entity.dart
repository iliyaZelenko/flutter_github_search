import 'package:equatable/equatable.dart';

import 'entity.dart';

typedef ItemEntityIdType = int;

class ItemEntity extends Entity<ItemEntityIdType> with EquatableMixin {
  final String name;
  bool isFavorite;

  ItemEntity(
    super.id, {
    required this.name,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        isFavorite,
      ];
}
