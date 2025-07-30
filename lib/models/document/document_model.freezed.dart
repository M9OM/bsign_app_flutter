// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return _Document.fromJson(json);
}

/// @nodoc
mixin _$Document {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get pages => throw _privateConstructorUsedError;
  String get file_url => throw _privateConstructorUsedError;
  DateTime? get uploaded_at => throw _privateConstructorUsedError;
  String? get type =>
      throw _privateConstructorUsedError; // e.g., 'pdf', 'image'
  String? get created_by => throw _privateConstructorUsedError;

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call({
    String? id,
    String name,
    int pages,
    String file_url,
    DateTime? uploaded_at,
    String? type,
    String? created_by,
  });
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? pages = null,
    Object? file_url = null,
    Object? uploaded_at = freezed,
    Object? type = freezed,
    Object? created_by = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            pages:
                null == pages
                    ? _value.pages
                    : pages // ignore: cast_nullable_to_non_nullable
                        as int,
            file_url:
                null == file_url
                    ? _value.file_url
                    : file_url // ignore: cast_nullable_to_non_nullable
                        as String,
            uploaded_at:
                freezed == uploaded_at
                    ? _value.uploaded_at
                    : uploaded_at // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String?,
            created_by:
                freezed == created_by
                    ? _value.created_by
                    : created_by // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
    _$DocumentImpl value,
    $Res Function(_$DocumentImpl) then,
  ) = __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String name,
    int pages,
    String file_url,
    DateTime? uploaded_at,
    String? type,
    String? created_by,
  });
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
    _$DocumentImpl _value,
    $Res Function(_$DocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? pages = null,
    Object? file_url = null,
    Object? uploaded_at = freezed,
    Object? type = freezed,
    Object? created_by = freezed,
  }) {
    return _then(
      _$DocumentImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        pages:
            null == pages
                ? _value.pages
                : pages // ignore: cast_nullable_to_non_nullable
                    as int,
        file_url:
            null == file_url
                ? _value.file_url
                : file_url // ignore: cast_nullable_to_non_nullable
                    as String,
        uploaded_at:
            freezed == uploaded_at
                ? _value.uploaded_at
                : uploaded_at // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String?,
        created_by:
            freezed == created_by
                ? _value.created_by
                : created_by // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl implements _Document {
  const _$DocumentImpl({
    this.id,
    required this.name,
    required this.pages,
    required this.file_url,
    this.uploaded_at,
    this.type,
    this.created_by,
  });

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final int pages;
  @override
  final String file_url;
  @override
  final DateTime? uploaded_at;
  @override
  final String? type;
  // e.g., 'pdf', 'image'
  @override
  final String? created_by;

  @override
  String toString() {
    return 'Document(id: $id, name: $name, pages: $pages, file_url: $file_url, uploaded_at: $uploaded_at, type: $type, created_by: $created_by)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.file_url, file_url) ||
                other.file_url == file_url) &&
            (identical(other.uploaded_at, uploaded_at) ||
                other.uploaded_at == uploaded_at) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    pages,
    file_url,
    uploaded_at,
    type,
    created_by,
  );

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(this);
  }
}

abstract class _Document implements Document {
  const factory _Document({
    final String? id,
    required final String name,
    required final int pages,
    required final String file_url,
    final DateTime? uploaded_at,
    final String? type,
    final String? created_by,
  }) = _$DocumentImpl;

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  int get pages;
  @override
  String get file_url;
  @override
  DateTime? get uploaded_at;
  @override
  String? get type; // e.g., 'pdf', 'image'
  @override
  String? get created_by;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
