import 'package:flutter/material.dart';

class SearchCityWidget extends StatelessWidget {
  SearchCityWidget({
    super.key,
    required this.width,
    required this.height,
    required this.searchController,
    required this.onTap,
  });

  final double width;
  final double height;

  final List<String> cities = [
    // Ciudades de México
    'Mexico',
    'Morelia',
    'Queretaro',
    'Veracruz',
    'Culiacan',
    'Toluca',
    'Acapulco',
    'Oaxaca',
    'Tuxtla Gutierrez',
    'Villahermosa',
    'Campeche',
    'Mazatlan',
    'Guadalajara',
    'Monterrey',
    'Puebla',
    'Tijuana',
    'Cancun',
    'Merida',
    'Chihuahua',
    // Ciudades del mundo
    'New York',
    'Los Angeles',
    'Paris',
    'London',
    'Tokyo',
    'Beijing',
    'Sydney',
    'Rio de Janeiro',
  ];

  final TextEditingController searchController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            controller: searchController,
            onTap: onTap,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              hintText: 'Search city',
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 16, 54, 75),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // crea un list view builder para mostrar las ciudades que coincidan con la búsqueda y se puedan seleccionar
        //que no se salga de los limites de la pantalla
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: cities.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       title: Text(cities[index]),
        //       onTap: () {
        //         searchController.text = cities[index];
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }
}
