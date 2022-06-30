import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:notes_firebase_ddd_course/domain/auth/app_user.dart';
import 'package:notes_firebase_ddd_course/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  AppUser toDomain() {
    return AppUser(id: UniqueId.fromUniqueString(uid));
  }
}
