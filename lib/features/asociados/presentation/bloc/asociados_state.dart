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

//para el modal de detalle
class AsociadoEditModal extends AsociadosState {
  final AsociadosModel asociado;
  AsociadoEditModal(this.asociado);
}

//asociado creado
class AsociadosCreated extends AsociadosState {
  final ApiResponse response;
  AsociadosCreated(this.response);
}
