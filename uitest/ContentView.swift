import SwiftUI

class Settings: ObservableObject {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        self.showTutorial = !userDefaults.bool(forKey: "seenTutorial")
    }

    @Published var showTutorial: Bool {
        didSet {
            markTutorialAsShown()
        }
    }

    private func markTutorialAsShown() {
        userDefaults.set(true, forKey: "seenTutorial")
    }
}

struct TutorialView: View {

    @Binding var tutorialShown: Bool

    var body: some View {
        VStack {
            Text("Tutorial")
                .font(.largeTitle)
            Spacer()
            Button(action: {
                self.tutorialShown = false
            }, label: {
                Text("Continue")
                    .font(.largeTitle)
            })
        }
    }
}

struct ContentView: View {
    @ObservedObject var settings: Settings

    init(settings: Settings = Settings()) {
        self.settings = settings
    }

    var body: some View {
        VStack {
            Text("Main Content")
                .font(.largeTitle)
        }.sheet(isPresented: self.$settings.showTutorial, content: {
            TutorialView(tutorialShown: self.$settings.showTutorial)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
