import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:plantify_mobile/models/tropical_plant.dart';
import 'package:plantify_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:plantify_mobile/screens/detail_tropicalplant.dart';

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
                    itemBuilder: (_, index) {
                      final plant = snapshot.data![index].fields;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TropicalPlantDetailPage(
                                    plantId: snapshot.data![index].pk,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plant.name,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${plant.price}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff4CAF50),
                                        ),
                                      ),
                                      Text(
                                        "${plant.weight} kg",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    plant.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            }));
  }
}
