/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'routine_step.dart' as _i2;
import 'user_buff.dart' as _i3;
import 'user_debuff.dart' as _i4;

/// A repeatable series of steps.
abstract class Routine implements _i1.TableRow, _i1.ProtocolSerialization {
  Routine._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.title,
    required this.steps,
    required this.buffs,
    required this.debuffs,
  });

  factory Routine({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required List<_i2.RoutineStep> steps,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
  }) = _RoutineImpl;

  factory Routine.fromJson(Map<String, dynamic> jsonSerialization) {
    return Routine(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      steps: (jsonSerialization['steps'] as List)
          .map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
          .toList(),
      buffs: (jsonSerialization['buffs'] as List)
          .map((e) => _i3.UserBuff.fromJson((e as int)))
          .toList(),
      debuffs: (jsonSerialization['debuffs'] as List)
          .map((e) => _i4.UserDebuff.fromJson((e as int)))
          .toList(),
    );
  }

  static final t = RoutineTable();

  static const db = RoutineRepository._();

  @override
  int? id;

  /// Timestamp of model creation.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Id of the [User] that created this task.
  int userId;

  /// Title.
  String title;

  /// [RoutineStep]s to complete.
  List<_i2.RoutineStep> steps;

  /// [UserBuff]s awarded upon completion of this routine.
  List<_i3.UserBuff> buffs;

  /// [UserDebuff]s to apply upon failure to complete this routine within 24 hours of starting it.
  List<_i4.UserDebuff> debuffs;

  @override
  _i1.Table get table => t;

  Routine copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    List<_i2.RoutineStep>? steps,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'title': title,
      'steps': steps.toJson(valueToJson: (v) => v.toJson()),
      'buffs': buffs.toJson(valueToJson: (v) => v.toJson()),
      'debuffs': debuffs.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'title': title,
      'steps': steps.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'buffs': buffs.toJson(valueToJson: (v) => v.toJson()),
      'debuffs': debuffs.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  static RoutineInclude include() {
    return RoutineInclude._();
  }

  static RoutineIncludeList includeList({
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineTable>? orderByList,
    RoutineInclude? include,
  }) {
    return RoutineIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Routine.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Routine.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineImpl extends Routine {
  _RoutineImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required List<_i2.RoutineStep> steps,
    required List<_i3.UserBuff> buffs,
    required List<_i4.UserDebuff> debuffs,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          title: title,
          steps: steps,
          buffs: buffs,
          debuffs: debuffs,
        );

  @override
  Routine copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    List<_i2.RoutineStep>? steps,
    List<_i3.UserBuff>? buffs,
    List<_i4.UserDebuff>? debuffs,
  }) {
    return Routine(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      steps: steps ?? this.steps.map((e0) => e0.copyWith()).toList(),
      buffs: buffs ?? this.buffs.map((e0) => e0).toList(),
      debuffs: debuffs ?? this.debuffs.map((e0) => e0).toList(),
    );
  }
}

class RoutineTable extends _i1.Table {
  RoutineTable({super.tableRelation}) : super(tableName: 'routines') {
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    lastModifiedAt = _i1.ColumnDateTime(
      'lastModifiedAt',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    steps = _i1.ColumnSerializable(
      'steps',
      this,
    );
    buffs = _i1.ColumnSerializable(
      'buffs',
      this,
    );
    debuffs = _i1.ColumnSerializable(
      'debuffs',
      this,
    );
  }

  /// Timestamp of model creation.
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp of last update to database entry.
  late final _i1.ColumnDateTime lastModifiedAt;

  /// Id of the [User] that created this task.
  late final _i1.ColumnInt userId;

  /// Title.
  late final _i1.ColumnString title;

  /// [RoutineStep]s to complete.
  late final _i1.ColumnSerializable steps;

  /// [UserBuff]s awarded upon completion of this routine.
  late final _i1.ColumnSerializable buffs;

  /// [UserDebuff]s to apply upon failure to complete this routine within 24 hours of starting it.
  late final _i1.ColumnSerializable debuffs;

  @override
  List<_i1.Column> get columns => [
        id,
        createdAt,
        lastModifiedAt,
        userId,
        title,
        steps,
        buffs,
        debuffs,
      ];
}

class RoutineInclude extends _i1.IncludeObject {
  RoutineInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Routine.t;
}

class RoutineIncludeList extends _i1.IncludeList {
  RoutineIncludeList._({
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Routine.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Routine.t;
}

class RoutineRepository {
  const RoutineRepository._();

  Future<List<Routine>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Routine>(
      where: where?.call(Routine.t),
      orderBy: orderBy?.call(Routine.t),
      orderByList: orderByList?.call(Routine.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Routine?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoutineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Routine>(
      where: where?.call(Routine.t),
      orderBy: orderBy?.call(Routine.t),
      orderByList: orderByList?.call(Routine.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Routine?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Routine>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Routine>> insert(
    _i1.Session session,
    List<Routine> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Routine>(
      rows,
      transaction: transaction,
    );
  }

  Future<Routine> insertRow(
    _i1.Session session,
    Routine row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Routine>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Routine>> update(
    _i1.Session session,
    List<Routine> rows, {
    _i1.ColumnSelections<RoutineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Routine>(
      rows,
      columns: columns?.call(Routine.t),
      transaction: transaction,
    );
  }

  Future<Routine> updateRow(
    _i1.Session session,
    Routine row, {
    _i1.ColumnSelections<RoutineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Routine>(
      row,
      columns: columns?.call(Routine.t),
      transaction: transaction,
    );
  }

  Future<List<Routine>> delete(
    _i1.Session session,
    List<Routine> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Routine>(
      rows,
      transaction: transaction,
    );
  }

  Future<Routine> deleteRow(
    _i1.Session session,
    Routine row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Routine>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Routine>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoutineTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Routine>(
      where: where(Routine.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Routine>(
      where: where?.call(Routine.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
