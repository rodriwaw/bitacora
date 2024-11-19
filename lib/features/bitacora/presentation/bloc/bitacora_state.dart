part of 'bitacora_bloc.dart';

abstract class BitacoraState {
  const BitacoraState();
}

class BitacoraInitial extends BitacoraState{}


class BitacoraLoading extends BitacoraState {}

class BitacoraError extends BitacoraState {
  final String message;
  BitacoraError(this.message);
}

class BitacoraLoaded extends BitacoraState {
  final List<BitacoraModel> bitacoras;
  BitacoraLoaded(this.bitacoras);
}


class BitacoraCreated extends BitacoraState {
  final ApiResponse response;
  BitacoraCreated(this.response);
}

class BitacoraDeleted extends BitacoraState {
  final ApiResponse response;
  BitacoraDeleted(this.response);
}