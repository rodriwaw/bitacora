part of 'exportar_bloc.dart';

abstract class ExportarEvent {
  const ExportarEvent();
}

class ExportarDataEvent extends ExportarEvent {
  final bool loading;
  const ExportarDataEvent({this.loading = true});
}

class ExportarDataYBorrarEvent extends ExportarEvent {
  final bool loading;
  const ExportarDataYBorrarEvent({this.loading = true});
}
