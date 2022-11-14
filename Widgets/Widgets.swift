//
//  Widgets.swift
//  Widgets
//
//  Created by Maicol Cabreja on 10/3/22.
//

import WidgetKit
import SwiftUI


var Affirmations = ["Strive for joy, not for perfection.", "I am valued.", "Today is an opportunity to grow and learn.", "There are no limits to what I can achieve.", "Think about your happiest memories.", "I am powerful.", "I define my worth. I am worthy.", "I believe I can be all that I want to be.", "My possibilities are endless.", "All is well.", "I have the power to create change.", " I’m worthy of respect.", "My contributions are valuable.", "Life is full of amazing opportunities", "I can create the life I desire.", "I radiate confidence.", "All of my problems have solutions.", "I have goals and dreams that I am going to achieve.", "My problems do not define me.", "I radiate good energy.", "Forgive yourself.",  "Love yourself", "Be nice", "Live your life to the fullest!", "I will accomplish my goals.","I am confident.", "All I need is within me right now.", "I am getting better and better every day.", "Today is a phenomenal day.", "I can be whatever I want to be.", "I am intelligent and focused.", "Today will be a productive day.", "Each and every day, I am getting closer to achieving my goals.", "I am constantly growing and evolving into a better person.", "I accept myself for who I am", "I am going to forgive myself and free myself.", "I will not engage with people who penetrate my mind with unhelpful thoughts.", "My past might be ugly, but I am still beautiful.", "I finish what matters and let go of what does not.", "My actions are meaningful and inspiring.", "Set goals and go after them with all the determination you can muster.", "Happiness is a choice, and today I will choose to be happy.", "Today, and every day, I am blessed.", "I will succeed today.", "I can do anything I put my mind to.", "I am grateful for all that I have and all that is yet to come.", "I deserve success.", "Every step I take brings me closer to my goals.", "I inhale peace and exhale doubt.", "I can do amazing things.", " I take pleasure in my own solitude.", "I trust myself.","I trust my inner wisdom and intuition.", "Wonderful things will unfold before me.", "I choose friends who approve of me and love me.", " I surround myself with people who treat me well.", "I am beautiful and smart and that’s how everyone sees me.", "I play a big role in my own career success.", "I believe in my ability to change the world.", "I fill my day with hope and face it with joy.", "I let go of worries that drain my energy.", "I am a money magnet and attract wealth and abundance.", "I trust in my own ability to provide for my family.", " I follow my dreams no matter what.", " I am safe and sound.", "The answer is right before me", "I compare myself only to my highest self.", "I choose to see the light that I am to this world.", "I am happy in my own skin and in my own circumstances.", "I am more than good enough and I get better every day.", "I adopt the mindset to praise myself.", "I see the perfection in all my flaws.", " I fully approve of who I am, even as I get better.", "I keep pushing on because I believe in my path.", "It is always too early to give up on my goals.", "The past has no power over me.", "I embrace the rhythm and the flowing of my own heart.", "I am deeply fulfilled with who I am.", "All that I need comes to me at the right time and place in this life.", "I am a powerful manifestor.", "Let go of your expectations and enjoy the journey.", "Light is within me.", "I am loving and lovable.", "I am capable of so much.", "Everything will be ok.", "I believe in myself.", "I’ve got what it takes.", "Problems challenge me to better myself.", "My thoughts and feelings are nourishing.", "I am a magnet for love.", "My mind is full of brilliant ideas.", "I will not take other people’s negativity", "I only set goals that matter.", "My goals are my focus.", "My life is just beginning.", "I am becoming closer to my true self every day.", "I will accept nothing but the best.", "I give myself space to grow and learn.", "I am loved, and I am wanted.", "My every desire is achievable."]

struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "I radiate confidence.")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), quote: Affirmations.randomElement()!)
        completion(entry)
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [SimpleEntry] = []
        
        
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: Affirmations.randomElement()!)
            entries.append(entry)
            UserDefaults(suiteName: "group.com.Maicol.Myself")!.set(entry.quote, forKey: "test")
        }
        
        
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var quote: String
}

struct WidgetsEntryView : View {
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        
        Text(entry.quote)
            .padding()//.systemSmall widgets are one large tap area
        
    }
}
    
    @main
    struct Widgets: Widget {
        let kind: String = "Widgets"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                WidgetsEntryView(entry: entry)
            }
            .configurationDisplayName("Standard")
            .description("Show affirmations on your homescreen")
        }
    }
    
    struct Widgets_Previews: PreviewProvider {
        static var previews: some View {
            WidgetsEntryView(entry: SimpleEntry(date: Date(), quote: "I have goals and dreams that I am going to achieve."))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }

