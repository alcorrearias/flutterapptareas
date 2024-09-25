import 'package:flutter/material.dart';
import 'package:apptareas_flutter_crud/data/models/tarea_models.dart';
import 'package:apptareas_flutter_crud/presentation/widget/action_button.dart';
import 'package:apptareas_flutter_crud/presentation/widget/init_tarea_form.dart';
import 'custom_text_field.dart';

//Add Tarea + Edit Tarea call from Tarea_ui
class ShowModalTarea extends StatefulWidget {
  final void Function(String, int) onAdd;
  final bool isEditMode;
  final Tarea? editedTarea;

  const ShowModalTarea({
    super.key,
    required this.onAdd,
    this.isEditMode = false,
    this.editedTarea,
  });

  @override
  ShowModalTareaState createState() => ShowModalTareaState();
}

class ShowModalTareaState extends State<ShowModalTarea> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeTareaForm(
      isEditMode: widget.isEditMode,
      editedTarea: widget.editedTarea,
      tituloController: tituloController,
      estadoController: estadoController,
      idController: idController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estadoText = estadoController.toString() == '0' ? 'Pendiente' : 'Completada';
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [       
        CustomTextField(
          label: 'Titulo',
          controller: tituloController,
        ),
        CustomTextField(
          label: 'Estado',
          controller: estadoController,          
        ),
        const SizedBox(height: 16),
        ActionButtons(
          onAdd: () {
            widget.onAdd(
              tituloController.text,              
              int.parse(estadoController.text),
            );
            Navigator.pop(context);
          },
          isEditMode: widget.isEditMode,
        ),
      ],
    );
  }
}
