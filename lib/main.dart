import 'package:flutter/cupertino.dart';

import 'di/injection_container.dart';
import 'features/users/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await sl.allReady();
  runApp(const MyApp());
}
