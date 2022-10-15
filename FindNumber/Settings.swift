//
//  Settings.swift
//  FindNumber
//
//  Created by Star Lord on 14/10/2022.
//

import Foundation

enum KeyUserDefaults{
    static let settingsGame = "settingsGame"
}

struct SettingsGame: Codable{
    var timerState: Bool
    var timeForGame: Int
}

class Settings{
    static var shared = Settings()
    
    private let defaultSettings = SettingsGame(timerState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame{

        get{
            if let data = UserDefaults.standard.object(forKey: KeyUserDefaults.settingsGame) as? Data{
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings){
                    UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingsGame)

                }
                return defaultSettings
            }
        }
        set{
//            do {
//                let data = PropertyListEncoder().encode(newValue)
//            } catch {
//                print(error)
//            }
            if let data = try? PropertyListEncoder().encode(newValue){
                UserDefaults.standard.setValue(data, forKey: KeyUserDefaults.settingsGame)
            }
        }
    }
    func resetSettings(){
        currentSettings = defaultSettings
    }
}
