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
import 'routine_segment.dart' as _i3;

/// Repeatable sequence of [Step]s.
abstract class Routine implements _i1.TableRow, _i1.ProtocolSerialization {
  Routine._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.title,
    required this.active,
    this.steps,
    this.segments,
  });

  factory Routine({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required int userId,
    required String title,
    required bool active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
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
      active: jsonSerialization['active'] as bool,
      steps: (jsonSerialization['steps'] as List?)
          ?.map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
          .toList(),
      segments: (jsonSerialization['segments'] as List?)
          ?.map((e) => _i3.RoutineSegment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = RoutineTable();

  static const db = RoutineRepository._();

  @override
  int? id;

  /// Timestamp of entry into database.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Id of [User] that created this routine.
  int userId;

  /// Title.
  String title;

  /// Is this routine active?
  bool active;

  /// [Step]s of this routine.
  List<_i2.RoutineStep>? steps;

  /// Collection of steps.
  List<_i3.RoutineSegment>? segments;

  @override
  _i1.Table get table => t;

  Routine copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    bool? active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'userId': userId,
      'title': title,
      'active': active,
      if (steps != null) 'steps': steps?.toJson(valueToJson: (v) => v.toJson()),
      if (segments != null)
        'segments': segments?.toJson(valueToJson: (v) => v.toJson()),
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
      'active': active,
      if (steps != null)
        'steps': steps?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (segments != null)
        'segments': segments?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static RoutineInclude include({
    _i2.RoutineStepIncludeList? steps,
    _i3.RoutineSegmentIncludeList? segments,
  }) {
    return RoutineInclude._(
      steps: steps,
      segments: segments,
    );
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
    required bool active,
    List<_i2.RoutineStep>? steps,
    List<_i3.RoutineSegment>? segments,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          userId: userId,
          title: title,
          active: active,
          steps: steps,
          segments: segments,
        );

  @override
  Routine copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    int? userId,
    String? title,
    bool? active,
    Object? steps = _Undefined,
    Object? segments = _Undefined,
  }) {
    return Routine(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      active: active ?? this.active,
      steps: steps is List<_i2.RoutineStep>?
          ? steps
          : this.steps?.map((e0) => e0.copyWith()).toList(),
      segments: segments is List<_i3.RoutineSegment>?
          ? segments
          : this.segments?.map((e0) => e0.copyWith()).toList(),
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
    active = _i1.ColumnBool(
      'active',
      this,
    );
  }

  /// Timestamp of entry into database.
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp of last update to database entry.
  late final _i1.ColumnDateTime lastModifiedAt;

  /// Id of [User] that created this routine.
  late final _i1.ColumnInt userId;

  /// Title.
  late final _i1.ColumnString title;

  /// Is this routine active?
  late final _i1.ColumnBool active;

  /// [Step]s of this routine.
  _i2.RoutineStepTable? ___steps;

  /// [Step]s of this routine.
  _i1.ManyRelation<_i2.RoutineStepTable>? _steps;

  /// Collection of steps.
  _i3.RoutineSegmentTable? ___segments;

  /// Collection of steps.
  _i1.ManyRelation<_i3.RoutineSegmentTable>? _segments;

  _i2.RoutineStepTable get __steps {
    if (___steps != null) return ___steps!;
    ___steps = _i1.createRelationTable(
      relationFieldName: '__steps',
      field: Routine.t.id,
      foreignField: _i2.RoutineStep.t.$_routinesStepsRoutinesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoutineStepTable(tableRelation: foreignTableRelation),
    );
    return ___steps!;
  }

  _i3.RoutineSegmentTable get __segments {
    if (___segments != null) return ___segments!;
    ___segments = _i1.createRelationTable(
      relationFieldName: '__segments',
      field: Routine.t.id,
      foreignField: _i3.RoutineSegment.t.$_routinesSegmentsRoutinesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RoutineSegmentTable(tableRelation: foreignTableRelation),
    );
    return ___segments!;
  }

  _i1.ManyRelation<_i2.RoutineStepTable> get steps {
    if (_steps != null) return _steps!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'steps',
      field: Routine.t.id,
      foreignField: _i2.RoutineStep.t.$_routinesStepsRoutinesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoutineStepTable(tableRelation: foreignTableRelation),
    );
    _steps = _i1.ManyRelation<_i2.RoutineStepTable>(
      tableWithRelations: relationTable,
      table: _i2.RoutineStepTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _steps!;
  }

  _i1.ManyRelation<_i3.RoutineSegmentTable> get segments {
    if (_segments != null) return _segments!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'segments',
      field: Routine.t.id,
      foreignField: _i3.RoutineSegment.t.$_routinesSegmentsRoutinesId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RoutineSegmentTable(tableRelation: foreignTableRelation),
    );
    _segments = _i1.ManyRelation<_i3.RoutineSegmentTable>(
      tableWithRelations: relationTable,
      table: _i3.RoutineSegmentTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _segments!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        createdAt,
        lastModifiedAt,
        userId,
        title,
        active,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'steps') {
      return __steps;
    }
    if (relationField == 'segments') {
      return __segments;
    }
    return null;
  }
}

class RoutineInclude extends _i1.IncludeObject {
  RoutineInclude._({
    _i2.RoutineStepIncludeList? steps,
    _i3.RoutineSegmentIncludeList? segments,
  }) {
    _steps = steps;
    _segments = segments;
  }

  _i2.RoutineStepIncludeList? _steps;

  _i3.RoutineSegmentIncludeList? _segments;

  @override
  Map<String, _i1.Include?> get includes => {
        'steps': _steps,
        'segments': _segments,
      };

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

  final attach = const RoutineAttachRepository._();

  final attachRow = const RoutineAttachRowRepository._();

  final detach = const RoutineDetachRepository._();

  final detachRow = const RoutineDetachRowRepository._();

  Future<List<Routine>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineTable>? orderByList,
    _i1.Transaction? transaction,
    RoutineInclude? include,
  }) async {
    return session.db.find<Routine>(
      where: where?.call(Routine.t),
      orderBy: orderBy?.call(Routine.t),
      orderByList: orderByList?.call(Routine.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    RoutineInclude? include,
  }) async {
    return session.db.findFirstRow<Routine>(
      where: where?.call(Routine.t),
      orderBy: orderBy?.call(Routine.t),
      orderByList: orderByList?.call(Routine.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Routine?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoutineInclude? include,
  }) async {
    return session.db.findById<Routine>(
      id,
      transaction: transaction,
      include: include,
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

class RoutineAttachRepository {
  const RoutineAttachRepository._();

  Future<void> steps(
    _i1.Session session,
    Routine routine,
    List<_i2.RoutineStep> routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.any((e) => e.id == null)) {
      throw ArgumentError.notNull('routineStep.id');
    }
    if (routine.id == null) {
      throw ArgumentError.notNull('routine.id');
    }

    var $routineStep = routineStep
        .map((e) => _i2.RoutineStepImplicit(
              e,
              $_routinesStepsRoutinesId: routine.id,
            ))
        .toList();
    await session.db.update<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routinesStepsRoutinesId],
      transaction: transaction,
    );
  }

  Future<void> segments(
    _i1.Session session,
    Routine routine,
    List<_i3.RoutineSegment> routineSegment, {
    _i1.Transaction? transaction,
  }) async {
    if (routineSegment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('routineSegment.id');
    }
    if (routine.id == null) {
      throw ArgumentError.notNull('routine.id');
    }

    var $routineSegment = routineSegment
        .map((e) => _i3.RoutineSegmentImplicit(
              e,
              $_routinesSegmentsRoutinesId: routine.id,
            ))
        .toList();
    await session.db.update<_i3.RoutineSegment>(
      $routineSegment,
      columns: [_i3.RoutineSegment.t.$_routinesSegmentsRoutinesId],
      transaction: transaction,
    );
  }
}

class RoutineAttachRowRepository {
  const RoutineAttachRowRepository._();

  Future<void> steps(
    _i1.Session session,
    Routine routine,
    _i2.RoutineStep routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.id == null) {
      throw ArgumentError.notNull('routineStep.id');
    }
    if (routine.id == null) {
      throw ArgumentError.notNull('routine.id');
    }

    var $routineStep = _i2.RoutineStepImplicit(
      routineStep,
      $_routinesStepsRoutinesId: routine.id,
    );
    await session.db.updateRow<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routinesStepsRoutinesId],
      transaction: transaction,
    );
  }

  Future<void> segments(
    _i1.Session session,
    Routine routine,
    _i3.RoutineSegment routineSegment, {
    _i1.Transaction? transaction,
  }) async {
    if (routineSegment.id == null) {
      throw ArgumentError.notNull('routineSegment.id');
    }
    if (routine.id == null) {
      throw ArgumentError.notNull('routine.id');
    }

    var $routineSegment = _i3.RoutineSegmentImplicit(
      routineSegment,
      $_routinesSegmentsRoutinesId: routine.id,
    );
    await session.db.updateRow<_i3.RoutineSegment>(
      $routineSegment,
      columns: [_i3.RoutineSegment.t.$_routinesSegmentsRoutinesId],
      transaction: transaction,
    );
  }
}

class RoutineDetachRepository {
  const RoutineDetachRepository._();

  Future<void> steps(
    _i1.Session session,
    List<_i2.RoutineStep> routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.any((e) => e.id == null)) {
      throw ArgumentError.notNull('routineStep.id');
    }

    var $routineStep = routineStep
        .map((e) => _i2.RoutineStepImplicit(
              e,
              $_routinesStepsRoutinesId: null,
            ))
        .toList();
    await session.db.update<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routinesStepsRoutinesId],
      transaction: transaction,
    );
  }

  Future<void> segments(
    _i1.Session session,
    List<_i3.RoutineSegment> routineSegment, {
    _i1.Transaction? transaction,
  }) async {
    if (routineSegment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('routineSegment.id');
    }

    var $routineSegment = routineSegment
        .map((e) => _i3.RoutineSegmentImplicit(
              e,
              $_routinesSegmentsRoutinesId: null,
            ))
        .toList();
    await session.db.update<_i3.RoutineSegment>(
      $routineSegment,
      columns: [_i3.RoutineSegment.t.$_routinesSegmentsRoutinesId],
      transaction: transaction,
    );
  }
}

class RoutineDetachRowRepository {
  const RoutineDetachRowRepository._();

  Future<void> steps(
    _i1.Session session,
    _i2.RoutineStep routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.id == null) {
      throw ArgumentError.notNull('routineStep.id');
    }

    var $routineStep = _i2.RoutineStepImplicit(
      routineStep,
      $_routinesStepsRoutinesId: null,
    );
    await session.db.updateRow<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routinesStepsRoutinesId],
      transaction: transaction,
    );
  }

  Future<void> segments(
    _i1.Session session,
    _i3.RoutineSegment routineSegment, {
    _i1.Transaction? transaction,
  }) async {
    if (routineSegment.id == null) {
      throw ArgumentError.notNull('routineSegment.id');
    }

    var $routineSegment = _i3.RoutineSegmentImplicit(
      routineSegment,
      $_routinesSegmentsRoutinesId: null,
    );
    await session.db.updateRow<_i3.RoutineSegment>(
      $routineSegment,
      columns: [_i3.RoutineSegment.t.$_routinesSegmentsRoutinesId],
      transaction: transaction,
    );
  }
}
