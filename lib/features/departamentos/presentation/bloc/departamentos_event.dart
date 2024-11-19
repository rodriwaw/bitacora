

part of 'departamentos_bloc.dart';

abstract class DepartamentosEvent {
  const DepartamentosEvent();
}

class GetDepartamentosEvent extends DepartamentosEvent {
  final bool loading;
  const GetDepartamentosEvent({this.loading = true});
}

class GetDepartamentoEvent extends DepartamentosEvent {
  final int id;
  const GetDepartamentoEvent(this.id);
}

class AddDepartamentoEvent extends DepartamentosEvent {
  final DepartamentosModel departamento;
  const AddDepartamentoEvent(this.departamento);
}