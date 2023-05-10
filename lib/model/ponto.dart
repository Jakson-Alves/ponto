import 'package:intl/intl.dart';

class Ponto {
  static const nomeTabela = 'ponto';
  static const campoId = '_id';
  static const campoLocal = 'local';
  static const campoHora = 'hora';
  static const campoFinalizada = 'finalizada';

  int? id;
  late String local;
  DateTime? hora;
  bool finalizada;

  Ponto({
    this.id,
    required this.local,
    this.hora,
    this.finalizada = false,
  });

  String get prazoFormatado {
    if (hora == null) {
      return '';
    }
    return DateFormat('dd/MM/yyyy').format(hora!);
  }

  Map<String, dynamic> toMap() => {
    campoId: id,
    campoLocal: local,
    campoHora:
    hora == null ? null : DateFormat("yyyy-MM-dd").format(hora!),
    campoFinalizada: finalizada ? 1 : 0,
  };

  factory Ponto.fromMap(Map<String, dynamic> map) => Ponto(
    id: map[campoId] is int ? map[campoId] : null,
    local: map[campoLocal] is String ? map[campoLocal] : '',
    hora: map[campoHora] is String
        ? DateFormat("yyyy-MM-dd").parse(map[campoHora])
        : null,
    finalizada: map[campoFinalizada] == 1,
  );
}