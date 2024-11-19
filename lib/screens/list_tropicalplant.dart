import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:plantify_mobile/models/tropical_plant.dart';
import 'package:plantify_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class TropicalPlantPage extends StatefulWidget {
  const TropicalPlantPage({super.key});

  @override
  State<TropicalPlantPage> createState() => _TropicalPlantPageState();
}

class _TropicalPlantPageState extends State<TropicalPlantPage> {
  Future<List<TropicalPlant>> fetchTropicalPlants(CookieRequest request) async {
    final response =
        await request.get('http://127.0.0.1:8000/tropical-plant-json/');

    var data = response;

    List<TropicalPlant> tropicalPlants = [];
    for (var d in data) {
      if (d != null) {
        tropicalPlants.add(TropicalPlant.fromJson(d));
      }
    }
    return tropicalPlants;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tropical Plants List'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchTropicalPlants(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        'Belum ada data tanaman tropis pada Plantify',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.name}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.price}"),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.description}"),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.weight}"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
