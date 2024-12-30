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
import 'ability_experience_value.dart' as _i2;

/// A par of a [Routine].
abstract class RoutineStep implements _i1.TableRow, _i1.ProtocolSerialization {
  RoutineStep._({
    this.id,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.title,
    this.description,
    required this.abilityExpValues,
  });

  factory RoutineStep({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    String? description,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) = _RoutineStepImpl;

  factory RoutineStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoutineStep(
      id: jsonSerialization['id'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastModifiedAt: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['lastModifiedAt']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      abilityExpValues: (jsonSerialization['abilityExpValues'] as List)
          .map((e) =>
              _i2.AbilityExperienceValue.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = RoutineStepTable();

  static const db = RoutineStepRepository._();

  @override
  int? id;

  /// Timestamp of entry into database.
  DateTime createdAt;

  /// Timestamp of last update to database entry.
  DateTime lastModifiedAt;

  /// Title.
  String title;

  /// Description.
  String? description;

  /// Collection of [ExperiencePointValue]s to be rewarded upon completion of this task.
  List<_i2.AbilityExperienceValue> abilityExpValues;

  int? _routinesStepsRoutinesId;

  int? _routineSegmentsStepsRoutineSegmentsId;

  @override
  _i1.Table get table => t;

  RoutineStep copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    String? description,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'abilityExpValues':
          abilityExpValues.toJson(valueToJson: (v) => v.toJson()),
      if (_routinesStepsRoutinesId != null)
        '_routinesStepsRoutinesId': _routinesStepsRoutinesId,
      if (_routineSegmentsStepsRoutineSegmentsId != null)
        '_routineSegmentsStepsRoutineSegmentsId':
            _routineSegmentsStepsRoutineSegmentsId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'lastModifiedAt': lastModifiedAt.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'abilityExpValues':
          abilityExpValues.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static RoutineStepInclude include() {
    return RoutineStepInclude._();
  }

  static RoutineStepIncludeList includeList({
    _i1.WhereExpressionBuilder<RoutineStepTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineStepTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineStepTable>? orderByList,
    RoutineStepInclude? include,
  }) {
    return RoutineStepIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoutineStep.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoutineStep.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoutineStepImpl extends RoutineStep {
  _RoutineStepImpl({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    String? description,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
  }) : super._(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );

  @override
  RoutineStep copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? title,
    Object? description = _Undefined,
    List<_i2.AbilityExperienceValue>? abilityExpValues,
  }) {
    return RoutineStep(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      abilityExpValues: abilityExpValues ??
          this.abilityExpValues.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class RoutineStepImplicit extends _RoutineStepImpl {
  RoutineStepImplicit._({
    int? id,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
    required String title,
    String? description,
    required List<_i2.AbilityExperienceValue> abilityExpValues,
    this.$_routinesStepsRoutinesId,
    this.$_routineSegmentsStepsRoutineSegmentsId,
  }) : super(
          id: id,
          createdAt: createdAt,
          lastModifiedAt: lastModifiedAt,
          title: title,
          description: description,
          abilityExpValues: abilityExpValues,
        );

  factory RoutineStepImplicit(
    RoutineStep routineStep, {
    int? $_routinesStepsRoutinesId,
    int? $_routineSegmentsStepsRoutineSegmentsId,
  }) {
    return RoutineStepImplicit._(
      id: routineStep.id,
      createdAt: routineStep.createdAt,
      lastModifiedAt: routineStep.lastModifiedAt,
      title: routineStep.title,
      description: routineStep.description,
      abilityExpValues: routineStep.abilityExpValues,
      $_routinesStepsRoutinesId: $_routinesStepsRoutinesId,
      $_routineSegmentsStepsRoutineSegmentsId:
          $_routineSegmentsStepsRoutineSegmentsId,
    );
  }

  int? $_routinesStepsRoutinesId;

  int? $_routineSegmentsStepsRoutineSegmentsId;

  @override
  Map<String, dynamic> toJson() {
    var jsonMap = super.toJson();
    jsonMap.addAll({
      '_routinesStepsRoutinesId': $_routinesStepsRoutinesId,
      '_routineSegmentsStepsRoutineSegmentsId':
          $_routineSegmentsStepsRoutineSegmentsId
    });
    return jsonMap;
  }
}

class RoutineStepTable extends _i1.Table {
  RoutineStepTable({super.tableRelation}) : super(tableName: 'routine_steps') {
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
    description = _i1.ColumnString(
      'description',
      this,
    );
    abilityExpValues = _i1.ColumnSerializable(
      'abilityExpValues',
      this,
    );
    $_routinesStepsRoutinesId = _i1.ColumnInt(
      '_routinesStepsRoutinesId',
      this,
    );
    $_routineSegmentsStepsRoutineSegmentsId = _i1.ColumnInt(
      '_routineSegmentsStepsRoutineSegmentsId',
      this,
    );
  }

  /// Timestamp of entry into database.
  late final _i1.ColumnDateTime createdAt;

  /// Timestamp of last update to database entry.
  late final _i1.ColumnDateTime lastModifiedAt;

  /// Title.
  late final _i1.ColumnString title;

  /// Description.
  late final _i1.ColumnString description;

  /// Collection of [ExperiencePointValue]s to be rewarded upon completion of this task.
  late final _i1.ColumnSerializable abilityExpValues;

  late final _i1.ColumnInt $_routinesStepsRoutinesId;

  late final _i1.ColumnInt $_routineSegmentsStepsRoutineSegmentsId;

  @override
  List<_i1.Column> get columns => [
        id,
        createdAt,
        lastModifiedAt,
        title,
        description,
        abilityExpValues,
        $_routinesStepsRoutinesId,
        $_routineSegmentsStepsRoutineSegmentsId,
      ];
}

class RoutineStepInclude extends _i1.IncludeObject {
  RoutineStepInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => RoutineStep.t;
}

class RoutineStepIncludeList extends _i1.IncludeList {
  RoutineStepIncludeList._({
    _i1.WhereExpressionBuilder<RoutineStepTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoutineStep.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => RoutineStep.t;
}

class RoutineStepRepository {
  const RoutineStepRepository._();

  Future<List<RoutineStep>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineStepTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoutineStepTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineStepTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<RoutineStep>(
      where: where?.call(RoutineStep.t),
      orderBy: orderBy?.call(RoutineStep.t),
      orderByList: orderByList?.call(RoutineStep.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RoutineStep?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineStepTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoutineStepTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoutineStepTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<RoutineStep>(
      where: where?.call(RoutineStep.t),
      orderBy: orderBy?.call(RoutineStep.t),
      orderByList: orderByList?.call(RoutineStep.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<RoutineStep?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<RoutineStep>(
      id,
      transaction: transaction,
    );
  }

  Future<List<RoutineStep>> insert(
    _i1.Session session,
    List<RoutineStep> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RoutineStep>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineStep> insertRow(
    _i1.Session session,
    RoutineStep row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoutineStep>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineStep>> update(
    _i1.Session session,
    List<RoutineStep> rows, {
    _i1.ColumnSelections<RoutineStepTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoutineStep>(
      rows,
      columns: columns?.call(RoutineStep.t),
      transaction: transaction,
    );
  }

  Future<RoutineStep> updateRow(
    _i1.Session session,
    RoutineStep row, {
    _i1.ColumnSelections<RoutineStepTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoutineStep>(
      row,
      columns: columns?.call(RoutineStep.t),
      transaction: transaction,
    );
  }

  Future<List<RoutineStep>> delete(
    _i1.Session session,
    List<RoutineStep> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoutineStep>(
      rows,
      transaction: transaction,
    );
  }

  Future<RoutineStep> deleteRow(
    _i1.Session session,
    RoutineStep row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoutineStep>(
      row,
      transaction: transaction,
    );
  }

  Future<List<RoutineStep>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RoutineStepTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoutineStep>(
      where: where(RoutineStep.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RoutineStepTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoutineStep>(
      where: where?.call(RoutineStep.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
