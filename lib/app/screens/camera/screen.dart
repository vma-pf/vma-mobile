import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/camera/widgets/cage.dart';
import 'package:vma/app/screens/camera/widgets/live_video.dart';
import 'package:vma/core/view_models/camera_model.dart';
import 'package:vma/core/models/cage.dart' as models;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends VMAState<CameraScreen> {
  final _model = CameraModel();

  @override
  void initState() {
    super.initState();
    _model.loadCages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModel<CameraModel>(
        model: _model,
        child: ScopedModelDescendant<CameraModel>(
          builder: (context, child, model) {
            return FutureBuilder(
              future: model.cages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return _buildCages(snapshot.data ?? []);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCages(List<models.Cage> cages) {
    if (cages.isEmpty) {
      return const Center(child: Text('Không có camera nào'));
    }

    return Center(
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: cages.map((cage) {
          return Cage(
            cageCode: cage.code,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LiveVideo(cameraId: cage.cameraId ?? '');
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
