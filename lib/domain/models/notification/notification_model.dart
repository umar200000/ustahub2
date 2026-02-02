import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_model.g.dart';

abstract class Notification
    implements Built<Notification, NotificationBuilder> {
  Notification._();

  factory Notification([Function(NotificationBuilder b) updates]) =
      _$Notification;

  @BuiltValueField(wireName: 'results')
  BuiltList<NotificationModel>? get results;
  @BuiltValueField(wireName: 'total_pages')
  int? get totalPages;
  @BuiltValueField(wireName: 'page')
  int? get page;
  @BuiltValueField(wireName: 'count')
  int? get count;

  static Serializer<Notification> get serializer => _$notificationSerializer;
}

abstract class NotificationModel
    implements Built<NotificationModel, NotificationModelBuilder> {
  NotificationModel._();

  factory NotificationModel([Function(NotificationModelBuilder b) updates]) =
      _$NotificationModel;

  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'title')
  String? get title;
  @BuiltValueField(wireName: 'body')
  String? get body;
  @BuiltValueField(wireName: 'is_read')
  bool? get isRead;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'date')
  String? get date;

  static Serializer<NotificationModel> get serializer =>
      _$notificationModelSerializer;
}
