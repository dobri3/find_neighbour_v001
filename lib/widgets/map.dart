import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:find_neighbour_v001/styles/app_colors.dart';

class MapWidget extends StatefulWidget {
  final double width;
  final double height;
  final Function(LatLng? point, String address)? onPointSelected;
  final LatLng? initialCenter;
  final double initialZoom;
  final bool isSelectable;
  final LatLng? staticMarkerPoint;
  final String? staticAddress;
  final LatLng? initialMarkerPoint;
  final String? initialAddress;

  const MapWidget({
    super.key,
    required this.width,
    required this.height,
    this.onPointSelected,
    this.initialCenter,
    this.initialZoom = 5,
    this.isSelectable = true,
    this.staticMarkerPoint,
    this.staticAddress,
    this.initialMarkerPoint,
    this.initialAddress,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final MapController _mapController;
  LatLng? _selectedPoint;
  String _selectedAddress = '';
  bool _isLoadingAddress = false;
  final List<Marker> _markers = [];

  static const String _geocodeApiKey = '6910b59539db4010801646wnk990ed3';

  final List<String> _tileServers = [
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
    'https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png',
  ];

  int _currentTileServer = 1;

  @override
  void initState() {
    _mapController = MapController();
    _initializeMap();
    super.initState();
  }

  void _initializeMap() {
    if (widget.isSelectable) {
      // Режим выбора - устанавливаем начальную точку если передана
      if (widget.initialMarkerPoint != null) {
        _selectedPoint = widget.initialMarkerPoint;
        _selectedAddress = widget.initialAddress ?? '';

        // Добавляем маркер (красный для обоих случаев)
        _addMarker(widget.initialMarkerPoint!);

        // Если адрес не передан, получаем его через геокодирование
        if (widget.initialAddress == null) {
          _getAddressFromGeocode(widget.initialMarkerPoint!);
        }

        // Перемещаем карту к маркеру
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(widget.initialMarkerPoint!, widget.initialZoom);
        });
      }
    } else {
      // Статичный режим - добавляем статичный маркер
      if (widget.staticMarkerPoint != null) {
        _selectedPoint = widget.staticMarkerPoint;
        _selectedAddress = widget.staticAddress ?? '';

        // Добавляем маркер (зеленый для статичного режима)
        _addStaticMarker(widget.staticMarkerPoint!);

        // Если адрес не передан, получаем его через геокодирование
        if (widget.staticAddress == null) {
          _getAddressFromGeocode(widget.staticMarkerPoint!);
        }

        // Перемещаем карту к маркеру
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(widget.staticMarkerPoint!, widget.initialZoom);
        });
      }
    }
  }

  void _addMarker(LatLng point) {
    // Очищаем все маркеры
    _markers.clear();

    // Добавляем красный маркер (одинаковый для initial и selected)
    _markers.add(
      Marker(
        key: const Key('main_marker'),
        width: 50.0,
        height: 50.0,
        point: point,
        child: Icon(
          Icons.location_pin,
          color: Colors.red, // Всегда красный для режима выбора
          size: 50,
        ),
      ),
    );

    setState(() {});
  }

  void _addStaticMarker(LatLng point) {
    // Очищаем все маркеры
    _markers.clear();

    // Добавляем зеленый маркер для статичного режима
    _markers.add(
      Marker(
        key: const Key('static_marker'),
        width: 50.0,
        height: 50.0,
        point: point,
        child: Icon(
          Icons.location_pin,
          color: AppColors.teal, // Зеленый для статичного режима
          size: 50,
        ),
      ),
    );

    setState(() {});
  }

  void _onMarkerTap(LatLng point) async {
    if (widget.isSelectable) {
      await _selectPoint(point);
    }
  }

  Future<void> _selectPoint(LatLng point) async {
    if (!widget.isSelectable) return;

    setState(() {
      _selectedPoint = point;
      _isLoadingAddress = true;
    });

    // Используем тот же метод для добавления маркера
    _addMarker(point);
    await _getAddressFromGeocode(point);

    // Вызываем callback если он задан
    if (widget.onPointSelected != null) {
      widget.onPointSelected!(_selectedPoint, _selectedAddress);
    }
  }

  // Обратное геокодирование через geocode.maps.co с API ключом
  Future<void> _getAddressFromGeocode(LatLng point) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://geocode.maps.co/reverse?lat=${point.latitude}&lon=${point.longitude}&api_key=$_geocodeApiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['display_name'] != null) {
          final address = data['display_name'];

          setState(() {
            _selectedAddress = address;
            _isLoadingAddress = false;
          });
        } else {
          setState(() {
            _selectedAddress = 'Адрес не найден в базе geocode.maps.co';
            _isLoadingAddress = false;
          });
        }
      } else {
        setState(() {
          _selectedAddress =
              'Ошибка сервера geocode.maps.co: ${response.statusCode}';
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Ошибка сети geocode.maps.co: $e';
        _isLoadingAddress = false;
      });
    }
  }

  // Поиск адреса через geocode.maps.co с API ключом
  Future<void> _searchAddress(String query) async {
    if (query.isEmpty || !widget.isSelectable) return;

    setState(() {
      _isLoadingAddress = true;
      _selectedAddress = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://geocode.maps.co/search?q=${Uri.encodeComponent(query)}&api_key=$_geocodeApiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        if (data.isNotEmpty) {
          final result = data[0];
          final lat = double.parse(result['lat']);
          final lon = double.parse(result['lon']);
          final point = LatLng(lat, lon);
          final address = result['display_name'];

          await _selectPoint(point);
          _mapController.move(point, 15.0);

          setState(() {
            _selectedAddress = address;
          });
        } else {
          setState(() {
            _selectedAddress = 'Адрес "$query" не найден в geocode.maps.co';
            _isLoadingAddress = false;
          });
        }
      } else {
        setState(() {
          _selectedAddress =
              'Ошибка поиска geocode.maps.co: ${response.statusCode}';
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Ошибка сети geocode.maps.co при поиске: $e';
        _isLoadingAddress = false;
      });
    }
  }

  void _clearSelection() {
    if (!widget.isSelectable) return;

    setState(() {
      _selectedPoint = null;
      _selectedAddress = '';
      _markers.clear(); // Очищаем все маркеры
    });

    // Вызываем callback если он задан
    if (widget.onPointSelected != null) {
      widget.onPointSelected!(null, '');
    }
  }

  void _changeTileServer() {
    setState(() {
      _currentTileServer = (_currentTileServer + 1) % _tileServers.length;
    });
  }

  String _getCurrentTileServerName() {
    switch (_currentTileServer) {
      case 0:
        return 'OpenStreetMap';
      case 1:
        return 'ArcGIS World Street';
      case 2:
        return 'CartoDB Light';
      case 3:
        return 'Stamen Toner';
      default:
        return 'Unknown';
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Панель поиска (только для режима выбора)
            if (widget.isSelectable) _buildSearchPanel(),
            // Панель информации (для статичного режима)
            if (!widget.isSelectable && _selectedAddress.isNotEmpty)
              _buildInfoPanel(),
            // Панель выбранного адреса (для режима выбора)
            if (widget.isSelectable && _selectedAddress.isNotEmpty)
              _buildAddressPanel(),
            // Карта
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.transparentBlue,
                  border: Border(
                    left: BorderSide(color: AppColors.borderTeal),
                    right: BorderSide(color: AppColors.borderTeal),
                  ),
                ),
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: widget.initialCenter ??
                            const LatLng(55.755793, 37.617134),
                        initialZoom: widget.initialZoom,
                        onTap: widget.isSelectable
                            ? (tapPosition, point) {
                                _selectPoint(point);
                              }
                            : null,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: _tileServers[_currentTileServer],
                          subdomains: ['a', 'b', 'c'],
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: _markers),
                      ],
                    ),
                    // Индикатор загрузки
                    if (_isLoadingAddress)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
            // Панель управления
            _buildControlPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchPanel() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: AppContainerStyles.sectionContainer.copyWith(
        color: AppColors.transparentBlue,
        border: Border(
          top: BorderSide(color: AppColors.borderTeal),
          left: BorderSide(color: AppColors.borderTeal),
          right: BorderSide(color: AppColors.borderTeal),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: AppContainerStyles.textInput('Введите адрес'),
              onSubmitted: _searchAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: AppContainerStyles.sectionContainer.copyWith(
        color: AppColors.transparentBlue,
        border: Border(
          top: BorderSide(color: AppColors.borderTeal),
          left: BorderSide(color: AppColors.borderTeal),
          right: BorderSide(color: AppColors.borderTeal),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.teal, size: 18),
              SizedBox(width: 6),
              Text(
                'Адрес:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.teal,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            _selectedAddress,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.gray400,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_selectedPoint != null) ...[
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.gps_fixed, size: 10, color: AppColors.gray400),
                SizedBox(width: 4),
                Text(
                  'Координаты: ${_selectedPoint!.latitude.toStringAsFixed(6)}, ${_selectedPoint!.longitude.toStringAsFixed(6)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: AppContainerStyles.sectionContainer.copyWith(
        color: AppColors.transparentBlue,
        border: Border(
          left: BorderSide(color: AppColors.borderTeal),
          right: BorderSide(color: AppColors.borderTeal),
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.teal, size: 18),
              SizedBox(width: 6),
              Text(
                'Адрес:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.teal,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            _selectedAddress,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.gray400,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_selectedPoint != null) ...[
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.gps_fixed, size: 10, color: AppColors.gray400),
                SizedBox(width: 4),
                Text(
                  'Координаты: ${_selectedPoint!.latitude.toStringAsFixed(6)}, ${_selectedPoint!.longitude.toStringAsFixed(6)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.transparentBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.borderTeal),
          left: BorderSide(color: AppColors.borderTeal),
          right: BorderSide(color: AppColors.borderTeal),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(
            icon: Icons.map,
            label: 'Сменить карту',
            onPressed: _changeTileServer,
            color: AppColors.gray400,
          ),
          if (widget.isSelectable)
            _buildControlButton(
              icon: Icons.clear,
              label: 'Очистить',
              onPressed: _clearSelection,
              color: Color(0xFFEF4444),
            ),
          _buildControlButton(
            icon: Icons.center_focus_strong,
            label: 'По центру',
            onPressed: () {
              final centerPoint = widget.isSelectable
                  ? (_selectedPoint ??
                      widget.initialCenter ??
                      const LatLng(55.755793, 37.617134))
                  : (widget.staticMarkerPoint ??
                      widget.initialCenter ??
                      const LatLng(55.755793, 37.617134));
              _mapController.move(centerPoint, 10.0);
            },
            color: Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(icon, size: 18),
            onPressed: onPressed,
            color: color,
            padding: EdgeInsets.zero,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

