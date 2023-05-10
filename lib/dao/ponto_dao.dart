import '../database/database_provider.dart';
import '../model/ponto.dart';

class PontoDao {
  final databaseProvider = DatabaseProvider.instance;

  Future<bool> salvar(Ponto ponto) async {
    final database = await databaseProvider.database;
    final valores = ponto.toMap();
    if (ponto.id == null) {
      ponto.id = await database.insert(Ponto.nomeTabela, valores);
      return true;
    } else {
      final registrosAtualizados = await database.update(
        Ponto.nomeTabela,
        valores,
        where: '${Ponto.campoId} = ?',
        whereArgs: [ponto.id],
      );
      return registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final database = await databaseProvider.database;
    final registrosAtualizados = await database.delete(
      Ponto.nomeTabela,
      where: '${Ponto.campoId} = ?',
      whereArgs: [id],
    );
    return registrosAtualizados > 0;
  }

  Future<List<Ponto>> listar({
    String filtro = '',
    String campoOrdenacao = Ponto.campoId,
    bool usarOrdemDecrescente = false,
  }) async {
    String? where;
    if (filtro.isNotEmpty) {
      where = "UPPER(${Ponto.campoLocal}) LIKE '${filtro.toUpperCase()}%'";
    }
    var orderBy = campoOrdenacao;
    if (usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final database = await databaseProvider.database;
    final resultado = await database.query(
      Ponto.nomeTabela,
      columns: [
        Ponto.campoId,
        Ponto.campoLocal,
        Ponto.campoHora,
        Ponto.campoFinalizada
      ],
      where: where,
      orderBy: orderBy,
    );
    return resultado.map((m) => Ponto.fromMap(m)).toList();
  }
}