import 'package:isar_community/isar.dart';
import 'package:lab_house/modules/ranking/model/ranking.dto.m.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalService {
  Future<int> save<T>(T object);

  Future<List<T>> getAll<T>();

  Future<void> delete<T>(int id);

  Future<void> clear<T>();
}

final class LocalServiceDefault implements LocalService {
  // MARK: - Properties

  final Isar _isar;

  // MARK: - Lifecycle

  LocalServiceDefault._(this._isar);

  static Future<LocalServiceDefault> init() async {
    final directory = await getApplicationDocumentsDirectory();

    final isar = await Isar.open([RankingDTOSchema], directory: directory.path);

    return LocalServiceDefault._(isar);
  }

  // MARK: - Public Methods

  @override
  Future<int> save<T>(T object) =>
      _isar.writeTxn(() => _isar.collection<T>().put(object));

  @override
  Future<List<T>> getAll<T>() => _isar.collection<T>().where().findAll();

  @override
  Future<void> delete<T>(int id) =>
      _isar.writeTxn(() => _isar.collection<T>().delete(id));

  @override
  Future<void> clear<T>() =>
      _isar.writeTxn(() => _isar.collection<T>().clear());
}
