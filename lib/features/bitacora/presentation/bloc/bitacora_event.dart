part of 'bitacora_bloc.dart';

abstract class BitacoraEvent {
  const BitacoraEvent();
}

class GetBitacoraEvent extends BitacoraEvent {
  final bool loading;
  const GetBitacoraEvent({this.loading = true});
}

class AddBitacoraEvent extends BitacoraEvent {
  final bool loading;
  final BitacoraModel bitacora;
  const AddBitacoraEvent(this.bitacora, {this.loading = true});
}

class DeleteBitacoraEvent extends BitacoraEvent {
  final bool loading;

  final BitacoraModel bitacora;
  const DeleteBitacoraEvent(this.bitacora, {this.loading = true});
}
