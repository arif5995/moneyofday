abstract class Mapper<T, U> {
  T toEntity(U model);
  U toModel(T entity);
}