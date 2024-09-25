class Tarea {
  final int? id;
  final String? titulo;
  final int? estado;

  Tarea({
    this.id,
    required this.titulo,
    this.estado,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'estado': estado
    };
  }
}
