// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SigningSession _$SigningSessionFromJson(Map<String, dynamic> json) {
  return _SigningSession.fromJson(json);
}

/// @nodoc
mixin _$SigningSession {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  SessionStatus? get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;

  /// Serializes this SigningSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SigningSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SigningSessionCopyWith<SigningSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningSessionCopyWith<$Res> {
  factory $SigningSessionCopyWith(
    SigningSession value,
    $Res Function(SigningSession) then,
  ) = _$SigningSessionCopyWithImpl<$Res, SigningSession>;
  @useResult
  $Res call({
    String id,
    String documentId,
    SessionStatus? status,
    DateTime? createdAt,
    String? createdBy,
  });
}

/// @nodoc
class _$SigningSessionCopyWithImpl<$Res, $Val extends SigningSession>
    implements $SigningSessionCopyWith<$Res> {
  _$SigningSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SigningSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
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
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as SessionStatus?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdBy:
                freezed == createdBy
                    ? _value.createdBy
                    : createdBy // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SigningSessionImplCopyWith<$Res>
    implements $SigningSessionCopyWith<$Res> {
  factory _$$SigningSessionImplCopyWith(
    _$SigningSessionImpl value,
    $Res Function(_$SigningSessionImpl) then,
  ) = __$$SigningSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String documentId,
    SessionStatus? status,
    DateTime? createdAt,
    String? createdBy,
  });
}

/// @nodoc
class __$$SigningSessionImplCopyWithImpl<$Res>
    extends _$SigningSessionCopyWithImpl<$Res, _$SigningSessionImpl>
    implements _$$SigningSessionImplCopyWith<$Res> {
  __$$SigningSessionImplCopyWithImpl(
    _$SigningSessionImpl _value,
    $Res Function(_$SigningSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SigningSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
  }) {
    return _then(
      _$SigningSessionImpl(
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
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as SessionStatus?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdBy:
            freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SigningSessionImpl implements _SigningSession {
  const _$SigningSessionImpl({
    required this.id,
    required this.documentId,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  factory _$SigningSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SigningSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String documentId;
  @override
  final SessionStatus? status;
  @override
  final DateTime? createdAt;
  @override
  final String? createdBy;

  @override
  String toString() {
    return 'SigningSession(id: $id, documentId: $documentId, status: $status, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigningSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, documentId, status, createdAt, createdBy);

  /// Create a copy of SigningSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SigningSessionImplCopyWith<_$SigningSessionImpl> get copyWith =>
      __$$SigningSessionImplCopyWithImpl<_$SigningSessionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SigningSessionImplToJson(this);
  }
}

abstract class _SigningSession implements SigningSession {
  const factory _SigningSession({
    required final String id,
    required final String documentId,
    final SessionStatus? status,
    final DateTime? createdAt,
    final String? createdBy,
  }) = _$SigningSessionImpl;

  factory _SigningSession.fromJson(Map<String, dynamic> json) =
      _$SigningSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  SessionStatus? get status;
  @override
  DateTime? get createdAt;
  @override
  String? get createdBy;

  /// Create a copy of SigningSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SigningSessionImplCopyWith<_$SigningSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
