// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signing_session_recipient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SigningSessionRecipient _$SigningSessionRecipientFromJson(
  Map<String, dynamic> json,
) {
  return _SigningSessionRecipient.fromJson(json);
}

/// @nodoc
mixin _$SigningSessionRecipient {
  String get sessionId => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;

  /// Serializes this SigningSessionRecipient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SigningSessionRecipient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SigningSessionRecipientCopyWith<SigningSessionRecipient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigningSessionRecipientCopyWith<$Res> {
  factory $SigningSessionRecipientCopyWith(
    SigningSessionRecipient value,
    $Res Function(SigningSessionRecipient) then,
  ) = _$SigningSessionRecipientCopyWithImpl<$Res, SigningSessionRecipient>;
  @useResult
  $Res call({String sessionId, String recipientId});
}

/// @nodoc
class _$SigningSessionRecipientCopyWithImpl<
  $Res,
  $Val extends SigningSessionRecipient
>
    implements $SigningSessionRecipientCopyWith<$Res> {
  _$SigningSessionRecipientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SigningSessionRecipient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sessionId = null, Object? recipientId = null}) {
    return _then(
      _value.copyWith(
            sessionId:
                null == sessionId
                    ? _value.sessionId
                    : sessionId // ignore: cast_nullable_to_non_nullable
                        as String,
            recipientId:
                null == recipientId
                    ? _value.recipientId
                    : recipientId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SigningSessionRecipientImplCopyWith<$Res>
    implements $SigningSessionRecipientCopyWith<$Res> {
  factory _$$SigningSessionRecipientImplCopyWith(
    _$SigningSessionRecipientImpl value,
    $Res Function(_$SigningSessionRecipientImpl) then,
  ) = __$$SigningSessionRecipientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sessionId, String recipientId});
}

/// @nodoc
class __$$SigningSessionRecipientImplCopyWithImpl<$Res>
    extends
        _$SigningSessionRecipientCopyWithImpl<
          $Res,
          _$SigningSessionRecipientImpl
        >
    implements _$$SigningSessionRecipientImplCopyWith<$Res> {
  __$$SigningSessionRecipientImplCopyWithImpl(
    _$SigningSessionRecipientImpl _value,
    $Res Function(_$SigningSessionRecipientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SigningSessionRecipient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sessionId = null, Object? recipientId = null}) {
    return _then(
      _$SigningSessionRecipientImpl(
        sessionId:
            null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                    as String,
        recipientId:
            null == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SigningSessionRecipientImpl implements _SigningSessionRecipient {
  const _$SigningSessionRecipientImpl({
    required this.sessionId,
    required this.recipientId,
  });

  factory _$SigningSessionRecipientImpl.fromJson(Map<String, dynamic> json) =>
      _$$SigningSessionRecipientImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String recipientId;

  @override
  String toString() {
    return 'SigningSessionRecipient(sessionId: $sessionId, recipientId: $recipientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigningSessionRecipientImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionId, recipientId);

  /// Create a copy of SigningSessionRecipient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SigningSessionRecipientImplCopyWith<_$SigningSessionRecipientImpl>
  get copyWith => __$$SigningSessionRecipientImplCopyWithImpl<
    _$SigningSessionRecipientImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SigningSessionRecipientImplToJson(this);
  }
}

abstract class _SigningSessionRecipient implements SigningSessionRecipient {
  const factory _SigningSessionRecipient({
    required final String sessionId,
    required final String recipientId,
  }) = _$SigningSessionRecipientImpl;

  factory _SigningSessionRecipient.fromJson(Map<String, dynamic> json) =
      _$SigningSessionRecipientImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get recipientId;

  /// Create a copy of SigningSessionRecipient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SigningSessionRecipientImplCopyWith<_$SigningSessionRecipientImpl>
  get copyWith => throw _privateConstructorUsedError;
}
