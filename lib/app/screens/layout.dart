import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:vma/app/common/vma_toast.dart';
import 'package:vma/app/screens/camera/screen.dart';
import 'package:vma/app/screens/custom_appbar.dart';
import 'package:vma/app/screens/home/screen.dart';
import 'package:vma/app/screens/vaccination_plans/screen.dart';
import 'package:vma/app/screens/vaccination_schedules/screen.dart';
import 'package:vma/app/screens/warnings/screen.dart';
import 'package:vma/app/widgets/vma_navigation_bar.dart';
import 'package:vma/core/constants/api.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/notification_received_event.dart';
import 'package:vma/core/network/app_storage.dart';
import 'package:vma/core/repositories/notification_repository.dart';
import 'package:vma/core/models/notification.dart' as models;

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

int _isSelectedIndex = 0;

class _LayoutPageState extends State<LayoutPage> {
  final connectionOptions = HttpConnectionOptions;
  final httpOptions = HttpConnectionOptions(
    accessTokenFactory: () async {
      return await AppStorage.read(AppStorageKeys.token) ?? '';
    },
  );
  late final HubConnection _connection;

  final _notificationRepository = NotificationRepository();
  List<models.Notification> _notifications = [];

  @override
  void initState() {
    super.initState();
    EventManager.register((NotificationReceivedEvent event) {
      _getNotifications();
    });
    VMAToast.init(context);
    _connectToNotificationHub();
    _getNotifications();
  }

  @override
  void dispose() {
    EventManager.unregister(NotificationReceivedEvent);
    super.dispose();
  }

  static final List<NavigationItem> _navigationItems = <NavigationItem>[
    NavigationItem(
      icon: CupertinoIcons.chart_bar_fill,
      title: 'Trang chủ',
      screen: const HomeScreen(),
    ),
    NavigationItem(
      icon: Icons.medical_services,
      title: 'Kế hoạch tiêm phòng',
      screen: const VaccinationPlans(
        herdId: '7f131e70-cfdb-4655-9a84-0f40f8d5f022',
      ),
    ),
    NavigationItem(
      icon: CupertinoIcons.calendar,
      title: 'Lịch tiêm phòng',
      screen: const VaccinationSchedule(),
    ),
    NavigationItem(
      icon: CupertinoIcons.video_camera_solid,
      title: 'Chuồng',
      screen: const CameraScreen(),
    ),
    NavigationItem(
      icon: CupertinoIcons.exclamationmark_triangle_fill,
      title: 'Cảnh báo',
      screen: const WarningScreen(),
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _isSelectedIndex = index;
    });
  }

  void _connectToNotificationHub() {
    _connection = HubConnectionBuilder()
        .withUrl(Api.notificationHubUrl, options: httpOptions)
        .withAutomaticReconnect()
        .build();
    _connection.start();
    _registerEvents();
  }

  void _registerEvents() {
    _connection.on('ReceiveNotifications', (arguments) {
      debugPrint(arguments?.toString() ?? 'No data');
      _getNotifications();
    });
  }

  Future _getNotifications() async {
    final allNotifications =
        await _notificationRepository.getAllNotifications();
    setState(() {
      _notifications = allNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: customAppBar(
        context,
        _navigationItems[_isSelectedIndex].title,
        notifications: _notifications,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _navigationItems[_isSelectedIndex].screen,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme,
          highlightColor: Colors.transparent,
        ),
        child: VMANavigationBar(
          items: _navigationItems,
          onTabSelected: _onTabSelected,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String title;
  final Widget screen;

  NavigationItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}
