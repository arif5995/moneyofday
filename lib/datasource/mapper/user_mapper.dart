import 'package:monday/datasource/model/user_table.dart';
import 'package:monday/domain/entities/user_entity.dart';

class UserMapper {
  UserTable mapUserEntityForUserTable(UserEntity userEntity) => UserTable(
      id: userEntity.id, name: userEntity.name, photo: userEntity.photo);

  UserEntity mapUserTableForUserEntity(UserTable userEntity) => UserEntity(
      id: userEntity.id, name: userEntity.name, photo: userEntity.photo);
}
