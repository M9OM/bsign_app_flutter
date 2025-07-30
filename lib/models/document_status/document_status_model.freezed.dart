// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentStatusModel _$DocumentStatusModelFromJson(Map<String, dynamic> json) {
  return _DocumentStatusModel.fromJson(json);
}

/// @nodoc
mixin _$DocumentStatusModel {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  DocumentStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  int? get totalRecipients => throw _privateConstructorUsedError;
  int? get signedCount => throw _privateConstructorUsedError;
  int? get pendingCount => throw _privateConstructorUsedError;

  /// Serializes this DocumentStatusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentStatusModelCopyWith<DocumentStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentStatusModelCopyWith<$Res> {
  factory $DocumentStatusModelCopyWith(
    DocumentStatusModel value,
    $Res Function(DocumentStatusModel) then,
  ) = _$DocumentStatusModelCopyWithImpl<$Res, DocumentStatusModel>;
  @useResult
  $Res call({
    String id,
    String documentId,
    DocumentStatus status,
    DateTime createdAt,
    DateTime? sentAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    String createdBy,
    int? totalRecipients,
    int? signedCount,
    int? pendingCount,
  });
}

/// @nodoc
class _$DocumentStatusModelCopyWithImpl<$Res, $Val extends DocumentStatusModel>
    implements $DocumentStatusModelCopyWith<$Res> {
  _$DocumentStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? sentAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdBy = null,
    Object? totalRecipients = freezed,
    Object? signedCount = freezed,
    Object? pendingCount = freezed,
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
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as DocumentStatus,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            sentAt:
                freezed == sentAt
                    ? _value.sentAt
                    : sentAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            completedAt:
                freezed == completedAt
                    ? _value.completedAt
                    : completedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            expiresAt:
                freezed == expiresAt
                    ? _value.expiresAt
                    : expiresAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdBy:
                null == createdBy
                    ? _value.createdBy
                    : createdBy // ignore: cast_nullable_to_non_nullable
                        as String,
            totalRecipients:
                freezed == totalRecipients
                    ? _value.totalRecipients
                    : totalRecipients // ignore: cast_nullable_to_non_nullable
                        as int?,
            signedCount:
                freezed == signedCount
                    ? _value.signedCount
                    : signedCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            pendingCount:
                freezed == pendingCount
                    ? _value.pendingCount
                    : pendingCount // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentStatusModelImplCopyWith<$Res>
    implements $DocumentStatusModelCopyWith<$Res> {
  factory _$$DocumentStatusModelImplCopyWith(
    _$DocumentStatusModelImpl value,
    $Res Function(_$DocumentStatusModelImpl) then,
  ) = __$$DocumentStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String documentId,
    DocumentStatus status,
    DateTime createdAt,
    DateTime? sentAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    String createdBy,
    int? totalRecipients,
    int? signedCount,
    int? pendingCount,
  });
}

/// @nodoc
class __$$DocumentStatusModelImplCopyWithImpl<$Res>
    extends _$DocumentStatusModelCopyWithImpl<$Res, _$DocumentStatusModelImpl>
    implements _$$DocumentStatusModelImplCopyWith<$Res> {
  __$$DocumentStatusModelImplCopyWithImpl(
    _$DocumentStatusModelImpl _value,
    $Res Function(_$DocumentStatusModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? sentAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdBy = null,
    Object? totalRecipients = freezed,
    Object? signedCount = freezed,
    Object? pendingCount = freezed,
  }) {
    return _then(
      _$DocumentStatusModelImpl(
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
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as DocumentStatus,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        sentAt:
            freezed == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        completedAt:
            freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        expiresAt:
            freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdBy:
            null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                    as String,
        totalRecipients:
            freezed == totalRecipients
                ? _value.totalRecipients
                : totalRecipients // ignore: cast_nullable_to_non_nullable
                    as int?,
        signedCount:
            freezed == signedCount
                ? _value.signedCount
                : signedCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        pendingCount:
            freezed == pendingCount
                ? _value.pendingCount
                : pendingCount // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentStatusModelImpl implements _DocumentStatusModel {
  const _$DocumentStatusModelImpl({
    required this.id,
    required this.documentId,
    required this.status,
    required this.createdAt,
    this.sentAt,
    this.completedAt,
    this.expiresAt,
    required this.createdBy,
    this.totalRecipients,
    this.signedCount,
    this.pendingCount,
  });

  factory _$DocumentStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentStatusModelImplFromJson(json);

  @override
  final String id;
  @override
  final String documentId;
  @override
  final DocumentStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? expiresAt;
  @override
  final String createdBy;
  @override
  final int? totalRecipients;
  @override
  final int? signedCount;
  @override
  final int? pendingCount;

  @override
  String toString() {
    return 'DocumentStatusModel(id: $id, documentId: $documentId, status: $status, createdAt: $createdAt, sentAt: $sentAt, completedAt: $completedAt, expiresAt: $expiresAt, createdBy: $createdBy, totalRecipients: $totalRecipients, signedCount: $signedCount, pendingCount: $pendingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentStatusModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.totalRecipients, totalRecipients) ||
                other.totalRecipients == totalRecipients) &&
            (identical(other.signedCount, signedCount) ||
                other.signedCount == signedCount) &&
            (identical(other.pendingCount, pendingCount) ||
                other.pendingCount == pendingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    documentId,
    status,
    createdAt,
    sentAt,
    completedAt,
    expiresAt,
    createdBy,
    totalRecipients,
    signedCount,
    pendingCount,
  );

  /// Create a copy of DocumentStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentStatusModelImplCopyWith<_$DocumentStatusModelImpl> get copyWith =>
      __$$DocumentStatusModelImplCopyWithImpl<_$DocumentStatusModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentStatusModelImplToJson(this);
  }
}

abstract class _DocumentStatusModel implements DocumentStatusModel {
  const factory _DocumentStatusModel({
    required final String id,
    required final String documentId,
    required final DocumentStatus status,
    required final DateTime createdAt,
    final DateTime? sentAt,
    final DateTime? completedAt,
    final DateTime? expiresAt,
    required final String createdBy,
    final int? totalRecipients,
    final int? signedCount,
    final int? pendingCount,
  }) = _$DocumentStatusModelImpl;

  factory _DocumentStatusModel.fromJson(Map<String, dynamic> json) =
      _$DocumentStatusModelImpl.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  DocumentStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get expiresAt;
  @override
  String get createdBy;
  @override
  int? get totalRecipients;
  @override
  int? get signedCount;
  @override
  int? get pendingCount;

  /// Create a copy of DocumentStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentStatusModelImplCopyWith<_$DocumentStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecipientStatus _$RecipientStatusFromJson(Map<String, dynamic> json) {
  return _RecipientStatus.fromJson(json);
}

/// @nodoc
mixin _$RecipientStatus {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  String get recipientEmail => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  SigningStatus get status => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get viewedAt => throw _privateConstructorUsedError;
  DateTime? get signedAt => throw _privateConstructorUsedError;
  String? get declineReason => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  DateTime? get tokenExpiresAt => throw _privateConstructorUsedError;

  /// Serializes this RecipientStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipientStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipientStatusCopyWith<RecipientStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientStatusCopyWith<$Res> {
  factory $RecipientStatusCopyWith(
    RecipientStatus value,
    $Res Function(RecipientStatus) then,
  ) = _$RecipientStatusCopyWithImpl<$Res, RecipientStatus>;
  @useResult
  $Res call({
    String id,
    String documentId,
    String recipientEmail,
    String recipientName,
    SigningStatus status,
    DateTime? sentAt,
    DateTime? viewedAt,
    DateTime? signedAt,
    String? declineReason,
    String? accessToken,
    DateTime? tokenExpiresAt,
  });
}

/// @nodoc
class _$RecipientStatusCopyWithImpl<$Res, $Val extends RecipientStatus>
    implements $RecipientStatusCopyWith<$Res> {
  _$RecipientStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipientStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? recipientEmail = null,
    Object? recipientName = null,
    Object? status = null,
    Object? sentAt = freezed,
    Object? viewedAt = freezed,
    Object? signedAt = freezed,
    Object? declineReason = freezed,
    Object? accessToken = freezed,
    Object? tokenExpiresAt = freezed,
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
            recipientEmail:
                null == recipientEmail
                    ? _value.recipientEmail
                    : recipientEmail // ignore: cast_nullable_to_non_nullable
                        as String,
            recipientName:
                null == recipientName
                    ? _value.recipientName
                    : recipientName // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as SigningStatus,
            sentAt:
                freezed == sentAt
                    ? _value.sentAt
                    : sentAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            viewedAt:
                freezed == viewedAt
                    ? _value.viewedAt
                    : viewedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            signedAt:
                freezed == signedAt
                    ? _value.signedAt
                    : signedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            declineReason:
                freezed == declineReason
                    ? _value.declineReason
                    : declineReason // ignore: cast_nullable_to_non_nullable
                        as String?,
            accessToken:
                freezed == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String?,
            tokenExpiresAt:
                freezed == tokenExpiresAt
                    ? _value.tokenExpiresAt
                    : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipientStatusImplCopyWith<$Res>
    implements $RecipientStatusCopyWith<$Res> {
  factory _$$RecipientStatusImplCopyWith(
    _$RecipientStatusImpl value,
    $Res Function(_$RecipientStatusImpl) then,
  ) = __$$RecipientStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String documentId,
    String recipientEmail,
    String recipientName,
    SigningStatus status,
    DateTime? sentAt,
    DateTime? viewedAt,
    DateTime? signedAt,
    String? declineReason,
    String? accessToken,
    DateTime? tokenExpiresAt,
  });
}

/// @nodoc
class __$$RecipientStatusImplCopyWithImpl<$Res>
    extends _$RecipientStatusCopyWithImpl<$Res, _$RecipientStatusImpl>
    implements _$$RecipientStatusImplCopyWith<$Res> {
  __$$RecipientStatusImplCopyWithImpl(
    _$RecipientStatusImpl _value,
    $Res Function(_$RecipientStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipientStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? recipientEmail = null,
    Object? recipientName = null,
    Object? status = null,
    Object? sentAt = freezed,
    Object? viewedAt = freezed,
    Object? signedAt = freezed,
    Object? declineReason = freezed,
    Object? accessToken = freezed,
    Object? tokenExpiresAt = freezed,
  }) {
    return _then(
      _$RecipientStatusImpl(
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
        recipientEmail:
            null == recipientEmail
                ? _value.recipientEmail
                : recipientEmail // ignore: cast_nullable_to_non_nullable
                    as String,
        recipientName:
            null == recipientName
                ? _value.recipientName
                : recipientName // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as SigningStatus,
        sentAt:
            freezed == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        viewedAt:
            freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        signedAt:
            freezed == signedAt
                ? _value.signedAt
                : signedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        declineReason:
            freezed == declineReason
                ? _value.declineReason
                : declineReason // ignore: cast_nullable_to_non_nullable
                    as String?,
        accessToken:
            freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String?,
        tokenExpiresAt:
            freezed == tokenExpiresAt
                ? _value.tokenExpiresAt
                : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipientStatusImpl implements _RecipientStatus {
  const _$RecipientStatusImpl({
    required this.id,
    required this.documentId,
    required this.recipientEmail,
    required this.recipientName,
    required this.status,
    this.sentAt,
    this.viewedAt,
    this.signedAt,
    this.declineReason,
    this.accessToken,
    this.tokenExpiresAt,
  });

  factory _$RecipientStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipientStatusImplFromJson(json);

  @override
  final String id;
  @override
  final String documentId;
  @override
  final String recipientEmail;
  @override
  final String recipientName;
  @override
  final SigningStatus status;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? viewedAt;
  @override
  final DateTime? signedAt;
  @override
  final String? declineReason;
  @override
  final String? accessToken;
  @override
  final DateTime? tokenExpiresAt;

  @override
  String toString() {
    return 'RecipientStatus(id: $id, documentId: $documentId, recipientEmail: $recipientEmail, recipientName: $recipientName, status: $status, sentAt: $sentAt, viewedAt: $viewedAt, signedAt: $signedAt, declineReason: $declineReason, accessToken: $accessToken, tokenExpiresAt: $tokenExpiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipientStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.recipientEmail, recipientEmail) ||
                other.recipientEmail == recipientEmail) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.signedAt, signedAt) ||
                other.signedAt == signedAt) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenExpiresAt, tokenExpiresAt) ||
                other.tokenExpiresAt == tokenExpiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    documentId,
    recipientEmail,
    recipientName,
    status,
    sentAt,
    viewedAt,
    signedAt,
    declineReason,
    accessToken,
    tokenExpiresAt,
  );

  /// Create a copy of RecipientStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipientStatusImplCopyWith<_$RecipientStatusImpl> get copyWith =>
      __$$RecipientStatusImplCopyWithImpl<_$RecipientStatusImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipientStatusImplToJson(this);
  }
}

abstract class _RecipientStatus implements RecipientStatus {
  const factory _RecipientStatus({
    required final String id,
    required final String documentId,
    required final String recipientEmail,
    required final String recipientName,
    required final SigningStatus status,
    final DateTime? sentAt,
    final DateTime? viewedAt,
    final DateTime? signedAt,
    final String? declineReason,
    final String? accessToken,
    final DateTime? tokenExpiresAt,
  }) = _$RecipientStatusImpl;

  factory _RecipientStatus.fromJson(Map<String, dynamic> json) =
      _$RecipientStatusImpl.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  String get recipientEmail;
  @override
  String get recipientName;
  @override
  SigningStatus get status;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get viewedAt;
  @override
  DateTime? get signedAt;
  @override
  String? get declineReason;
  @override
  String? get accessToken;
  @override
  DateTime? get tokenExpiresAt;

  /// Create a copy of RecipientStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipientStatusImplCopyWith<_$RecipientStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
