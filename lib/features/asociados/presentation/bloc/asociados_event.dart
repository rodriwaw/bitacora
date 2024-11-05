part of 'asociados_bloc.dart'; //asociado a la clase AsociadosBloc

abstract class AsociadosEvent {
  const AsociadosEvent();
}

class GetAsociadosEvent extends AsociadosEvent {
  final bool loading;
  const GetAsociadosEvent({this.loading = true});
}

class GetAsociadoEvent extends AsociadosEvent {
  final int id;
  const GetAsociadoEvent(this.id);
}

class AddAsociadoEvent extends AsociadosEvent {
  final AsociadosModel asociado;
  const AddAsociadoEvent(this.asociado);
}