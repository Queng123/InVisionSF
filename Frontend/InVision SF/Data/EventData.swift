//
//  EventData.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 4/29/25.
//

import Foundation
import CoreLocation


// Restaurants: Blue
// Events: Purple
// Venues: Green
struct EventData {
    static func allEvents() -> [Event] {
        return [
            Event(title: "Chase Center",
                    location: "1 Warriors Way, San Francisco, CA 94158",
                    description: "Chase Center is an indoor arena in the Mission Bay neighborhood of San Francisco, California. It is the home of the Golden State Warriors",
                    ticketLink: "https://www.chasecenter.com/",
                    date: "",
                    spacialVideoLink: "ChaseCenter.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.768902,
                            longitude: -122.387917
                        )
                    ),
                    ticketInfo: [
                        TicketInfo(name: "General Admission", price: 175),
                        TicketInfo(name: "VIP", price: 395)
                    ],
                    rating: 4.5,
                 ),
            Event(title: "Gyro King",
                    location: "25 Grove St #4702, San Francisco, CA 94102",
                    description: "Greek fast-food restaurant wrapping gyros & other take-out classics in low-frills surroundings.",
                    ticketLink: "https://www.gyroking.co",
                    date: "",
                    spacialVideoLink: "GyroKing.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.778625,
                            longitude: -122.415762
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Chinese New Year Parade",
                    location: "Chinatown, San Francisco, CA",
                    description: "The Chinese New Year Parade in San Francisco is one of the largest and most famous celebrations of its kind outside of Asia, featuring vibrant floats, lion dances, and fireworks.",
                    ticketLink: "https://www.sanfranciscochinatown.com/",
                    date: "Tue, Feb 17, 2026 – Tue, Mar 3, 2026",
                    spacialVideoLink: "ChineseNewYearParade.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.796701,
                            longitude: -122.408446
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "icafe Bakery",
                    location: "133 Waverly Pl, San Francisco, CA 94108",
                    description: "A cozy bakery in Chinatown known for its delicious pastries, coffee, and traditional Chinese desserts.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "icafeBakery.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.794616,
                            longitude: -122.407081
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "San Patrick Parade",
                    location: "Montgomery St & Market St, San Francisco, CA 94104",
                    description: "The San Patrick Parade is a vibrant celebration of Irish culture and heritage, featuring colorful floats, traditional music, and lively performances.",
                    ticketLink: "https://sf.funcheap.com/san-franciscos-st-patricks-day-parade/",
                    date: "Sat, Mar 14, 2026",
                    spacialVideoLink: "SanPatrickParade.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.788785,
                            longitude: -122.402002
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Cherry Blossom Festival",
                    location: "Japantown, San Francisco, CA 94115",
                    description: "The Cherry Blossom Festival in San Francisco is an annual celebration of Japanese culture, featuring traditional performances, food stalls, and beautiful cherry blossoms in bloom.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "CherryBlossomFestival.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7855789,
                            longitude: -122.4298089
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Matterhorn Restaurant and Bakery",
                    location: "2323 Van Ness Ave, San Francisco, CA 94109",
                    description: "A Swiss-themed restaurant and bakery offering a variety of traditional Swiss dishes and pastries in a cozy setting.",
                    ticketLink: "https://www.matterhornsf.com/",
                    date: "",
                    spacialVideoLink: "MatterhornRestaurant.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7969973,
                            longitude: -122.4234686
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "16th Avenue Tiled Steps",
                    location: "16th Ave & Moraga St, San Francisco, CA 94122",
                    description: "A stunning mosaic staircase featuring over 75,000 handmade tiles, offering a beautiful view of the Pacific Ocean.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "16avTiledSteps.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.75612,
                            longitude: -122.473572
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Palace of Fine Arts",
                    location: "3601 Lyon St, San Francisco, CA 94123",
                    description: "A monumental structure originally constructed for the 1915 Panama-Pacific Exposition, featuring a beautiful rotunda and serene lagoon.",
                    ticketLink: "https://palaceoffinearts.com/",
                    date: "",
                    spacialVideoLink: "PalaceOfFineArts.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.8029772,
                            longitude: -122.4479806
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Yoda Fountain",
                    location: "1 Letterman Dr, San Francisco, CA 94129",
                    description: "Fountain featuring the famous Star Wars character outside of the Lucasfilm headquarters.",
                    ticketLink: "http://lucasfilm.com/",
                    date: "",
                    spacialVideoLink: "YodaFountain.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7986961,
                            longitude: -122.4503946
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Letterman Digital Arts Center Recycled Water Pond",
                    location: "1101 Gorgas Ave, San Francisco, CA 94129",
                    description: "A serene pond located at the Letterman Digital Arts Center, known for its sustainable water practices and beautiful surroundings.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "LettermanDigitalArtsCenterPond.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.8005272,
                            longitude: -122.4484849
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Starbucks Letterman Digital Arts Center",
                    location: "1 Letterman Dr Building C, San Francisco, CA 94129",
                    description: "A Starbucks located within the Letterman Digital Arts Center, offering a cozy spot for coffee lovers.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "StarbucksLettermanDigitalArtsCenter.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7990691,
                            longitude: -122.4493217
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Farmers Market",
                    location: "Embarcadero at Green St, San Francisco, CA 94111",
                    description: "A vibrant farmers market offering fresh produce, artisanal goods, and local delicacies.",
                    ticketLink: "",
                    date: "Every Saturday",
                    spacialVideoLink: "FarmersMarket.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7955,
                            longitude: -122.3933
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Embarcadero Muni Station",
                    location: "Embarcadero Station, San Francisco, CA 94111",
                    description: "A major transit hub in San Francisco, connecting various Muni lines and providing access to the Embarcadero waterfront.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "EmbarcaderoMuniStation.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7928548,
                            longitude: -122.3969007
                        )
                    ),
                  rating: 4.5,
                 ),
            Event(title: "Arsicault Bakery",
                    location: "397 Arguello Blvd, San Francisco, CA 94118",
                    description: "A renowned bakery in San Francisco, famous for its flaky croissants and other French pastries.",
                    ticketLink: "https://arsicault-bakery.com/",
                    date: "",
                    spacialVideoLink: "ArsicaultBakery.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.7834402,
                            longitude: -122.4592374
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Scoma's",
                    location: "1965 Al Scoma Way,San Francisco, CA 94133",
                    description: "Scoma's is a family‑run Fisherman's Wharf institution on Pier 47 that's been serving pier‑to‑plate Dungeness crab, cioppino, and other local catches since 1965, using its own dockside fish‑receiving station to guarantee freshness.",
                    ticketLink: "https://scomas.com/",
                    date: "",
                    spacialVideoLink: "scomas.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .blue,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.808906,
                            longitude: -122.416310
                        )
                    ),
                    rating: 4.5,
                  ),
            
            Event(title: "Ghirardelli Square⁩",
                    location: "Beach St, San Francisco CA 94109",
                    description: "Ghirardelli Square is a historic waterfront landmark where the 19th‑century Ghirardelli chocolate factory has been transformed into a lively enclave of shops, restaurants, and the brand's flagship ice‑cream parlor.",
                    ticketLink: "https://www.ghirardellisq.com/",
                    date: "",
                    spacialVideoLink: "Ghirardelli.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.80600,
                            longitude: -122.42260
                        )
                    ),
                    rating: 4.5,
                  ),
            
        
            
            Event(title: "SF Awesome AI Dev Tools",
                    location: "88 Colin P Kelly Jr St, San Francisco, CA  94107",
                    description: "​You probably already know that AI is changing the world. Come learn about some of the awesome AI dev tools being worked on.",
                    ticketLink: "https://lu.ma/856ufska?tk=2gPkVv",
                    date: "19 may 2025",
                    spacialVideoLink: "github.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.782180,
                            longitude: -122.391276
                        )
                    ),
                    rating: 4.5,
                  ),
            
            Event(title: "Golden Gate bridge",
                    location: "Golden Gate Bridge, San Francisco CA",
                    description: "​The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean. The structure links the U.S. city of San Francisco, California—the northern tip of the San Francisco Peninsula—to Marin County, carrying both U.S. Route 101 and California State Route 1 across the strait. It also carries pedestrian and bicycle traffic, and is designated as part of U.S. Bicycle Route 95.",
                    ticketLink: "",
                    date: "",
                    spacialVideoLink: "GoldenGate.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.818031,
                            longitude: -122.478365
                        )
                    ),
                    rating: 4.5,
                  ),
            
            Event(title: "Fort Point National Historic Site",
                    location: "Building 999 Marine Drive, San Francisco CA 94129",
                    description: "​Fort Point National Historic Site is a Civil War–era brick fort tucked beneath the Golden Gate Bridge that once protected San Francisco Bay and now offers guided tours and sweeping bridge‑and‑bay views.",
                    ticketLink: "nps.gov/fopo/index.htm",
                    date: "",
                    spacialVideoLink: "FortPoint.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .green,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.810569,
                            longitude: -122.476746
                        )
                    ),
                    rating: 4.5,
                  ),
            Event(title: "Oracle Park",
                    location: "24 Willie Mays Plaza, San Francisco, CA 94107",
                    description: "Oracle Park is a baseball stadium located in San Francisco, California. It is the home of the San Francisco Giants, a Major League Baseball team.",
                    ticketLink: "https://www.mlb.com/giants/ballpark",
                    date: "",
                    spacialVideoLink: "OraclePark.MOV",
                    mapInfo: Event.MapInfo(
                        imageMarker: "pin",
                        colorMarker: .purple,
                        coordinates: CLLocationCoordinate2D(
                            latitude: 37.778419,
                            longitude: -122.390617
                        )
                    ),
                    ticketInfo: [
                        TicketInfo(name: "General Admission", price: 100),
                        TicketInfo(name: "VIP", price: 200)
                    ],
                    rating: 4.5,
                 ),
            
        ]
    }
}
