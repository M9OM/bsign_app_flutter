// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_field_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SignatureField _$SignatureFieldFromJson(Map<String, dynamic> json) {
  return _SignatureField.fromJson(json);
}

/// @nodoc
mixin _$SignatureField {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  String get recipientsUid => throw _privateConstructorUsedError;
  bool get requiredField => throw _privateConstructorUsedError;
  SignatureFieldType get type => throw _privateConstructorUsedError;

  /// Serializes this SignatureField to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignatureField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignatureFieldCopyWith<SignatureField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignatureFieldCopyWith<$Res> {
  factory $SignatureFieldCopyWith(
    SignatureField value,
    $Res Function(SignatureField) then,
  ) = _$SignatureFieldCopyWithImpl<$Res, SignatureField>;
  @useResult
  $Res call({
    String id,
    String documentId,
    String recipientId,
    int pageNumber,
    double x,
    double y,
    double width,
    double height,
    String? value,
    String recipientsUid,
    bool requiredField,
    SignatureFieldType type,
  });
}

/// @nodoc
class _$SignatureFieldCopyWithImpl<$Res, $Val extends SignatureField>
    implements $SignatureFieldCopyWith<$Res> {
  _$SignatureFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignatureField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? recipientId = null,
    Object? pageNumber = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? value = freezed,
    Object? recipientsUid = null,
    Object? requiredField = null,
    Object? type = null,
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
            recipientId:
                null == recipientId
                    ? _value.recipientId
                    : recipientId // ignore: cast_nullable_to_non_nullable
                        as String,
            pageNumber:
                null == pageNumber
                    ? _value.pageNumber
                    : pageNumber // ignore: cast_nullable_to_non_nullable
                        as int,
            x:
                null == x
                    ? _value.x
                    : x // ignore: cast_nullable_to_non_nullable
                        as double,
            y:
                null == y
                    ? _value.y
                    : y // ignore: cast_nullable_to_non_nullable
                        as double,
            width:
                null == width
                    ? _value.width
                    : width // ignore: cast_nullable_to_non_nullable
                        as double,
            height:
                null == height
                    ? _value.height
                    : height // ignore: cast_nullable_to_non_nullable
                        as double,
            value:
                freezed == value
                    ? _value.value
                    : value // ignore: cast_nullable_to_non_nullable
                        as String?,
            recipientsUid:
                null == recipientsUid
                    ? _value.recipientsUid
                    : recipientsUid // ignore: cast_nullable_to_non_nullable
                        as String,
            requiredField:
                null == requiredField
                    ? _value.requiredField
                    : requiredField // ignore: cast_nullable_to_non_nullable
                        as bool,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as SignatureFieldType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignatureFieldImplCopyWith<$Res>
    implements $SignatureFieldCopyWith<$Res> {
  factory _$$SignatureFieldImplCopyWith(
    _$SignatureFieldImpl value,
    $Res Function(_$SignatureFieldImpl) then,
  ) = __$$SignatureFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String documentId,
    String recipientId,
    int pageNumber,
    double x,
    double y,
    double width,
    double height,
    String? value,
    String recipientsUid,
    bool requiredField,
    SignatureFieldType type,
  });
}

/// @nodoc
class __$$SignatureFieldImplCopyWithImpl<$Res>
    extends _$SignatureFieldCopyWithImpl<$Res, _$SignatureFieldImpl>
    implements _$$SignatureFieldImplCopyWith<$Res> {
  __$$SignatureFieldImplCopyWithImpl(
    _$SignatureFieldImpl _value,
    $Res Function(_$SignatureFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignatureField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? recipientId = null,
    Object? pageNumber = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? value = freezed,
    Object? recipientsUid = null,
    Object? requiredField = null,
    Object? type = null,
  }) {
    return _then(
      _$SignatureFieldImpl(
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
        recipientId:
            null == recipientId
                ? _value.recipientId
                : recipientId // ignore: cast_nullable_to_non_nullable
                    as String,
        pageNumber:
            null == pageNumber
                ? _value.pageNumber
                : pageNumber // ignore: cast_nullable_to_non_nullable
                    as int,
        x:
            null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                    as double,
        y:
            null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                    as double,
        width:
            null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                    as double,
        height:
            null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                    as double,
        value:
            freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                    as String?,
        recipientsUid:
            null == recipientsUid
                ? _value.recipientsUid
                : recipientsUid // ignore: cast_nullable_to_non_nullable
                    as String,
        requiredField:
            null == requiredField
                ? _value.requiredField
                : requiredField // ignore: cast_nullable_to_non_nullable
                    as bool,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as SignatureFieldType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignatureFieldImpl implements _SignatureField {
  const _$SignatureFieldImpl({
    required this.id,
    required this.documentId,
    required this.recipientId,
    required this.pageNumber,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.value,
    required this.recipientsUid,
    this.requiredField = true,
    required this.type,
  });

  factory _$SignatureFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignatureFieldImplFromJson(json);

  @override
  final String id;
  @override
  final String documentId;
  @override
  final String recipientId;
  @override
  final int pageNumber;
  @override
  final double x;
  @override
  final double y;
  @override
  final double width;
  @override
  final double height;
  @override
  final String? value;
  @override
  final String recipientsUid;
  @override
  @JsonKey()
  final bool requiredField;
  @override
  final SignatureFieldType type;

  @override
  String toString() {
    return 'SignatureField(id: $id, documentId: $documentId, recipientId: $recipientId, pageNumber: $pageNumber, x: $x, y: $y, width: $width, height: $height, value: $value, recipientsUid: $recipientsUid, requiredField: $requiredField, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignatureFieldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.recipientsUid, recipientsUid) ||
                other.recipientsUid == recipientsUid) &&
            (identical(other.requiredField, requiredField) ||
                other.requiredField == requiredField) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    documentId,
    recipientId,
    pageNumber,
    x,
    y,
    width,
    height,
    value,
    recipientsUid,
    requiredField,
    type,
  );

  /// Create a copy of SignatureField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignatureFieldImplCopyWith<_$SignatureFieldImpl> get copyWith =>
      __$$SignatureFieldImplCopyWithImpl<_$SignatureFieldImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SignatureFieldImplToJson(this);
  }
}

abstract class _SignatureField implements SignatureField {
  const factory _SignatureField({
    required final String id,
    required final String documentId,
    required final String recipientId,
    required final int pageNumber,
    required final double x,
    required final double y,
    required final double width,
    required final double height,
    final String? value,
    required final String recipientsUid,
    final bool requiredField,
    required final SignatureFieldType type,
  }) = _$SignatureFieldImpl;

  factory _SignatureField.fromJson(Map<String, dynamic> json) =
      _$SignatureFieldImpl.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  String get recipientId;
  @override
  int get pageNumber;
  @override
  double get x;
  @override
  double get y;
  @override
  double get width;
  @override
  double get height;
  @override
  String? get value;
  @override
  String get recipientsUid;
  @override
  bool get requiredField;
  @override
  SignatureFieldType get type;

  /// Create a copy of SignatureField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignatureFieldImplCopyWith<_$SignatureFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
