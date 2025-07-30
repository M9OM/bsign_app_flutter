// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuditLog _$AuditLogFromJson(Map<String, dynamic> json) {
  return _AuditLog.fromJson(json);
}

/// @nodoc
mixin _$AuditLog {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  AuditAction get action => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get recipientEmail => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get userAgent => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this AuditLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogCopyWith<AuditLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogCopyWith<$Res> {
  factory $AuditLogCopyWith(AuditLog value, $Res Function(AuditLog) then) =
      _$AuditLogCopyWithImpl<$Res, AuditLog>;
  @useResult
  $Res call({
    String id,
    String documentId,
    AuditAction action,
    String userId,
    String? recipientEmail,
    String? ipAddress,
    String? userAgent,
    Map<String, dynamic>? metadata,
    DateTime timestamp,
  });
}

/// @nodoc
class _$AuditLogCopyWithImpl<$Res, $Val extends AuditLog>
    implements $AuditLogCopyWith<$Res> {
  _$AuditLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? action = null,
    Object? userId = null,
    Object? recipientEmail = freezed,
    Object? ipAddress = freezed,
    Object? userAgent = freezed,
    Object? metadata = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            documentId:
                null == documentId
                    ? _value.documentId
                    : documentId // ignore: cast_nullable_to_non_nullable
                        as String,
            action:
                null == action
                    ? _value.action
                    : action // ignore: cast_nullable_to_non_nullable
                        as AuditAction,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            recipientEmail:
                freezed == recipientEmail
                    ? _value.recipientEmail
                    : recipientEmail // ignore: cast_nullable_to_non_nullable
                        as String?,
            ipAddress:
                freezed == ipAddress
                    ? _value.ipAddress
                    : ipAddress // ignore: cast_nullable_to_non_nullable
                        as String?,
            userAgent:
                freezed == userAgent
                    ? _value.userAgent
                    : userAgent // ignore: cast_nullable_to_non_nullable
                        as String?,
            metadata:
                freezed == metadata
                    ? _value.metadata
                    : metadata // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuditLogImplCopyWith<$Res>
    implements $AuditLogCopyWith<$Res> {
  factory _$$AuditLogImplCopyWith(
    _$AuditLogImpl value,
    $Res Function(_$AuditLogImpl) then,
  ) = __$$AuditLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String documentId,
    AuditAction action,
    String userId,
    String? recipientEmail,
    String? ipAddress,
    String? userAgent,
    Map<String, dynamic>? metadata,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$AuditLogImplCopyWithImpl<$Res>
    extends _$AuditLogCopyWithImpl<$Res, _$AuditLogImpl>
    implements _$$AuditLogImplCopyWith<$Res> {
  __$$AuditLogImplCopyWithImpl(
    _$AuditLogImpl _value,
    $Res Function(_$AuditLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? action = null,
    Object? userId = null,
    Object? recipientEmail = freezed,
    Object? ipAddress = freezed,
    Object? userAgent = freezed,
    Object? metadata = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _$AuditLogImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        documentId:
            null == documentId
                ? _value.documentId
                : documentId // ignore: cast_nullable_to_non_nullable
                    as String,
        action:
            null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                    as AuditAction,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        recipientEmail:
            freezed == recipientEmail
                ? _value.recipientEmail
                : recipientEmail // ignore: cast_nullable_to_non_nullable
                    as String?,
        ipAddress:
            freezed == ipAddress
                ? _value.ipAddress
                : ipAddress // ignore: cast_nullable_to_non_nullable
                    as String?,
        userAgent:
            freezed == userAgent
                ? _value.userAgent
                : userAgent // ignore: cast_nullable_to_non_nullable
                    as String?,
        metadata:
            freezed == metadata
                ? _value._metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogImpl implements _AuditLog {
  const _$AuditLogImpl({
    required this.id,
    required this.documentId,
    required this.action,
    required this.userId,
    this.recipientEmail,
    this.ipAddress,
    this.userAgent,
    final Map<String, dynamic>? metadata,
    required this.timestamp,
  }) : _metadata = metadata;

  factory _$AuditLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogImplFromJson(json);

  @override
  final String id;
  @override
  final String documentId;
  @override
  final AuditAction action;
  @override
  final String userId;
  @override
  final String? recipientEmail;
  @override
  final String? ipAddress;
  @override
  final String? userAgent;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'AuditLog(id: $id, documentId: $documentId, action: $action, userId: $userId, recipientEmail: $recipientEmail, ipAddress: $ipAddress, userAgent: $userAgent, metadata: $metadata, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recipientEmail, recipientEmail) ||
                other.recipientEmail == recipientEmail) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    documentId,
    action,
    userId,
    recipientEmail,
    ipAddress,
    userAgent,
    const DeepCollectionEquality().hash(_metadata),
    timestamp,
  );

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      __$$AuditLogImplCopyWithImpl<_$AuditLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogImplToJson(this);
  }
}

abstract class _AuditLog implements AuditLog {
  const factory _AuditLog({
    required final String id,
    required final String documentId,
    required final AuditAction action,
    required final String userId,
    final String? recipientEmail,
    final String? ipAddress,
    final String? userAgent,
    final Map<String, dynamic>? metadata,
    required final DateTime timestamp,
  }) = _$AuditLogImpl;

  factory _AuditLog.fromJson(Map<String, dynamic> json) =
      _$AuditLogImpl.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  AuditAction get action;
  @override
  String get userId;
  @override
  String? get recipientEmail;
  @override
  String? get ipAddress;
  @override
  String? get userAgent;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get timestamp;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
