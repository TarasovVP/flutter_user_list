import '../../domain/model/user.dart';
import '../database/users_local_db.dart';

extension UserToEntity on User {
  UsersTableCompanion toEntity() {
    return UsersTableCompanion.insert(
      email: email,
      firstName: firstName,
      lastName: lastName,
      maidenName: maidenName,
      age: age,
      gender: gender,
      phone: phone,
      birthDate: birthDate,
      image: image,
    );
  }
}

extension UsersTableDataToDomain on UsersTableData {
  User toDomain() {
    return User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      age: age,
      image: image,
      maidenName: maidenName,
      gender: gender,
      birthDate: birthDate,
    );
  }
}
