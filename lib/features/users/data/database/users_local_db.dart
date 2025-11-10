import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'users_local_db.g.dart';

class UsersTable extends Table {
  TextColumn get email => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get maidenName => text()();
  IntColumn get age => integer()();
  TextColumn get gender => text()();
  TextColumn get phone => text()();
  TextColumn get birthDate => text()();
  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {email};
}

@DriftDatabase(tables: [UsersTable])
class UsersLocalDb extends _$UsersLocalDb {
  UsersLocalDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<UsersTableData>> getAllUsers() =>
      select(usersTable).get();

  Future<void> clearAndInsertAll(List<UsersTableCompanion> entries) async {
    await transaction(() async {
      await delete(usersTable).go();
      await batch((batch) {
        batch.insertAll(usersTable, entries);
      });
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'users.db'));

    return NativeDatabase.createInBackground(file);
  });
}
