//
//  ContentView.swift
//  Myself
//
//  Created by Maicol Cabreja on 10/2/22.
//

import SwiftUI
import StoreKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

var Affirmations = ["Strive for joy, not for perfection.", "I am valued.", "Today is an opportunity to grow and learn.", "There are no limits to what I can achieve.", "Think about your happiest memories.", "I am powerful.", "I define my worth. I am worthy.", "I believe I can be all that I want to be.", "My possibilities are endless.", "All is well.", "I have the power to create change.", " I’m worthy of respect.", "My contributions are valuable.", "Life is full of amazing opportunities.", "I can create the life I desire.", "I radiate confidence.", "All of my problems have solutions.", "I have goals and dreams that I am going to achieve.", "My problems do not define me.", "I radiate good energy.", "Forgive yourself.",  "Love yourself", "Be nice.", "Live your life to the fullest!", "I will accomplish my goals.","I am confident.", "All I need is within me right now.", "I am getting better and better every day.", "Today is a phenomenal day.", "I can be whatever I want to be.", "I am intelligent and focused.", "Today will be a productive day.", "Each and every day, I am getting closer to achieving my goals.", "I am constantly growing and evolving into a better person.", "I accept myself for who I am.", "I am going to forgive myself and free myself.", "I will not engage with people who penetrate my mind with unhelpful thoughts.", "My past might be ugly, but I am still beautiful.", "I finish what matters and let go of what does not.", "My actions are meaningful and inspiring.", "Set goals and go after them with all the determination you can muster.", "Happiness is a choice, and today I will choose to be happy.", "Today, and every day, I am blessed.", "I will succeed today.", "I can do anything I put my mind to.", "I am grateful for all that I have and all that is yet to come.", "I deserve success.", "Every step I take brings me closer to my goals.", "I inhale peace and exhale doubt.", "I can do amazing things.", " I take pleasure in my own solitude.", "I trust myself.","I trust my inner wisdom and intuition.", "Wonderful things will unfold before me.", "I choose friends who approve of me and love me.", " I surround myself with people who treat me well.", "I am beautiful and smart and that’s how everyone sees me.", "I play a big role in my own career success.", "I believe in my ability to change the world.", "I fill my day with hope and face it with joy.", "I let go of worries that drain my energy.", "I am a money magnet and attract wealth and abundance.", "I trust in my own ability to provide for my family.", " I follow my dreams no matter what.", " I am safe and sound.", "The answer is right before me", "I compare myself only to my highest self.", "I choose to see the light that I am to this world.", "I am happy in my own skin and in my own circumstances.", "I am more than good enough and I get better every day.", "I adopt the mindset to praise myself.", "I see the perfection in all my flaws.", "I fully approve of who I am, even as I get better.", "I keep pushing on because I believe in my path.", "It is always too early to give up on my goals.", "The past has no power over me.", "I embrace the rhythm and the flowing of my own heart.", "I am deeply fulfilled with who I am.", "All that I need comes to me at the right time and place in this life.", "I am a powerful manifestor.", "Let go of your expectations and enjoy the journey.", "Light is within me.", "I am loving and lovable.", "I am capable of so much.", "Everything will be ok.", "I believe in myself.", "I’ve got what it takes.", "Problems challenge me to better myself.", "My thoughts and feelings are nourishing.", "I am a magnet for love.", "My mind is full of brilliant ideas.", "I will not take other people’s negativity.", "I only set goals that matter.", "My goals are my focus.", "My life is just beginning.", "I am becoming closer to my true self every day.", "I will accept nothing but the best.", "I give myself space to grow and learn.", "I am loved, and I am wanted.", "My every desire is achievable.", "Every obstacle is an opportunity to grow.", "Good things are going to happen.", "I am manifesting my dream life.", "I will achieve the goals I set.", "I am grateful to be alive.", "My possibilities are endless.", "I will not compare myself to others.", "I will accomplish anything I focus on.", "I am determined to succeed.", "I will go after what makes me happy.", "I am thankful for all I have and all I will accomplish.", "I don’t fail, I learn."]


struct ContentView: View {
    @EnvironmentObject private var store: Store
    var body: some View {
        NavigationView{
            AffirmationsView()
        }
    }
}

struct AffirmationsView: View {
    @EnvironmentObject private var store: Store
    @State private var mainText = "Today is a good day. Tap to refresh!"
    @Environment(\.colorScheme) var colorScheme
    
    private let url = URL(string: "https://apps.apple.com/us/app/myself-daily-affirmations/id6443645849")!
    //100
    //4 Ad Locations
    
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack{
                    HStack{
                        Spacer()
                        
                        //Setting button
                        NavigationLink(destination: Settings()){
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .padding()
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                    }
                    
                    Spacer()
                    
                    //"\(Affirmations.count)"
                    
                    Text(mainText)
                        .font(.system(.largeTitle, design: .rounded).weight(.semibold))
                        .navigationBarTitle("")
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .padding()
                    
                    Spacer()
                    
                    HStack{
                        ShareLink("", item: mainText  == "Today is a good day. Tap to refresh!" ? "\(url)" : mainText)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                       
                    }
                    Spacer(minLength: 50)
                    
                    //test banner ad
                    //ca-app-pub-2043555402127024/5262061549
                    
                    //production banner ad
                    //ca-app-pub-2043555402127024/8570378407
                    if !store.completedPurchases.isEmpty{
                        AdView(adUnitID: "nil").frame(width:150, height: 60)
                    }
                    else{
                        AdView(adUnitID: "ca-app-pub-2043555402127024/8570378407").frame(width:150, height: 60)
                    }
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    mainText = Affirmations.randomElement()!
                    
                    
                }
            }
        }
        .onAppear{
            store.loadStoredPurchases()
            store.retorePurchases()
        }
    }
}


struct Settings: View {
    @EnvironmentObject private var store: Store
    @Environment(\.colorScheme) var colorScheme
    
    private let url = URL(string: "https://apps.apple.com/us/app/myself-daily-affirmations/id6443645849")!
    var body: some View {
        VStack{
            
            HStack{
                //Setting button
                Text("Settings")
                    .font(.largeTitle.bold())
                    .padding()
                Spacer()
            }
            
            NavigationLink(destination: StoreView()){
                ZStack{
                    Color.indigo
                        .cornerRadius(20)
                    
                    VStack{
                        HStack{
                            Text("Shop")
                                .foregroundColor(Color.white)
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        
                        HStack{
                            Text("Remove ads forever!")
                                .foregroundColor(Color.white)
                                .font(.callout)
                            Spacer()
                        }
                        
                    }
                    .padding()
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding()
            
            List{
                Section("General"){
                NavigationLink(destination: IconsView()){
                    
                    Image(systemName: "square.stack")
                        .resizable()
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(width: 15, height: 20)
                    
                    
                        Text("App Icons")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
        
                }
                
                Section("Support Us"){
                
                    
                    
                        HStack{
                            ShareLink("Share Myself - Daily Affirmations", item: url)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                           
                        }
                    
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/app/myself-daily-affirmations/id6443645849")!){
                        HStack{
                            
                            Image(systemName: "bubble.left.and.bubble.right")
                                .resizable()
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .frame(width: 25, height: 20)
                            
                            Text("   Leave a Review")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                    }
                }
                
                Section("Socials"){
                    Link(destination: URL(string: "https://www.instagram.com/myself.affirmations")!){
                        Text("Instagram")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    
                    Link(destination: URL(string: "https://www.twitter.com/myself_dailyapp")!){
                        Text("Twitter")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                }
                
                Section("About"){
                    Link(destination: URL(string: "https://pages.flycricket.io/myself-daily-affir/terms.html")!){
                        Text("Privacy Policy")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                        
                    }
                    
                    Link(destination: URL(string: "https://tipcalculator.weebly.com")!){
                        Text("Contact Us")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                }
            }
            Spacer()
            
            if !store.completedPurchases.isEmpty{
                AdView(adUnitID: "nil").frame(width:150, height: 60)
            }
            else{
                AdView(adUnitID: "ca-app-pub-2043555402127024/8570378407").frame(width:150, height: 60)
            }
        }
    }
}

struct RecipeRow: View {
    var recipe: Recipe
    let action: () -> Void
    var body: some View {
        HStack{
            HStack{
                ZStack{
                    Image(recipe.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(9)
                        .opacity(recipe.isLocked ? 0.8 : 1)
                        .blur(radius: recipe.isLocked ? 3.0 : 0)
                        .padding()
                    Image(systemName: "lock.fill")
                        .font(.largeTitle)
                        .opacity(recipe.isLocked ? 1 : 0)
                }
                VStack(alignment: .leading){
                    Text(recipe.title)
                        .font(.title)
                    Text(recipe.description)
                        .font(.caption)
                }
                Spacer()
                if let price = recipe.price, recipe.isLocked{
                    Button(action: action, label: {
                        Text(price)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing])
                            .padding([.top, .bottom], 5)
                            .background(Color.black)
                            .cornerRadius(25)
                        
                    })
                }
            }
        }
    }
}

struct StoreView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack{
            List(store.allRecipes, id: \.self) { recipe in
                Group{
                    if !recipe.isLocked {
                        RecipeRow(recipe: recipe){ }
                    } else {
                        RecipeRow(recipe: recipe){
                            if let product = store.product(for: recipe.id){
                                store.purchaseProduct(product)
                            }
                        }
                    }
                }
                .navigationBarItems(trailing: Button("Restore"){
                    store.retorePurchases()
                })
                .onAppear{
                    store.loadStoredPurchases()
                }
            }
            
            if !store.completedPurchases.isEmpty{
                AdView(adUnitID: "nil").frame(width:150, height: 60)
            }
            else{
                AdView(adUnitID: "ca-app-pub-2043555402127024/8570378407").frame(width:150, height: 60)
            }
        }
        .navigationTitle("Shop")
        
    }
}

struct IconsView: View {
    @EnvironmentObject private var store: Store
    @AppStorage("appIcon") private var appIcon: String = ""
    @State var appIcons = ["AppIcon", "AppIconBlue", "AppIconPink", "AppIconPurple","AppIconBlack", "AppIconOrange", "AppIconRed", "AppIconGreen", "AppIconYellow", "AppIconBlackCyan"]
    
    var body: some View {
        List{
            
            //black Icon
            HStack{
                Text("Black Icon (default)")
                    .padding()
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconBlack")
            }
            
           
            //blue icon
            HStack{
                Text("Blue Icon")
                    .padding()
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconBlue")
            }
            
            //pink icon
            HStack{
                Text("Pink Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconPink")
            }
            
            //red icon
            HStack{
                Text("Red Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconRed")
            }
            
            //purple icon
            HStack{
                Text("Purple Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconPurple")
            }
            
            //yellow icon
            HStack{
                Text("Yellow Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconYellow")
            }
            
            //orange icon
            HStack{
                Text("Orange Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconOrange")
            }
            
            //Green icon
            HStack{
                Text("Green Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconGreen")
            }
            
            //Cyan icon
            HStack{
                Text("Cyan Icon")
                    .padding()
                Spacer()
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.setAlternateIconName(appIcon == "AppIcon" ? nil : "AppIconCyan")
            }
        }
        
        if !store.completedPurchases.isEmpty{
            AdView(adUnitID: "nil").frame(width:150, height: 60)
        }
        else{
            AdView(adUnitID: "ca-app-pub-2043555402127024/8570378407").frame(width:150, height: 60)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AffirmationsView()
        
        
    }
}
