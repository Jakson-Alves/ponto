import 'package:intl/intl.dart';

class Ponto {
  static const nomeTabela = 'ponto';
  static const campoId = '_id';
  static const campoLatitude = 'latitude';
  static const campoLongitude = 'longitude';
  static const campoData = 'data';

  int? id;
  String? latitude;
  String? longitude;
  String? data;

  Ponto({
    this.id,
    this.latitude,
    this.longitude,
    this.data,
  });

  Map<String, dynamic> toMap() => {
    campoId: id == 0 ? null : id,
    campoLatitude: latitude,
    campoLongitude: longitude,
    campoData:
    data == null ? null : data!,
  };

  factory Ponto.fromMap(Map<String, dynamic> map) => Ponto(
    id: map[campoId] is int ? map[campoId] : null,
    latitude: map[campoLatitude] is String ? map[campoLatitude] : '',
    longitude: map[campoLongitude] is String ? map[campoLongitude] : '',
    data: map[campoData] is String ? map[campoData] : null,
  );
}