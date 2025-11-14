import 'dart:io';
import '../../../../../core/constants.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<QueryExecutor> openConnectionImpl() => _open();

Future<QueryExecutor> _open() async {
  final dir = await getApplicationSupportDirectory();
  final file = File(p.join(dir.path, Constants.userDb));
  return NativeDatabase.createInBackground(file);
}