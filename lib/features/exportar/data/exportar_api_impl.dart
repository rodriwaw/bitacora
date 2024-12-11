import 'dart:io';

import 'package:bitacora/features/exportar/data/abstract_exportar_api.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/injections.dart';
import '../../../shared/data/database.dart';

class ExportarApiImpl extends AbstractExportarApi {
  ExportarApiImpl();

  @override
  Future<ApiResponse> exportar() async {
    try {
      Excel excel = await generateExcel();
      //chequear permisos
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      String directory = "/storage/emulated/0/Download/";

      bool dirDownloadExists = await Directory(directory).exists();
      if (dirDownloadExists) {
        directory = "/storage/emulated/0/Download/";
      } else {
        directory = "/storage/emulated/0/Downloads/";
      }
      //guardar archivo
      var fileBytes = excel.save();
      if (fileBytes == null) {
        throw ('No se pudo guardar el archivo');
      }
      File(join(
          "$directory/bitacora_${DateFormat('ddMMyyyyhhmm').format(DateTime.now())}.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);

      return Success(true, 'Archivo guardado en descargas');
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<ApiResponse> exportarYBorrar() async {
    try {
      Excel excel = await generateExcel();

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      String directory = "/storage/emulated/0/Download/";
      bool dirDownloadExists = await Directory(directory).exists();
     
      if (dirDownloadExists) {
        directory = "/storage/emulated/0/Download/";
      } else {
        directory = "/storage/emulated/0/Downloads/";
      }

      var fileBytes = excel.save();
      if (fileBytes == null) {
        throw ('No se pudo guardar el archivo');
      }

      File(join(
          "$directory/bitacora_${DateFormat('ddMMyyyyhhmm').format(DateTime.now())}.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
      
      //borrar datos
      Database db = sl.get<DBCreator>().database;
      await db.rawDelete('DELETE FROM bitacora');
      await db.rawDelete('DELETE FROM movimientos');
      await db.rawDelete('DELETE FROM llaves WHERE estatus = 0');
      await db.rawDelete('DELETE FROM asociados WHERE estatus = 0');
      
      return Success(true, 'Datos borrados, archivo guardado en descargas');
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<Excel> generateExcel() async {
    Database db = sl.get<DBCreator>().database;
    List<Map<String, dynamic>> asociados =
        await db.rawQuery('''SELECT A.*, D.nombre AS departamento
        FROM asociados AS A
        LEFT JOIN departamentos AS D
        ON A.id_departamento = D.id
        ORDER BY A.id asc
        ''');

    List<Map<String, dynamic>> llaves = await db.rawQuery(
        '''SELECT L.*, A.nombre || ' ' || A.apellido_paterno || ' ' || A.apellido_materno AS asociado
        FROM llaves AS L
        LEFT JOIN asociados AS A
        ON L.asignada_a = A.id
        ORDER BY L.id asc
        ''');

    List<Map<String, dynamic>> bitacora = await db.rawQuery(
        '''SELECT B.*, A.nombre || ' ' || A.apellido_paterno || ' ' || A.apellido_materno AS asociado, L.num_llave
        FROM bitacora AS B
        LEFT JOIN asociados AS A
        ON B.id_asociado = A.id
        LEFT JOIN llaves AS L
        ON B.id_llave = L.id
        ORDER BY B.id asc
        ''');

    List<Map<String, dynamic>> movimientos = await db.rawQuery(
        '''SELECT M.*, A.nombre || ' ' || A.apellido_paterno || ' ' || A.apellido_materno AS asociado, L.num_llave
        FROM movimientos AS M
        LEFT JOIN asociados AS A
        ON M.id_asociado = A.id
        LEFT JOIN llaves AS L
        ON M.id_llave = L.id
        ORDER BY M.id asc
        ''');
    //aqui se exporta la base de datos
    Excel excel = Excel.createExcel();
    //eliminar hojas por defecto
    excel.rename('Sheet1', 'Asociados');
    //agregar hojas de asociados, llaves, bitacoras, cambios de llaves
    Sheet hojaAsociados = excel['Asociados'];
    Sheet hojaLlaves = excel['Llaves'];
    Sheet hojaBitacora = excel['Bitácora'];
    Sheet hojaCambiosLlaves = excel['Cambios de llaves'];
    //estilos
    CellStyle colStyle = CellStyle(
      bold: true,
      fontFamily: getFontFamily(FontFamily.Calibri),
      fontSize: 12,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
      textWrapping: TextWrapping.WrapText,
      underline: Underline.Single,
      backgroundColorHex: ExcelColor.blue200,
      fontColorHex: ExcelColor.white,
    );
    // columnas
    List<TextCellValue> asociadosCols = <TextCellValue>[
      TextCellValue('ID'),
      TextCellValue('# de asociado'),
      TextCellValue('Nombre'),
      TextCellValue('Apellido paterno'),
      TextCellValue('Apellido materno'),
      TextCellValue('Fecha alta'),
      TextCellValue('Fecha baja'),
      TextCellValue('Departamento'),
      TextCellValue('Estatus'),
    ];
    List<TextCellValue> llavesCols = <TextCellValue>[
      TextCellValue('ID'),
      TextCellValue('# de llave'),
      TextCellValue('Descripción'),
      TextCellValue('Fecha alta'),
      TextCellValue('Fecha baja'),
      TextCellValue('Asignada a'),
      TextCellValue('Estatus'),
    ];
    List<TextCellValue> bitacoraCols = <TextCellValue>[
      TextCellValue('ID'),
      TextCellValue('Asociado'),
      TextCellValue('Llave'),
      TextCellValue('Fecha'),
      TextCellValue('Tipo de movimiento'),
      TextCellValue('Estatus'),
      TextCellValue('Fecha de eliminación'),
    ];
    List<TextCellValue> cambiosLlavesCols = <TextCellValue>[
      TextCellValue('ID'),
      TextCellValue('Asociado'),
      TextCellValue('Llave'),
      TextCellValue('Fecha'),
      TextCellValue('Tipo de movimiento'),
    ];
    //agregar columnas a las hojas
    hojaAsociados.appendRow(asociadosCols);
    hojaLlaves.appendRow(llavesCols);
    hojaBitacora.appendRow(bitacoraCols);
    hojaCambiosLlaves.appendRow(cambiosLlavesCols);
    //ajustar columnas
    for (int i = 0; i < asociadosCols.length; i++) {
      hojaAsociados.setColumnAutoFit(i);
    }
    for (int i = 0; i < llavesCols.length; i++) {
      hojaLlaves.setColumnAutoFit(i);
    }
    for (int i = 0; i < bitacoraCols.length; i++) {
      hojaBitacora.setColumnAutoFit(i);
    }
    for (int i = 0; i < cambiosLlavesCols.length; i++) {
      hojaCambiosLlaves.setColumnAutoFit(i);
    }
    //estilos de columnas
    hojaAsociados.row(0).every((cell) {
      cell?.cellStyle = colStyle;
      return true;
    });
    hojaLlaves.row(0).every((cell) {
      cell?.cellStyle = colStyle;
      return true;
    });
    hojaBitacora.row(0).every((cell) {
      cell?.cellStyle = colStyle;
      return true;
    });
    hojaCambiosLlaves.row(0).every((cell) {
      cell?.cellStyle = colStyle;
      return true;
    });
    //agregar datos
    //asociados
    for (int i = 0; i < asociados.length; i++) {
      List<CellValue> row = [
        IntCellValue(asociados[i]['id']),
        IntCellValue(int.parse(asociados[i]['num_asociado'])),
        TextCellValue(asociados[i]['nombre']),
        TextCellValue(asociados[i]['apellido_paterno']),
        TextCellValue(asociados[i]['apellido_materno']),
        DateTimeCellValue(
            year: DateTime.parse(asociados[i]['fecha_alta']).year,
            month: DateTime.parse(asociados[i]['fecha_alta']).month,
            day: DateTime.parse(asociados[i]['fecha_alta']).day,
            hour: DateTime.parse(asociados[i]['fecha_alta']).hour,
            minute: DateTime.parse(asociados[i]['fecha_alta']).minute),
        asociados[i]['fecha_baja'] != null
            ? DateTimeCellValue(
                year: DateTime.parse(asociados[i]['fecha_baja']).year,
                month: DateTime.parse(asociados[i]['fecha_baja']).month,
                day: DateTime.parse(asociados[i]['fecha_baja']).day,
                hour: DateTime.parse(asociados[i]['fecha_baja']).hour,
                minute: DateTime.parse(asociados[i]['fecha_baja']).minute)
            : TextCellValue(''),
        TextCellValue(asociados[i]['departamento']),
        TextCellValue(asociados[i]['estatus'] == 0 ? 'Eliminado' : 'Activo'),
      ];
      hojaAsociados.appendRow(row);
    }
    //llaves
    for (int i = 0; i < llaves.length; i++) {
      List<CellValue> row = [
        IntCellValue(llaves[i]['id']),
        IntCellValue(int.parse(llaves[i]['num_llave'])),
        TextCellValue(llaves[i]['descripcion']),
        DateTimeCellValue(
            year: DateTime.parse(llaves[i]['fecha_alta']).year,
            month: DateTime.parse(llaves[i]['fecha_alta']).month,
            day: DateTime.parse(llaves[i]['fecha_alta']).day,
            hour: DateTime.parse(llaves[i]['fecha_alta']).hour,
            minute: DateTime.parse(llaves[i]['fecha_alta']).minute),
        llaves[i]['fecha_baja'] != null
            ? DateTimeCellValue(
                year: DateTime.parse(llaves[i]['fecha_baja']).year,
                month: DateTime.parse(llaves[i]['fecha_baja']).month,
                day: DateTime.parse(llaves[i]['fecha_baja']).day,
                hour: DateTime.parse(llaves[i]['fecha_baja']).hour,
                minute: DateTime.parse(llaves[i]['fecha_baja']).minute)
            : TextCellValue(''),
        TextCellValue(llaves[i]['asociado'] ?? 'Sin asignar'),
        TextCellValue(llaves[i]['estatus'] == 0 ? 'Eliminada' : 'Activa'),
      ];
      hojaLlaves.appendRow(row);
    }
    //bitacora
    for (int i = 0; i < bitacora.length; i++) {
      List<CellValue> row = [
        IntCellValue(bitacora[i]['id']),
        TextCellValue(bitacora[i]['asociado']),
        TextCellValue(bitacora[i]['num_llave']),
        DateTimeCellValue(
            year: DateTime.parse(bitacora[i]['fecha']).year,
            month: DateTime.parse(bitacora[i]['fecha']).month,
            day: DateTime.parse(bitacora[i]['fecha']).day,
            hour: DateTime.parse(bitacora[i]['fecha']).hour,
            minute: DateTime.parse(bitacora[i]['fecha']).minute),
        TextCellValue(bitacora[i]['movimiento']),
        TextCellValue(bitacora[i]['estatus'] == 0 ? 'Eliminado' : 'Activo'),
        bitacora[i]['fecha_eliminado'] != null
            ? DateTimeCellValue(
                year: DateTime.parse(bitacora[i]['fecha_eliminado']).year,
                month: DateTime.parse(bitacora[i]['fecha_eliminado']).month,
                day: DateTime.parse(bitacora[i]['fecha_eliminado']).day,
                hour: DateTime.parse(bitacora[i]['fecha_eliminado']).hour,
                minute: DateTime.parse(bitacora[i]['fecha_eliminado']).minute)
            : TextCellValue(''),
      ];
      hojaBitacora.appendRow(row);
    }
    //movimientos
    for (int i = 0; i < movimientos.length; i++) {
      List<CellValue> row = [
        IntCellValue(movimientos[i]['id']),
        TextCellValue(movimientos[i]['asociado']),
        TextCellValue(movimientos[i]['num_llave']),
        DateTimeCellValue(
            year: DateTime.parse(movimientos[i]['fecha']).year,
            month: DateTime.parse(movimientos[i]['fecha']).month,
            day: DateTime.parse(movimientos[i]['fecha']).day,
            hour: DateTime.parse(movimientos[i]['fecha']).hour,
            minute: DateTime.parse(movimientos[i]['fecha']).minute),
        TextCellValue(movimientos[i]['movimiento']),
      ];
      hojaCambiosLlaves.appendRow(row);
    }
    return excel;
  }
}
