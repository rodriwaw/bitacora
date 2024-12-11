part of 'asociados_bloc.dart'; //asociado a la clase AsociadosBloc

abstract class AsociadosEvent {
  const AsociadosEvent();
}

class GetAsociadosEvent extends AsociadosEvent {
  final bool loading;
  const GetAsociadosEvent({this.loading = true});
}

class GetAsociadosConLlaveDispEvent extends AsociadosEvent {
  final bool loading;
  const GetAsociadosConLlaveDispEvent({this.loading = true});
}

class GetAsociadosConLlavePresEvent extends AsociadosEvent {
  final bool loading;
  const GetAsociadosConLlavePresEvent({this.loading = true});
}

class GetAsociadoByNumEvent extends AsociadosEvent {
  final bool loading;
  final String numAsociado;
  const GetAsociadoByNumEvent(this.numAsociado, {this.loading = true});
}

class AddAsociadoEvent extends AsociadosEvent {
  final bool loading;
  final AsociadosModel asociado;
  const AddAsociadoEvent(this.asociado, {this.loading = false});
}

class UpdateAsociadoEvent extends AsociadosEvent {
  final bool loading;
  final AsociadosModel asociado;
  const UpdateAsociadoEvent(this.asociado, {this.loading = false});
}

class DeleteAsociadoEvent extends AsociadosEvent {
  final bool loading;
  final AsociadosModel asociado;
  const DeleteAsociadoEvent(this.asociado, {this.loading = false});
}
