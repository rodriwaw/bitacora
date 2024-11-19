part of 'departamentos_bloc.dart';

abstract class DepartamentosState {
  const DepartamentosState();
}

class DepartamentosInitial extends DepartamentosState {}

//mientras se carga la lista de departamentos
class DepartamentosLoading extends DepartamentosState {}

//error al cargar la lista de departamentos
class DepartamentosError extends DepartamentosState {
  final String message;
  DepartamentosError(this.message);
}

//lista de departamentos cargada
class DepartamentosLoaded extends DepartamentosState {
  final List<DepartamentosModel> departamentos;
  DepartamentosLoaded(this.departamentos);
}

//departamento creado
class DepartamentosCreated extends DepartamentosState {
  final ApiResponse response;
  DepartamentosCreated(this.response);
}
