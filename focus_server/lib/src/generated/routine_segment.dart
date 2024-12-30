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

/// A collection of [Step]s in a [Routine].
abstract class RoutineSegment
    implements _i1.TableRow, _i1.ProtocolSerialization {
  RoutineSegment._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.title,
    this.steps,
  });

  factory RoutineSegment({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    List<_i2.RoutineStep>? steps,
  }) = _RoutineSegmentImpl;

  factory RoutineSegment.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineSegment(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      title: jsonSerialization['title'] as String,
      steps: (jsonSerialization['steps'] as List?)
          ?.map((e) => _i2.RoutineStep.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = RoutineSegmentTable();

  static const db = RoutineSegmentRepository._();

  @override
  int? id;

  /// Timestamp of entry into database.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Title.
  String title;

  /// [Step]s of this segment.
  List<_i2.RoutineStep>? steps;

  int? _routinesSegmentsRoutinesId;

  @override
  _i1.Table get table => t;

  RoutineSegment copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    List<_i2.RoutineStep>? steps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (steps != null) 'steps': steps?.toJson(valueToJson: (v) => v.toJson()),
      if (_routinesSegmentsRoutinesId != null)
        '_routinesSegmentsRoutinesId': _routinesSegmentsRoutinesId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (steps != null)
        'steps': steps?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static RoutineSegmentInclude include({_i2.RoutineStepIncludeList? steps}) {
    return RoutineSegmentInclude._(steps: steps);
  }

  static RoutineSegmentIncludeList includeList({
    _i1.WhereExpressionBuilder<RoutineSegmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineSegmentTable>? orderByList,
    RoutineSegmentInclude? include,
  }) {
    return RoutineSegmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoutineSegment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoutineSegment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineSegmentImpl extends RoutineSegment {
  _RoutineSegmentImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    List<_i2.RoutineStep>? steps,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          steps: steps,
        );

  @override
  RoutineSegment copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    Object? steps = _Undefined,
  }) {
    return RoutineSegment(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      title: title ?? this.title,
      steps: steps is List<_i2.RoutineStep>?
          ? steps
          : this.steps?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class RoutineSegmentImplicit extends _RoutineSegmentImpl {
  RoutineSegmentImplicit._({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    List<_i2.RoutineStep>? steps,
    this.$_routinesSegmentsRoutinesId,
  }) : super(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          steps: steps,
        );

  factory RoutineSegmentImplicit(
    RoutineSegment routineSegment, {
    int? $_routinesSegmentsRoutinesId,
  }) {
    return RoutineSegmentImplicit._(
      id: routineSegment.id,
      createdAt: routineSegment.createdAt,
      lastModifiedAt: routineSegment.lastModifiedAt,
      title: routineSegment.title,
      steps: routineSegment.steps,
      $_routinesSegmentsRoutinesId: $_routinesSegmentsRoutinesId,
    );
  }

  int? $_routinesSegmentsRoutinesId;

  @override
  Map<String, dynamic> toJson() {
    var jsonMap = super.toJson();
    jsonMap
        .addAll({'_routinesSegmentsRoutinesId': $_routinesSegmentsRoutinesId});
    return jsonMap;
  }
}

class RoutineSegmentTable extends _i1.Table {
  RoutineSegmentTable({super.tableRelation})
      : super(tableName: 'routine_segments') {
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    lastModifiedAt = _i1.ColumnDateTime(
      'lastModifiedAt',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    $_routinesSegmentsRoutinesId = _i1.ColumnInt(
      '_routinesSegmentsRoutinesId',
      this,
    );
  }

  /// Timestamp of entry into database.
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp of last update to database entry.
  late final _i1.ColumnDateTime lastModifiedAt;

  /// Title.
  late final _i1.ColumnString title;

  /// [Step]s of this segment.
  _i2.RoutineStepTable? ___steps;

  /// [Step]s of this segment.
  _i1.ManyRelation<_i2.RoutineStepTable>? _steps;

  late final _i1.ColumnInt $_routinesSegmentsRoutinesId;

  _i2.RoutineStepTable get __steps {
    if (___steps != null) return ___steps!;
    ___steps = _i1.createRelationTable(
      relationFieldName: '__steps',
      field: RoutineSegment.t.id,
      foreignField: _i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RoutineStepTable(tableRelation: foreignTableRelation),
    );
    return ___steps!;
  }

  _i1.ManyRelation<_i2.RoutineStepTable> get steps {
    if (_steps != null) return _steps!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'steps',
      field: RoutineSegment.t.id,
      foreignField: _i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId,
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

  @override
  List<_i1.Column> get columns => [
        id,
        createdAt,
        lastModifiedAt,
        title,
        $_routinesSegmentsRoutinesId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'steps') {
      return __steps;
    }
    return null;
  }
}

class RoutineSegmentInclude extends _i1.IncludeObject {
  RoutineSegmentInclude._({_i2.RoutineStepIncludeList? steps}) {
    _steps = steps;
  }

  _i2.RoutineStepIncludeList? _steps;

  @override
  Map<String, _i1.Include?> get includes => {'steps': _steps};

  @override
  _i1.Table get table => RoutineSegment.t;
}

class RoutineSegmentIncludeList extends _i1.IncludeList {
  RoutineSegmentIncludeList._({
    _i1.WhereExpressionBuilder<RoutineSegmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoutineSegment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoutineSegment.t;
}

class RoutineSegmentRepository {
  const RoutineSegmentRepository._();

  final attach = const RoutineSegmentAttachRepository._();

  final attachRow = const RoutineSegmentAttachRowRepository._();

  final detach = const RoutineSegmentDetachRepository._();

  final detachRow = const RoutineSegmentDetachRowRepository._();

  Future<List<RoutineSegment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineSegmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineSegmentTable>? orderByList,
    _i1.Transaction? transaction,
    RoutineSegmentInclude? include,
  }) async {
    return session.db.find<RoutineSegment>(
      where: where?.call(RoutineSegment.t),
      orderBy: orderBy?.call(RoutineSegment.t),
      orderByList: orderByList?.call(RoutineSegment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoutineSegment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineSegmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoutineSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineSegmentTable>? orderByList,
    _i1.Transaction? transaction,
    RoutineSegmentInclude? include,
  }) async {
    return session.db.findFirstRow<RoutineSegment>(
      where: where?.call(RoutineSegment.t),
      orderBy: orderBy?.call(RoutineSegment.t),
      orderByList: orderByList?.call(RoutineSegment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<RoutineSegment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RoutineSegmentInclude? include,
  }) async {
    return session.db.findById<RoutineSegment>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<RoutineSegment>> insert(
    _i1.Session session,
    List<RoutineSegment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RoutineSegment>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineSegment> insertRow(
    _i1.Session session,
    RoutineSegment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoutineSegment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineSegment>> update(
    _i1.Session session,
    List<RoutineSegment> rows, {
    _i1.ColumnSelections<RoutineSegmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoutineSegment>(
      rows,
      columns: columns?.call(RoutineSegment.t),
      transaction: transaction,
    );
  }

  Future<RoutineSegment> updateRow(
    _i1.Session session,
    RoutineSegment row, {
    _i1.ColumnSelections<RoutineSegmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoutineSegment>(
      row,
      columns: columns?.call(RoutineSegment.t),
      transaction: transaction,
    );
  }

  Future<List<RoutineSegment>> delete(
    _i1.Session session,
    List<RoutineSegment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoutineSegment>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineSegment> deleteRow(
    _i1.Session session,
    RoutineSegment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoutineSegment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineSegment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoutineSegmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoutineSegment>(
      where: where(RoutineSegment.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineSegmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoutineSegment>(
      where: where?.call(RoutineSegment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RoutineSegmentAttachRepository {
  const RoutineSegmentAttachRepository._();

  Future<void> steps(
    _i1.Session session,
    RoutineSegment routineSegment,
    List<_i2.RoutineStep> routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.any((e) => e.id == null)) {
      throw ArgumentError.notNull('routineStep.id');
    }
    if (routineSegment.id == null) {
      throw ArgumentError.notNull('routineSegment.id');
    }

    var $routineStep = routineStep
        .map((e) => _i2.RoutineStepImplicit(
              e,
              $_routineSegmentsStepsRoutineSegmentsId: routineSegment.id,
            ))
        .toList();
    await session.db.update<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId],
      transaction: transaction,
    );
  }
}

class RoutineSegmentAttachRowRepository {
  const RoutineSegmentAttachRowRepository._();

  Future<void> steps(
    _i1.Session session,
    RoutineSegment routineSegment,
    _i2.RoutineStep routineStep, {
    _i1.Transaction? transaction,
  }) async {
    if (routineStep.id == null) {
      throw ArgumentError.notNull('routineStep.id');
    }
    if (routineSegment.id == null) {
      throw ArgumentError.notNull('routineSegment.id');
    }

    var $routineStep = _i2.RoutineStepImplicit(
      routineStep,
      $_routineSegmentsStepsRoutineSegmentsId: routineSegment.id,
    );
    await session.db.updateRow<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId],
      transaction: transaction,
    );
  }
}

class RoutineSegmentDetachRepository {
  const RoutineSegmentDetachRepository._();

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
              $_routineSegmentsStepsRoutineSegmentsId: null,
            ))
        .toList();
    await session.db.update<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId],
      transaction: transaction,
    );
  }
}

class RoutineSegmentDetachRowRepository {
  const RoutineSegmentDetachRowRepository._();

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
      $_routineSegmentsStepsRoutineSegmentsId: null,
    );
    await session.db.updateRow<_i2.RoutineStep>(
      $routineStep,
      columns: [_i2.RoutineStep.t.$_routineSegmentsStepsRoutineSegmentsId],
      transaction: transaction,
    );
  }
}
