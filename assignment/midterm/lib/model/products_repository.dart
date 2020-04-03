// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Hotel> loadHotels() {
    const allHotels = <Hotel>[
      Hotel(
        id: 0,
        isFeatured: true,
        name: 'Polonia Hotel',
        location: 'Basztowa 25, Krakow, Poland',
        number: '48 22 318 28 00',
        description: 'Featuring storage for belongings, an elevator and a chapel, Hotel Polonia is located in Grzegórzki district, 13 km from Wieliczka Salt Mine. This is a 4-storey historical-style building. Guests can enjoy surroundings and stunning views over Tatra Mountains and Andes Mountains.',
        stars: 3,
      ),
    ];
    return allHotels;
  }
}
