part of 'llaves_bloc.dart';

abstract class LlavesEvent {
  const LlavesEvent();
}

class GetLlavesEvent extends LlavesEvent {
  final bool loading;
  const GetLlavesEvent({this.loading = true});
}

/* class GetLlaveEvent extends LlavesEvent {
  final int id;
  const GetLlaveEvent(this.id);
} */

class AddLlaveEvent extends LlavesEvent {
  final bool loading;
  final LlavesModel llave;
  const AddLlaveEvent(this.llave, {this.loading = true});
}

class UpdateLlaveEvent extends LlavesEvent {
  final bool loading;
  final LlavesModel llave;
  const UpdateLlaveEvent(this.llave, {this.loading = true});
}

class DeleteLlaveEvent extends LlavesEvent {
  final bool loading;

  final LlavesModel llave;
  const DeleteLlaveEvent(this.llave, {this.loading = true});
}
