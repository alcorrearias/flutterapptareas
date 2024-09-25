import 'package:flutter/material.dart';
import 'package:apptareas_flutter_crud/data/models/tarea_models.dart';

//Load initState in show modal product for edit product
void initializeTareaForm({
  required bool isEditMode,
  Tarea? editedTarea,
  required TextEditingController tituloController,
  required TextEditingController estadoController,
  required TextEditingController idController,
}) {
  if (isEditMode && editedTarea != null) {
    tituloController.text = editedTarea.titulo.toString();
    estadoController.text = editedTarea.estado.toString();
    idController.text = editedTarea.id.toString();
  }
}
