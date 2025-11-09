import '../models/remote_user.dart';
import '../../domain/model/user.dart';

extension RemoteUserToDomain on RemoteUser {
  User toDomain() {
    return User(
      firstName: firstName,
      lastName: lastName,
      maidenName: maidenName,
      age: age,
      gender: gender,
      email: email,
      phone: phone,
      birthDate: birthDate,
      image: image,
    );
  }
}
