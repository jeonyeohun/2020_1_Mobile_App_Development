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
        name: 'Polonia Hotel',
        location: 'Basztowa 25, Krakow, Poland',
        number: '+48-22-318-2800',
        description: 'Featuring storage for belongings, an elevator and a chapel, Hotel Polonia is located in Grzegórzki district, 13 km from Wieliczka Salt Mine. This is a 4-storey historical-style building. Guests can enjoy surroundings and stunning views over Tatra Mountains and Andes Mountains.',
        stars: 3,
      ),
      Hotel(
        id: 1,
        name: 'Gyeongju Hilton',
        location: "484-7, Bomun-ro Gyeongju, 38117, KR",
        number: '+82-54-7457788',
        description: "Surrounded by scenic countryside next to Lake Bomun, our hotel is less than a kilometer from Gyeongju World Amusement Park. We're nine kilometers from the historic city of Gyeongju, with a free shuttle to Singyeongju KTX rail station. Enjoy our fitness center, squash court, and indoor and outdoor pools with private cabanas.",
        stars: 5,
      ),
      Hotel(
        id: 2,
        name: 'The Westin Grand Berlin',
        location: "Friedrichstraße 158-164 10117 Berlin Germany",
        number: '+49-30-20270',
        description: "The site remained vacant until the East German state-run Interhotel monopoly decided to build a flagship luxury hotel for Western tourists in the 1980s. The structure was designed by a collective of architects headed by noted East German architect Erhardt Gisske in the style of early twentieth century luxury hotels, and with a glass dome modeled on the one in the former Kaisergalerie.[2] The East German government hired the Japanese Kajima Corporation to manage the building of the 200 million mark structure, and Kajima in turn subcontracted the construction work to the Swedish Siab construction company.[3] The hotel was opened as the Grand Hotel Berlin on August 1, 1987 by East German leader Erich Honecker as part of the city-wide celebrations of the 750th anniversary of the founding of Berlin.",
        stars: 4,
      ),
      Hotel(
        id: 3,
        name: 'Marina Bay Sands',
        location: '10 Bayfront Avenue, Singapore',
        number: '+65-6688-8888',
        description: "Marina Bay Sands is an integrated resort fronting Marina Bay in Singapore, owned by the Las Vegas Sands corporation. At its opening in 2010, it was billed as the world's most expensive standalone casino property at S\$8 billion (\$5.88 billion USD), including the land cost.[2][3] The resort includes a 2,561-room hotel, a 120,000-square-metre (1,300,000 sq ft) convention-exhibition centre, the 74,000-square-metre (800,000 sq ft) The Shoppes at Marina Bay Sands mall, a museum, two large theatres, 'celebrity chef' restaurants, two floating Crystal Pavilions, art-science exhibits, and the world's largest atrium casino with 500 tables and 1,600 slot machines. Marina Bay Sands is an integrated resort fronting Marina Bay in Singapore, owned by the Las Vegas Sands corporation. At its opening in 2010, it was billed as the world's most expensive standalone casino property at S\$8 billion (\$5.88 billion USD), including the land cost.[2][3] The resort includes a 2,561-room hotel, a 120,000-square-metre (1,300,000 sq ft) convention-exhibition centre, the 74,000-square-metre (800,000 sq ft) The Shoppes at Marina Bay Sands mall, a museum, two large theatres, 'celebrity chef' restaurants, two floating Crystal Pavilions, art-science exhibits, and the world's largest atrium casino with 500 tables and 1,600 slot machines. ",
        stars: 5,
      ),
      Hotel(
        id: 4,
        name: 'Carlton Hotel',
        location: '76 Bras Basah Road, Singapore',
        number: '+65-6338-8333',
        description: 'Carlton City Hotel Singapore is a prominent addition to the city skyline and ideally situated in the historical district of Tanjong Pagar within the central business district. Positioned as an upscale business hotel, Carlton City is attuned to the needs of well-travelled and eco-conscious guests with a taste for a stylish, green and comfortable accommodation experience.',
        stars: 5,
      ),
      Hotel(
        id: 5,
        name: 'Park Regis Singapore',
        location: '23 Merchant Road, Singapore',
        number: '+65-6818-8888',
        description: "Park Regis Singapore is centrally located in the city centre, within easy reach of Singapore's vibrant entertainment and dining hubs such as Clarke Quay, Boat Quay and Chinatown. The hotel is close to Raffles Place and Marina Bay, Singapore's commercial and entertainment hub. Perched along the Singapore River, the hotel is a mere 3 minutes' walk away from Clarke Quay MRT train station.",
        stars: 4,
      ),
      Hotel(
        id: 6,
        name: 'Shilla Hotel Jeju',
        location: '75, Jungmungwangwang-ro 72beon-gil, Seogwipo, Jeju Island',
        number: '+82-735-5114',
        description: "5-star beach resort with a casino. Catch some rays at the nearby beach or spend the day onsite at a casino, then enjoy a meal at one of The Shilla Jeju's 3 restaurants. Rooms boast deep soaking tubs and offer refrigerators and satellite TV. Minibars, coffee makers, and free newspapers are among the other amenities available to guests.",
        stars: 5,
      ),
    ];
    return allHotels;
  }
}
