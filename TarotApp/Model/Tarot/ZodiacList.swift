//
//  ZodiacList.swift
//  TarotApp
//
//  Created by Edward Gasparian on 16.04.2025.
//

enum ZodiacList: String, Identifiable,CaseIterable {
    
    var id: String {self.rawValue}
    
    case sagittarius = "Sagittarius"
    case capricornus = "Capricornus"
    case aquarius = "Aquarius"
    case pisces = "Pisces"
    case aries = "Aries"
    case taurus = "Taurus"
    case gemini = "Gemini"
    case cancer = "Cancer"
    case leo = "Leo"
    case virgo = "Virgo"
    case libra = "Libra"
    case scorpio = "Scorpio"
    
    //MARK: - Localization
    func localizedZodiacPicker(lang: String) -> String {
        switch (self, lang) {
            
        case (.sagittarius, "ua"): return "Стрелець"
        case (.sagittarius, "en"): return "Sagittarius"
        case (.sagittarius, "ru"): return "Стрелец"
            
        case (.capricornus, "ua"): return "Козеріг"
        case (.capricornus, "en"): return "Capricornus"
        case (.capricornus, "ru"): return "Козерог"
            
        case (.aquarius, "ua"): return "Водолій"
        case (.aquarius, "en"): return "Aquarius"
        case (.aquarius, "ru"): return "Водолей"
            
        case (.pisces, "ua"): return "Риба"
        case (.pisces, "en"): return "Pisces"
        case (.pisces, "ru"): return "Рыба"
            
        case (.aries, "ua"): return "Овен"
        case (.aries, "en"): return "Aries"
        case (.aries, "ru"): return "Овен"
            
        case (.taurus, "ua"): return "Телець"
        case (.taurus, "en"): return "Taurus"
        case (.taurus, "ru"): return "Телец"
            
        case (.gemini, "ua"): return "Близнюки"
        case (.gemini, "en"): return "Gemini"
        case (.gemini, "ru"): return "Близнeцы"
            
        case (.cancer, "ua"): return "Рак"
        case (.cancer, "en"): return "Cancer"
        case (.cancer, "ru"): return "Рак"
            
        case (.leo, "ua"): return "Лев"
        case (.leo, "en"): return "Leo"
        case (.leo, "ru"): return "Лев"
            
        case (.virgo, "ua"): return "Діва"
        case (.virgo, "en"): return "Virgo"
        case (.virgo, "ru"): return "Дева"
            
        case (.libra, "ua"): return "Терези"
        case (.libra, "en"): return "Libra"
        case (.libra, "ru"): return "Весы"
            
        case(.scorpio, "ua"): return "Скорпіон"
        case (.scorpio, "en"): return "Scorpio"
        case (.scorpio, "ru"): return "Скорпион"
            
        default:
            return "Unknown"
            
            
        }
        
        
        
    }
}

extension ZodiacList {
    var image: String {
        switch self {
        case .sagittarius: return "sagittarius"
        case .capricornus: return "capricornus"
        case .aquarius: return "aquarius"
        case .pisces: return "pisces"
        case .aries: return "aries"
        case .taurus: return "taurus"
        case .gemini: return "gemini"
        case .cancer: return "cancer"
        case .leo: return "leo"
        case .virgo: return "virgo"
        case .libra: return "libra"
        case .scorpio: return "scorpio"
            
            
        }
    }
}
