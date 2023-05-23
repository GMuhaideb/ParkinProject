import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:parkin/presentation/adminPage/cubit/admin_cubit.dart';
import 'package:parkin/presentation/home%20screen/cubit/cubit.dart';
import 'package:parkin/presentation/login/cubit/cubit.dart';
import 'package:parkin/shared/component/bloc_observer.dart';
import 'package:parkin/shared/network/cache_helper.dart';

// Import the generated file
import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(
    Phoenix(
        child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (BuildContext context) => AuthCubit(),
      ),
      BlocProvider(
        create: (BuildContext context) => HomeCubit(),
      ),
      BlocProvider(
        create: (BuildContext context) => AdminCubit(),
      ),
    ], child: MyApp())),
  );
}
