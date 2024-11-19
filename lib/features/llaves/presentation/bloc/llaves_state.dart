part of 'llaves_bloc.dart';

abstract class LlavesState {
  const LlavesState();
}

class LlavesInitial extends LlavesState {}

//mientras se carga la lista de llaves
class LlavesLoading extends LlavesState {}

//error al cargar la lista de llaves
class LlavesError extends LlavesState {
  final String message;
  LlavesError(this.message);
}

//lista de llaves cargada
class LlavesLoaded extends LlavesState {
  final List<LlavesModel> llaves;
  LlavesLoaded(this.llaves);
}

//llave creada
class LlavesCreated extends LlavesState {
  final ApiResponse response;
  LlavesCreated(this.response);
}

//llave cargada
class LlaveLoaded extends LlavesState {
  final LlavesModel llave;
  LlaveLoaded(this.llave);
}

//llave actualizada
class LlavesUpdated extends LlavesState {
  final ApiResponse response;
  LlavesUpdated(this.response);
}

//llave eliminada
class LlavesDeleted extends LlavesState {
  final ApiResponse response;
  LlavesDeleted(this.response);
}