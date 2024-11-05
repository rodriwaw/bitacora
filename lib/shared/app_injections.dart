import '../core/utils/injections.dart';
import 'data/database.dart';

initAppInjections() async{
  sl.registerSingleton<DBCreator>(await DBCreator.create());
}
