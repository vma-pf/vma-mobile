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
import 'package:vma/app/widgets/vma_navigation_bar.dart';
import 'package:vma/core/constants/api.dart';
import 'package:vma/core/enums/app_storage_keys.dart';
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
    VMAToast.init(context);
    _connectToNotificationHub();
    _getNotifications();
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
        herdId: 'd869bc09-7e82-4b2a-acaa-cb3b5c9332e7',
      ),
    ),
    NavigationItem(
      icon: CupertinoIcons.calendar,
      title: 'Lịch tiêm phòng',
      screen: const VaccinationSchedule(),
    ),
    NavigationItem(
      icon: CupertinoIcons.video_camera_solid,
      title: 'Camera',
      screen: const CameraScreen(),
    ),
    NavigationItem(
      icon: CupertinoIcons.bell_fill,
      title: 'Cảnh báo',
      screen: const VaccinationPlans(
        herdId: '361fe41f-4c80-45b8-b2c5-1f65021b64e7',
      ),
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
