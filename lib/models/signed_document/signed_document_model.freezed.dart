// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SignedDocument _$SignedDocumentFromJson(Map<String, dynamic> json) {
  return _SignedDocument.fromJson(json);
}

/// @nodoc
mixin _$SignedDocument {
  String get id => throw _privateConstructorUsedError;
  String get originalDocumentId => throw _privateConstructorUsedError;
  String get signedUrl => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this SignedDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignedDocumentCopyWith<SignedDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedDocumentCopyWith<$Res> {
  factory $SignedDocumentCopyWith(
    SignedDocument value,
    $Res Function(SignedDocument) then,
  ) = _$SignedDocumentCopyWithImpl<$Res, SignedDocument>;
  @useResult
  $Res call({
    String id,
    String originalDocumentId,
    String signedUrl,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$SignedDocumentCopyWithImpl<$Res, $Val extends SignedDocument>
    implements $SignedDocumentCopyWith<$Res> {
  _$SignedDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalDocumentId = null,
    Object? signedUrl = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            originalDocumentId:
                null == originalDocumentId
                    ? _value.originalDocumentId
                    : originalDocumentId // ignore: cast_nullable_to_non_nullable
                        as String,
            signedUrl:
                null == signedUrl
                    ? _value.signedUrl
                    : signedUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            completedAt:
                freezed == completedAt
                    ? _value.completedAt
                    : completedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignedDocumentImplCopyWith<$Res>
    implements $SignedDocumentCopyWith<$Res> {
  factory _$$SignedDocumentImplCopyWith(
    _$SignedDocumentImpl value,
    $Res Function(_$SignedDocumentImpl) then,
  ) = __$$SignedDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String originalDocumentId,
    String signedUrl,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$SignedDocumentImplCopyWithImpl<$Res>
    extends _$SignedDocumentCopyWithImpl<$Res, _$SignedDocumentImpl>
    implements _$$SignedDocumentImplCopyWith<$Res> {
  __$$SignedDocumentImplCopyWithImpl(
    _$SignedDocumentImpl _value,
    $Res Function(_$SignedDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? originalDocumentId = null,
    Object? signedUrl = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$SignedDocumentImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        originalDocumentId:
            null == originalDocumentId
                ? _value.originalDocumentId
                : originalDocumentId // ignore: cast_nullable_to_non_nullable
                    as String,
        signedUrl:
            null == signedUrl
                ? _value.signedUrl
                : signedUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        completedAt:
            freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignedDocumentImpl implements _SignedDocument {
  const _$SignedDocumentImpl({
    required this.id,
    required this.originalDocumentId,
    required this.signedUrl,
    this.completedAt,
  });

  factory _$SignedDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignedDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final String originalDocumentId;
  @override
  final String signedUrl;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'SignedDocument(id: $id, originalDocumentId: $originalDocumentId, signedUrl: $signedUrl, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.originalDocumentId, originalDocumentId) ||
                other.originalDocumentId == originalDocumentId) &&
            (identical(other.signedUrl, signedUrl) ||
                other.signedUrl == signedUrl) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, originalDocumentId, signedUrl, completedAt);

  /// Create a copy of SignedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedDocumentImplCopyWith<_$SignedDocumentImpl> get copyWith =>
      __$$SignedDocumentImplCopyWithImpl<_$SignedDocumentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SignedDocumentImplToJson(this);
  }
}

abstract class _SignedDocument implements SignedDocument {
  const factory _SignedDocument({
    required final String id,
    required final String originalDocumentId,
    required final String signedUrl,
    final DateTime? completedAt,
  }) = _$SignedDocumentImpl;

  factory _SignedDocument.fromJson(Map<String, dynamic> json) =
      _$SignedDocumentImpl.fromJson;

  @override
  String get id;
  @override
  String get originalDocumentId;
  @override
  String get signedUrl;
  @override
  DateTime? get completedAt;

  /// Create a copy of SignedDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignedDocumentImplCopyWith<_$SignedDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
