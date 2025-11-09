import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

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
    final db = await driftDatabase(
      name: 'users.db',
    );
    return db;
  });
}
