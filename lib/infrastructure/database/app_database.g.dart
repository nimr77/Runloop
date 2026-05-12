// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DbCollectionsTable extends DbCollections
    with TableInfo<$DbCollectionsTable, DbCollection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbCollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _autoRunOnAppStartMeta = const VerificationMeta(
    'autoRunOnAppStart',
  );
  @override
  late final GeneratedColumn<bool> autoRunOnAppStart = GeneratedColumn<bool>(
    'auto_run_on_app_start',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_run_on_app_start" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, autoRunOnAppStart];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbCollection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('auto_run_on_app_start')) {
      context.handle(
        _autoRunOnAppStartMeta,
        autoRunOnAppStart.isAcceptableOrUnknown(
          data['auto_run_on_app_start']!,
          _autoRunOnAppStartMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCollection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCollection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      autoRunOnAppStart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_run_on_app_start'],
      )!,
    );
  }

  @override
  $DbCollectionsTable createAlias(String alias) {
    return $DbCollectionsTable(attachedDatabase, alias);
  }
}

class DbCollection extends DataClass implements Insertable<DbCollection> {
  final String id;
  final String name;
  final bool autoRunOnAppStart;
  const DbCollection({
    required this.id,
    required this.name,
    required this.autoRunOnAppStart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['auto_run_on_app_start'] = Variable<bool>(autoRunOnAppStart);
    return map;
  }

  DbCollectionsCompanion toCompanion(bool nullToAbsent) {
    return DbCollectionsCompanion(
      id: Value(id),
      name: Value(name),
      autoRunOnAppStart: Value(autoRunOnAppStart),
    );
  }

  factory DbCollection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCollection(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      autoRunOnAppStart: serializer.fromJson<bool>(json['autoRunOnAppStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'autoRunOnAppStart': serializer.toJson<bool>(autoRunOnAppStart),
    };
  }

  DbCollection copyWith({String? id, String? name, bool? autoRunOnAppStart}) =>
      DbCollection(
        id: id ?? this.id,
        name: name ?? this.name,
        autoRunOnAppStart: autoRunOnAppStart ?? this.autoRunOnAppStart,
      );
  DbCollection copyWithCompanion(DbCollectionsCompanion data) {
    return DbCollection(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      autoRunOnAppStart: data.autoRunOnAppStart.present
          ? data.autoRunOnAppStart.value
          : this.autoRunOnAppStart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCollection(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('autoRunOnAppStart: $autoRunOnAppStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, autoRunOnAppStart);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCollection &&
          other.id == this.id &&
          other.name == this.name &&
          other.autoRunOnAppStart == this.autoRunOnAppStart);
}

class DbCollectionsCompanion extends UpdateCompanion<DbCollection> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> autoRunOnAppStart;
  final Value<int> rowid;
  const DbCollectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.autoRunOnAppStart = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbCollectionsCompanion.insert({
    required String id,
    required String name,
    this.autoRunOnAppStart = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<DbCollection> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? autoRunOnAppStart,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (autoRunOnAppStart != null) 'auto_run_on_app_start': autoRunOnAppStart,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbCollectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? autoRunOnAppStart,
    Value<int>? rowid,
  }) {
    return DbCollectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      autoRunOnAppStart: autoRunOnAppStart ?? this.autoRunOnAppStart,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (autoRunOnAppStart.present) {
      map['auto_run_on_app_start'] = Variable<bool>(autoRunOnAppStart.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbCollectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('autoRunOnAppStart: $autoRunOnAppStart, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbCollectionCommandsTable extends DbCollectionCommands
    with TableInfo<$DbCollectionCommandsTable, DbCollectionCommand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbCollectionCommandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES db_collections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineMeta = const VerificationMeta('line');
  @override
  late final GeneratedColumn<String> line = GeneratedColumn<String>(
    'line',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, sortOrder, line];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_collection_commands';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbCollectionCommand> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('line')) {
      context.handle(
        _lineMeta,
        line.isAcceptableOrUnknown(data['line']!, _lineMeta),
      );
    } else if (isInserting) {
      context.missing(_lineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCollectionCommand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCollectionCommand(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      line: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line'],
      )!,
    );
  }

  @override
  $DbCollectionCommandsTable createAlias(String alias) {
    return $DbCollectionCommandsTable(attachedDatabase, alias);
  }
}

class DbCollectionCommand extends DataClass
    implements Insertable<DbCollectionCommand> {
  final int id;
  final String collectionId;
  final int sortOrder;
  final String line;
  const DbCollectionCommand({
    required this.id,
    required this.collectionId,
    required this.sortOrder,
    required this.line,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['line'] = Variable<String>(line);
    return map;
  }

  DbCollectionCommandsCompanion toCompanion(bool nullToAbsent) {
    return DbCollectionCommandsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      sortOrder: Value(sortOrder),
      line: Value(line),
    );
  }

  factory DbCollectionCommand.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCollectionCommand(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      line: serializer.fromJson<String>(json['line']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'line': serializer.toJson<String>(line),
    };
  }

  DbCollectionCommand copyWith({
    int? id,
    String? collectionId,
    int? sortOrder,
    String? line,
  }) => DbCollectionCommand(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    sortOrder: sortOrder ?? this.sortOrder,
    line: line ?? this.line,
  );
  DbCollectionCommand copyWithCompanion(DbCollectionCommandsCompanion data) {
    return DbCollectionCommand(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      line: data.line.present ? data.line.value : this.line,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCollectionCommand(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('line: $line')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, sortOrder, line);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCollectionCommand &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.sortOrder == this.sortOrder &&
          other.line == this.line);
}

class DbCollectionCommandsCompanion
    extends UpdateCompanion<DbCollectionCommand> {
  final Value<int> id;
  final Value<String> collectionId;
  final Value<int> sortOrder;
  final Value<String> line;
  const DbCollectionCommandsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.line = const Value.absent(),
  });
  DbCollectionCommandsCompanion.insert({
    this.id = const Value.absent(),
    required String collectionId,
    required int sortOrder,
    required String line,
  }) : collectionId = Value(collectionId),
       sortOrder = Value(sortOrder),
       line = Value(line);
  static Insertable<DbCollectionCommand> custom({
    Expression<int>? id,
    Expression<String>? collectionId,
    Expression<int>? sortOrder,
    Expression<String>? line,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (line != null) 'line': line,
    });
  }

  DbCollectionCommandsCompanion copyWith({
    Value<int>? id,
    Value<String>? collectionId,
    Value<int>? sortOrder,
    Value<String>? line,
  }) {
    return DbCollectionCommandsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      sortOrder: sortOrder ?? this.sortOrder,
      line: line ?? this.line,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (line.present) {
      map['line'] = Variable<String>(line.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbCollectionCommandsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('line: $line')
          ..write(')'))
        .toString();
  }
}

class $DbAppPrefsTable extends DbAppPrefs
    with TableInfo<$DbAppPrefsTable, DbAppPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbAppPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _launchAtLoginMeta = const VerificationMeta(
    'launchAtLogin',
  );
  @override
  late final GeneratedColumn<bool> launchAtLogin = GeneratedColumn<bool>(
    'launch_at_login',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("launch_at_login" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, launchAtLogin];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_app_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbAppPref> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('launch_at_login')) {
      context.handle(
        _launchAtLoginMeta,
        launchAtLogin.isAcceptableOrUnknown(
          data['launch_at_login']!,
          _launchAtLoginMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbAppPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbAppPref(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      launchAtLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}launch_at_login'],
      )!,
    );
  }

  @override
  $DbAppPrefsTable createAlias(String alias) {
    return $DbAppPrefsTable(attachedDatabase, alias);
  }
}

class DbAppPref extends DataClass implements Insertable<DbAppPref> {
  final int id;
  final bool launchAtLogin;
  const DbAppPref({required this.id, required this.launchAtLogin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['launch_at_login'] = Variable<bool>(launchAtLogin);
    return map;
  }

  DbAppPrefsCompanion toCompanion(bool nullToAbsent) {
    return DbAppPrefsCompanion(
      id: Value(id),
      launchAtLogin: Value(launchAtLogin),
    );
  }

  factory DbAppPref.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbAppPref(
      id: serializer.fromJson<int>(json['id']),
      launchAtLogin: serializer.fromJson<bool>(json['launchAtLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'launchAtLogin': serializer.toJson<bool>(launchAtLogin),
    };
  }

  DbAppPref copyWith({int? id, bool? launchAtLogin}) => DbAppPref(
    id: id ?? this.id,
    launchAtLogin: launchAtLogin ?? this.launchAtLogin,
  );
  DbAppPref copyWithCompanion(DbAppPrefsCompanion data) {
    return DbAppPref(
      id: data.id.present ? data.id.value : this.id,
      launchAtLogin: data.launchAtLogin.present
          ? data.launchAtLogin.value
          : this.launchAtLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbAppPref(')
          ..write('id: $id, ')
          ..write('launchAtLogin: $launchAtLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, launchAtLogin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbAppPref &&
          other.id == this.id &&
          other.launchAtLogin == this.launchAtLogin);
}

class DbAppPrefsCompanion extends UpdateCompanion<DbAppPref> {
  final Value<int> id;
  final Value<bool> launchAtLogin;
  const DbAppPrefsCompanion({
    this.id = const Value.absent(),
    this.launchAtLogin = const Value.absent(),
  });
  DbAppPrefsCompanion.insert({
    this.id = const Value.absent(),
    this.launchAtLogin = const Value.absent(),
  });
  static Insertable<DbAppPref> custom({
    Expression<int>? id,
    Expression<bool>? launchAtLogin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (launchAtLogin != null) 'launch_at_login': launchAtLogin,
    });
  }

  DbAppPrefsCompanion copyWith({Value<int>? id, Value<bool>? launchAtLogin}) {
    return DbAppPrefsCompanion(
      id: id ?? this.id,
      launchAtLogin: launchAtLogin ?? this.launchAtLogin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (launchAtLogin.present) {
      map['launch_at_login'] = Variable<bool>(launchAtLogin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbAppPrefsCompanion(')
          ..write('id: $id, ')
          ..write('launchAtLogin: $launchAtLogin')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbCollectionsTable dbCollections = $DbCollectionsTable(this);
  late final $DbCollectionCommandsTable dbCollectionCommands =
      $DbCollectionCommandsTable(this);
  late final $DbAppPrefsTable dbAppPrefs = $DbAppPrefsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbCollections,
    dbCollectionCommands,
    dbAppPrefs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'db_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('db_collection_commands', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DbCollectionsTableCreateCompanionBuilder =
    DbCollectionsCompanion Function({
      required String id,
      required String name,
      Value<bool> autoRunOnAppStart,
      Value<int> rowid,
    });
typedef $$DbCollectionsTableUpdateCompanionBuilder =
    DbCollectionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> autoRunOnAppStart,
      Value<int> rowid,
    });

final class $$DbCollectionsTableReferences
    extends BaseReferences<_$AppDatabase, $DbCollectionsTable, DbCollection> {
  $$DbCollectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $DbCollectionCommandsTable,
    List<DbCollectionCommand>
  >
  _dbCollectionCommandsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.dbCollectionCommands,
        aliasName: $_aliasNameGenerator(
          db.dbCollections.id,
          db.dbCollectionCommands.collectionId,
        ),
      );

  $$DbCollectionCommandsTableProcessedTableManager
  get dbCollectionCommandsRefs {
    final manager = $$DbCollectionCommandsTableTableManager(
      $_db,
      $_db.dbCollectionCommands,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _dbCollectionCommandsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbCollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $DbCollectionsTable> {
  $$DbCollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoRunOnAppStart => $composableBuilder(
    column: $table.autoRunOnAppStart,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dbCollectionCommandsRefs(
    Expression<bool> Function($$DbCollectionCommandsTableFilterComposer f) f,
  ) {
    final $$DbCollectionCommandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbCollectionCommands,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCollectionCommandsTableFilterComposer(
            $db: $db,
            $table: $db.dbCollectionCommands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbCollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbCollectionsTable> {
  $$DbCollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoRunOnAppStart => $composableBuilder(
    column: $table.autoRunOnAppStart,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbCollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbCollectionsTable> {
  $$DbCollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get autoRunOnAppStart => $composableBuilder(
    column: $table.autoRunOnAppStart,
    builder: (column) => column,
  );

  Expression<T> dbCollectionCommandsRefs<T extends Object>(
    Expression<T> Function($$DbCollectionCommandsTableAnnotationComposer a) f,
  ) {
    final $$DbCollectionCommandsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.dbCollectionCommands,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DbCollectionCommandsTableAnnotationComposer(
                $db: $db,
                $table: $db.dbCollectionCommands,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DbCollectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbCollectionsTable,
          DbCollection,
          $$DbCollectionsTableFilterComposer,
          $$DbCollectionsTableOrderingComposer,
          $$DbCollectionsTableAnnotationComposer,
          $$DbCollectionsTableCreateCompanionBuilder,
          $$DbCollectionsTableUpdateCompanionBuilder,
          (DbCollection, $$DbCollectionsTableReferences),
          DbCollection,
          PrefetchHooks Function({bool dbCollectionCommandsRefs})
        > {
  $$DbCollectionsTableTableManager(_$AppDatabase db, $DbCollectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbCollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbCollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbCollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> autoRunOnAppStart = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbCollectionsCompanion(
                id: id,
                name: name,
                autoRunOnAppStart: autoRunOnAppStart,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> autoRunOnAppStart = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbCollectionsCompanion.insert(
                id: id,
                name: name,
                autoRunOnAppStart: autoRunOnAppStart,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DbCollectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dbCollectionCommandsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dbCollectionCommandsRefs) db.dbCollectionCommands,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbCollectionCommandsRefs)
                    await $_getPrefetchedData<
                      DbCollection,
                      $DbCollectionsTable,
                      DbCollectionCommand
                    >(
                      currentTable: table,
                      referencedTable: $$DbCollectionsTableReferences
                          ._dbCollectionCommandsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DbCollectionsTableReferences(
                            db,
                            table,
                            p0,
                          ).dbCollectionCommandsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.collectionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbCollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbCollectionsTable,
      DbCollection,
      $$DbCollectionsTableFilterComposer,
      $$DbCollectionsTableOrderingComposer,
      $$DbCollectionsTableAnnotationComposer,
      $$DbCollectionsTableCreateCompanionBuilder,
      $$DbCollectionsTableUpdateCompanionBuilder,
      (DbCollection, $$DbCollectionsTableReferences),
      DbCollection,
      PrefetchHooks Function({bool dbCollectionCommandsRefs})
    >;
typedef $$DbCollectionCommandsTableCreateCompanionBuilder =
    DbCollectionCommandsCompanion Function({
      Value<int> id,
      required String collectionId,
      required int sortOrder,
      required String line,
    });
typedef $$DbCollectionCommandsTableUpdateCompanionBuilder =
    DbCollectionCommandsCompanion Function({
      Value<int> id,
      Value<String> collectionId,
      Value<int> sortOrder,
      Value<String> line,
    });

final class $$DbCollectionCommandsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DbCollectionCommandsTable,
          DbCollectionCommand
        > {
  $$DbCollectionCommandsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DbCollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.dbCollections.createAlias(
        $_aliasNameGenerator(
          db.dbCollectionCommands.collectionId,
          db.dbCollections.id,
        ),
      );

  $$DbCollectionsTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $$DbCollectionsTableTableManager(
      $_db,
      $_db.dbCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DbCollectionCommandsTableFilterComposer
    extends Composer<_$AppDatabase, $DbCollectionCommandsTable> {
  $$DbCollectionCommandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get line => $composableBuilder(
    column: $table.line,
    builder: (column) => ColumnFilters(column),
  );

  $$DbCollectionsTableFilterComposer get collectionId {
    final $$DbCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.dbCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.dbCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCollectionCommandsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbCollectionCommandsTable> {
  $$DbCollectionCommandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get line => $composableBuilder(
    column: $table.line,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbCollectionsTableOrderingComposer get collectionId {
    final $$DbCollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.dbCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.dbCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCollectionCommandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbCollectionCommandsTable> {
  $$DbCollectionCommandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get line =>
      $composableBuilder(column: $table.line, builder: (column) => column);

  $$DbCollectionsTableAnnotationComposer get collectionId {
    final $$DbCollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.dbCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbCollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.dbCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbCollectionCommandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbCollectionCommandsTable,
          DbCollectionCommand,
          $$DbCollectionCommandsTableFilterComposer,
          $$DbCollectionCommandsTableOrderingComposer,
          $$DbCollectionCommandsTableAnnotationComposer,
          $$DbCollectionCommandsTableCreateCompanionBuilder,
          $$DbCollectionCommandsTableUpdateCompanionBuilder,
          (DbCollectionCommand, $$DbCollectionCommandsTableReferences),
          DbCollectionCommand,
          PrefetchHooks Function({bool collectionId})
        > {
  $$DbCollectionCommandsTableTableManager(
    _$AppDatabase db,
    $DbCollectionCommandsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbCollectionCommandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbCollectionCommandsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DbCollectionCommandsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> line = const Value.absent(),
              }) => DbCollectionCommandsCompanion(
                id: id,
                collectionId: collectionId,
                sortOrder: sortOrder,
                line: line,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String collectionId,
                required int sortOrder,
                required String line,
              }) => DbCollectionCommandsCompanion.insert(
                id: id,
                collectionId: collectionId,
                sortOrder: sortOrder,
                line: line,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DbCollectionCommandsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (collectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.collectionId,
                                referencedTable:
                                    $$DbCollectionCommandsTableReferences
                                        ._collectionIdTable(db),
                                referencedColumn:
                                    $$DbCollectionCommandsTableReferences
                                        ._collectionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DbCollectionCommandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbCollectionCommandsTable,
      DbCollectionCommand,
      $$DbCollectionCommandsTableFilterComposer,
      $$DbCollectionCommandsTableOrderingComposer,
      $$DbCollectionCommandsTableAnnotationComposer,
      $$DbCollectionCommandsTableCreateCompanionBuilder,
      $$DbCollectionCommandsTableUpdateCompanionBuilder,
      (DbCollectionCommand, $$DbCollectionCommandsTableReferences),
      DbCollectionCommand,
      PrefetchHooks Function({bool collectionId})
    >;
typedef $$DbAppPrefsTableCreateCompanionBuilder =
    DbAppPrefsCompanion Function({Value<int> id, Value<bool> launchAtLogin});
typedef $$DbAppPrefsTableUpdateCompanionBuilder =
    DbAppPrefsCompanion Function({Value<int> id, Value<bool> launchAtLogin});

class $$DbAppPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $DbAppPrefsTable> {
  $$DbAppPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbAppPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbAppPrefsTable> {
  $$DbAppPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbAppPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbAppPrefsTable> {
  $$DbAppPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => column,
  );
}

class $$DbAppPrefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbAppPrefsTable,
          DbAppPref,
          $$DbAppPrefsTableFilterComposer,
          $$DbAppPrefsTableOrderingComposer,
          $$DbAppPrefsTableAnnotationComposer,
          $$DbAppPrefsTableCreateCompanionBuilder,
          $$DbAppPrefsTableUpdateCompanionBuilder,
          (
            DbAppPref,
            BaseReferences<_$AppDatabase, $DbAppPrefsTable, DbAppPref>,
          ),
          DbAppPref,
          PrefetchHooks Function()
        > {
  $$DbAppPrefsTableTableManager(_$AppDatabase db, $DbAppPrefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbAppPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbAppPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbAppPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> launchAtLogin = const Value.absent(),
              }) => DbAppPrefsCompanion(id: id, launchAtLogin: launchAtLogin),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> launchAtLogin = const Value.absent(),
              }) => DbAppPrefsCompanion.insert(
                id: id,
                launchAtLogin: launchAtLogin,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbAppPrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbAppPrefsTable,
      DbAppPref,
      $$DbAppPrefsTableFilterComposer,
      $$DbAppPrefsTableOrderingComposer,
      $$DbAppPrefsTableAnnotationComposer,
      $$DbAppPrefsTableCreateCompanionBuilder,
      $$DbAppPrefsTableUpdateCompanionBuilder,
      (DbAppPref, BaseReferences<_$AppDatabase, $DbAppPrefsTable, DbAppPref>),
      DbAppPref,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbCollectionsTableTableManager get dbCollections =>
      $$DbCollectionsTableTableManager(_db, _db.dbCollections);
  $$DbCollectionCommandsTableTableManager get dbCollectionCommands =>
      $$DbCollectionCommandsTableTableManager(_db, _db.dbCollectionCommands);
  $$DbAppPrefsTableTableManager get dbAppPrefs =>
      $$DbAppPrefsTableTableManager(_db, _db.dbAppPrefs);
}
