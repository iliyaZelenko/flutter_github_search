abstract class Entity<T> {
  final T id;

  const Entity(this.id);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant Entity other) => other.id == id;

  bool isSame(Entity other) => other.id == id;
}
