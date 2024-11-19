part of 'asociados_bloc.dart'; //asociado a la clase AsociadosBloc

abstract class AsociadosState {
  const AsociadosState();
}

class AsociadosInitial extends AsociadosState {}

//mientras se carga la lista de asociados
class AsociadosLoading extends AsociadosState {}

//error al cargar la lista de asociados
class AsociadosError extends AsociadosState {
  final String message;
  AsociadosError(this.message);
}

//lista de asociados cargada
class AsociadosLoaded extends AsociadosState {
  final List<AsociadosModel> asociados;
  AsociadosLoaded(this.asociados);
}

class AsociadosConLlaveLoaded extends AsociadosState {
  final List<AsociadosConLlaveModel> asociados;
  AsociadosConLlaveLoaded(this.asociados);
}

//asociado creado
class AsociadosCreated extends AsociadosState {
  final ApiResponse response;
  AsociadosCreated(this.response);
}

//asociado cargado
class AsociadoLoaded extends AsociadosState {
  final AsociadosModel asociado;
  AsociadoLoaded(this.asociado);
}

class AsociadoConLlaveLoaded extends AsociadosState {
  final AsociadosConLlaveModel asociado;
  AsociadoConLlaveLoaded(this.asociado);
}

//asociado actualizado
class AsociadosUpdated extends AsociadosState {
  final ApiResponse response;
  AsociadosUpdated(this.response);
}

//asociado eliminado
class AsociadosDeleted extends AsociadosState {
  final ApiResponse response;
  AsociadosDeleted(this.response);
}
