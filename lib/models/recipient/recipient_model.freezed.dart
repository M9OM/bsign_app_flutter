// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Recipient _$RecipientFromJson(Map<String, dynamic> json) {
  return _Recipient.fromJson(json);
}

/// @nodoc
mixin _$Recipient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get document_id => throw _privateConstructorUsedError;
  String get user_email => throw _privateConstructorUsedError;
  RecipientRole get role => throw _privateConstructorUsedError;
  DateTime? get assignedAt => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;

  /// Serializes this Recipient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recipient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipientCopyWith<Recipient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientCopyWith<$Res> {
  factory $RecipientCopyWith(Recipient value, $Res Function(Recipient) then) =
      _$RecipientCopyWithImpl<$Res, Recipient>;
  @useResult
  $Res call({
    String id,
    String name,
    String document_id,
    String user_email,
    RecipientRole role,
    DateTime? assignedAt,
    String? addedBy,
  });
}

/// @nodoc
class _$RecipientCopyWithImpl<$Res, $Val extends Recipient>
    implements $RecipientCopyWith<$Res> {
  _$RecipientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recipient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? document_id = null,
    Object? user_email = null,
    Object? role = null,
    Object? assignedAt = freezed,
    Object? addedBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            document_id:
                null == document_id
                    ? _value.document_id
                    : document_id // ignore: cast_nullable_to_non_nullable
                        as String,
            user_email:
                null == user_email
                    ? _value.user_email
                    : user_email // ignore: cast_nullable_to_non_nullable
                        as String,
            role:
                null == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as RecipientRole,
            assignedAt:
                freezed == assignedAt
                    ? _value.assignedAt
                    : assignedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            addedBy:
                freezed == addedBy
                    ? _value.addedBy
                    : addedBy // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipientImplCopyWith<$Res>
    implements $RecipientCopyWith<$Res> {
  factory _$$RecipientImplCopyWith(
    _$RecipientImpl value,
    $Res Function(_$RecipientImpl) then,
  ) = __$$RecipientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String document_id,
    String user_email,
    RecipientRole role,
    DateTime? assignedAt,
    String? addedBy,
  });
}

/// @nodoc
class __$$RecipientImplCopyWithImpl<$Res>
    extends _$RecipientCopyWithImpl<$Res, _$RecipientImpl>
    implements _$$RecipientImplCopyWith<$Res> {
  __$$RecipientImplCopyWithImpl(
    _$RecipientImpl _value,
    $Res Function(_$RecipientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Recipient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? document_id = null,
    Object? user_email = null,
    Object? role = null,
    Object? assignedAt = freezed,
    Object? addedBy = freezed,
  }) {
    return _then(
      _$RecipientImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        document_id:
            null == document_id
                ? _value.document_id
                : document_id // ignore: cast_nullable_to_non_nullable
                    as String,
        user_email:
            null == user_email
                ? _value.user_email
                : user_email // ignore: cast_nullable_to_non_nullable
                    as String,
        role:
            null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as RecipientRole,
        assignedAt:
            freezed == assignedAt
                ? _value.assignedAt
                : assignedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        addedBy:
            freezed == addedBy
                ? _value.addedBy
                : addedBy // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipientImpl implements _Recipient {
  const _$RecipientImpl({
    required this.id,
    required this.name,
    required this.document_id,
    required this.user_email,
    required this.role,
    this.assignedAt,
    this.addedBy,
  });

  factory _$RecipientImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipientImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String document_id;
  @override
  final String user_email;
  @override
  final RecipientRole role;
  @override
  final DateTime? assignedAt;
  @override
  final String? addedBy;

  @override
  String toString() {
    return 'Recipient(id: $id, name: $name, document_id: $document_id, user_email: $user_email, role: $role, assignedAt: $assignedAt, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.document_id, document_id) ||
                other.document_id == document_id) &&
            (identical(other.user_email, user_email) ||
                other.user_email == user_email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    document_id,
    user_email,
    role,
    assignedAt,
    addedBy,
  );

  /// Create a copy of Recipient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipientImplCopyWith<_$RecipientImpl> get copyWith =>
      __$$RecipientImplCopyWithImpl<_$RecipientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipientImplToJson(this);
  }
}

abstract class _Recipient implements Recipient {
  const factory _Recipient({
    required final String id,
    required final String name,
    required final String document_id,
    required final String user_email,
    required final RecipientRole role,
    final DateTime? assignedAt,
    final String? addedBy,
  }) = _$RecipientImpl;

  factory _Recipient.fromJson(Map<String, dynamic> json) =
      _$RecipientImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get document_id;
  @override
  String get user_email;
  @override
  RecipientRole get role;
  @override
  DateTime? get assignedAt;
  @override
  String? get addedBy;

  /// Create a copy of Recipient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipientImplCopyWith<_$RecipientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
