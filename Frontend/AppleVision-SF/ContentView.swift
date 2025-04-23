//
//  ContentView.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI
import RealityKit
import MapKit

struct ContentView: View {
    @State private var searchText = ""
    @State private var isMenuExpanded = false
    @State private var events: [Event] = []
    @State private var selectedEvent: Event? = nil

    var body: some View {
        ZStack {
            VStack {
                MapView(events: $events, selectedEvent: $selectedEvent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                ExpandableMenu(
                    isExpanded: $isMenuExpanded,
                    searchText: $searchText,
                    events: $events,
                    onEventSelected: { event in
                        selectedEvent = event
                    }
                )
            }

            if let selectedEvent = selectedEvent {
                EventDetailOverlay(event: selectedEvent) {
                    self.selectedEvent = nil
                }
            }
        }
        .onAppear {
            fetchEvents()
            print(events)
        }
    }

    private func fetchEvents() {
        events = [
            Event(title: "The Multiverse Christmas Party", location: "The Multiverse, Palo Alto, CA", description: "A short talk by John Alioto from Google and lots of partying.", ticketLink: "https://lu.ma/wzp3sgwt", date: "Wednesday, December 18, 5:30 PM - 8:00 PM", spacialVideoLink: "sampleVideo2.mov", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.447630149999995, longitude: -122.16237274736238))),
            Event(title: "AI For Developers #21", location: "972 Mission St, San Francisco, California", description: "Discover the power of AI technologies like ChatGPT and Codex to streamline your development process and create innovative solutions.", ticketLink: "https://lu.ma/ai-for-developers-21", date: "Wednesday, December 18, 6:00 PM - 9:00 PM", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7816984, longitude: -122.40839198986143))),
            Event(title: "Windsurf Launch Happy Hour", location: "General Catalyst, San Francisco, California", description: "During the event, you'll have the chance to hear from our team as they share insights into the journey of creating the first agentic IDE.", ticketLink: "https://lu.ma/2tlbw6we", date: "Thursday, December 19, 5:00 PM - 7:00 PM", spacialVideoLink: "panorama.jpeg"),
            Event(title: "Ho Ho HODL 🎅 A Bullish Holiday Party with Constellation, Base, and Walrus", location: "San Francisco, CA", description: "Networking & Happy Hour: Connect with builders, operators, and investors. It’s the perfect opportunity to dive into the SF Web3 scene before the year ends.", ticketLink: "https://lu.ma/x81qaetf", date: "Thursday, December 19, 6:00 PM - 9:00 PM", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7792588, longitude: -122.4193286))),
            Event(title: "SF Meetup with Health Tech Nerds", location: "Mad Oak Bar ‘N’ Yard, Oakland, California", description: "A casual happy hour for folks working or interested in healthcare/health tech to hang out and get to know one another! Anyone is welcome to attend.", ticketLink: "https://lu.ma/yc84zo8m", date: "Thursday, December 19, 6:00 PM - 8:00 PM", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7998622, longitude: -122.2646424))),
            Event(title: "December 3H: Swap Edition!", location: "Spark Social SF, San Francisco, California", description: "Let's do one last meetup for 2024! Since it's the season of giving, if you have pieces of hardware or craft supplies that you'd like to give away or swap with people, feel free to bring them. Maybe you'll end up making someone's winter extra fun. And as usual, if you have any projects you'd like to share, we'd be so excited to see them and learn more!", ticketLink: "https://lu.ma/t8ohatc3", date: "Thursday, December 19, 6:30 PM - 8:30 PM", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.77071705, longitude: -122.39159054085184))),
            Event(title: "Founders Running Club :: SF", location: "Main Parade Lawn, San Francisco, California", description: "Founders Running Club (FRC) brings founders, investors, tech, creative people and startup enthusiasts together for weekly easy runs and networking.", ticketLink: "https://lu.ma/ubtb4lb2", date: "Saturday, December 21, 9:30 AM - 12:00 PM", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.80183955, longitude: -122.45823774901294))),
            Event(title: "Cable Car Museum", location: "Cable Car Museum, San Francisco, CA", description: "From the first run in 1873 to the present. Learn about the inventor, technologies, builders, rapid expansion, near loss and the ongoing efforts to save and rebuild the cable cars of San Francisco.", ticketLink: "https://www.cablecarmuseum.org/", date: "Tuesday - Sunday", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.79476015, longitude: -122.41185284314184))),
            Event(title: "California Pizza Kitchen", location: "53 3rd St, San Francisco, CA 94103", description: "Pizza Restaurant", ticketLink: "https://order.cpk.com/menu/california-pizza-kitchen-53-third-street/?utm_source=GMB&utm_medium=GMB", date: "Monday - Sunday", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.786857999999995, longitude: -122.40266079999999))),
            Event(title: "The Cheesecake Factory", location: "251 Geary St, San Francisco, CA 94102", description: "American Restaurant", ticketLink: "https://www.thecheesecakefactory.com/menu/?utm_source=google&utm_medium=organic&utm_campaign=google-my-business-listing", date: "Monday - Sunday", spacialVideoLink: "panorama.jpeg", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.787394, longitude: -122.407633))),
            Event(title: "Oriental Seafood Restaurant", location: "2520 Noriega St, San Francisco, CA 94122", description: "Chinese restaurant", ticketLink: "https://places.singleplatform.com/oriental-seafood-restaurant/menu?ref=google", date: "Monday - Sunday", spacialVideoLink: "sampleVideo2", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.7538253, longitude: -122.49082572609919))),
            Event(title: "The Stinking Rose", location: "430 Columbus Ave, San Francisco, CA 94133", description: "Garlic-themed Italian restaurant", ticketLink: "https://www.thestinkingrose.com/", date: "Monday - Sunday", spacialVideoLink: "sampleVideo2", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.7990536, longitude: -122.4081693))),
            Event(title: "King of Noodles", location: "1639 Irving St, San Francisco, CA 94122", description: "Noodle shop", ticketLink: "https://www.doordash.com/store/king-of-noodles-san-francisco-2413394/", date: "Monday - Sunday", spacialVideoLink: "sampleVideo2", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.76343005, longitude: -122.4756990305399))),
            Event(title: "Musée Mécanique", location: "Pier 45, San Francisco, CA 94133", description: "Museum", ticketLink: "https://museemecaniquesf.com/", date: "Monday - Sunday", spacialVideoLink: "sampleVideo2", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.809576, longitude: -122.415804))),
            Event(title: "GLBT Historical Society Museum", location: "4127 18th St, San Francisco, CA 94114", description: "Main exhibit covering over 100 years of Bay Area's GLBT history, plus special programming.", ticketLink: "https://www.glbthistory.org/museum-about-visitor-info", date: "Tuesday - Sunday", spacialVideoLink: "spatialVideo.mov", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.7607664, longitude: -122.435607))),
            Event(title: "Museum of Russian Culture", location: "2450 Sutter St, San Francisco, CA 94115", description: "Museum", ticketLink: "https://www.mrcsf.org/home/", date: "Wednesday | Saturday", spacialVideoLink: "sampleVideo2", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.78547315, longitude: -122.44093549534998))),
        ]
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
