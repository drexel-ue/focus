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
import 'routine_record_status.dart' as _i2;

/// A record of a [User] interaction with a [Routine].
abstract class RoutineRecord
    implements _i1.TableRow, _i1.ProtocolSerialization {
  RoutineRecord._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.routineId,
    _i2.RoutineRecordStatus? status,
  }) : status = status ?? _i2.RoutineRecordStatus.running;

  factory RoutineRecord({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required int routineId,
    _i2.RoutineRecordStatus? status,
  }) = _RoutineRecordImpl;

  factory RoutineRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineRecord(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      userId: jsonSerialization['userId'] as int,
      routineId: jsonSerialization['routineId'] as int,
      status: _i2.RoutineRecordStatus.fromJson(
          (jsonSerialization['status'] as String)),
    );
  }

  static final t = RoutineRecordTable();

  static const db = RoutineRecordRepository._();

  @override
  int? id;

  /// Timestamp of model creation.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Id of the [User] that created this task.
  int userId;

  /// Id of the [Routine] this record is tracking.
  int routineId;

  /// Status.
  _i2.RoutineRecordStatus status;

  @override
  _i1.Table get table => t;

  RoutineRecord copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    int? routineId,
    _i2.RoutineRecordStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'routineId': routineId,
      'status': status.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'routineId': routineId,
      'status': status.toJson(),
    };
  }

  static RoutineRecordInclude include() {
    return RoutineRecordInclude._();
  }

  static RoutineRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<RoutineRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineRecordTable>? orderByList,
    RoutineRecordInclude? include,
  }) {
    return RoutineRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoutineRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoutineRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineRecordImpl extends RoutineRecord {
  _RoutineRecordImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required int routineId,
    _i2.RoutineRecordStatus? status,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          routineId: routineId,
          status: status,
        );

  @override
  RoutineRecord copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    int? routineId,
    _i2.RoutineRecordStatus? status,
  }) {
    return RoutineRecord(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      routineId: routineId ?? this.routineId,
      status: status ?? this.status,
    );
  }
}

class RoutineRecordTable extends _i1.Table {
  RoutineRecordTable({super.tableRelation})
      : super(tableName: 'routine_records') {
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
    routineId = _i1.ColumnInt(
      'routineId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
  }

  /// Timestamp of model creation.
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp of last update to database entry.
  late final _i1.ColumnDateTime lastModifiedAt;

  /// Id of the [User] that created this task.
  late final _i1.ColumnInt userId;

  /// Id of the [Routine] this record is tracking.
  late final _i1.ColumnInt routineId;

  /// Status.
  late final _i1.ColumnEnum<_i2.RoutineRecordStatus> status;

  @override
  List<_i1.Column> get columns => [
        id,
        createdAt,
        lastModifiedAt,
        userId,
        routineId,
        status,
      ];
}

class RoutineRecordInclude extends _i1.IncludeObject {
  RoutineRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => RoutineRecord.t;
}

class RoutineRecordIncludeList extends _i1.IncludeList {
  RoutineRecordIncludeList._({
    _i1.WhereExpressionBuilder<RoutineRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoutineRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoutineRecord.t;
}

class RoutineRecordRepository {
  const RoutineRecordRepository._();

  Future<List<RoutineRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RoutineRecord>(
      where: where?.call(RoutineRecord.t),
      orderBy: orderBy?.call(RoutineRecord.t),
      orderByList: orderByList?.call(RoutineRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RoutineRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoutineRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<RoutineRecord>(
      where: where?.call(RoutineRecord.t),
      orderBy: orderBy?.call(RoutineRecord.t),
      orderByList: orderByList?.call(RoutineRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RoutineRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<RoutineRecord>(
      id,
      transaction: transaction,
    );
  }

  Future<List<RoutineRecord>> insert(
    _i1.Session session,
    List<RoutineRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RoutineRecord>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineRecord> insertRow(
    _i1.Session session,
    RoutineRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoutineRecord>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineRecord>> update(
    _i1.Session session,
    List<RoutineRecord> rows, {
    _i1.ColumnSelections<RoutineRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoutineRecord>(
      rows,
      columns: columns?.call(RoutineRecord.t),
      transaction: transaction,
    );
  }

  Future<RoutineRecord> updateRow(
    _i1.Session session,
    RoutineRecord row, {
    _i1.ColumnSelections<RoutineRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoutineRecord>(
      row,
      columns: columns?.call(RoutineRecord.t),
      transaction: transaction,
    );
  }

  Future<List<RoutineRecord>> delete(
    _i1.Session session,
    List<RoutineRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoutineRecord>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineRecord> deleteRow(
    _i1.Session session,
    RoutineRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoutineRecord>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoutineRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoutineRecord>(
      where: where(RoutineRecord.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoutineRecord>(
      where: where?.call(RoutineRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
