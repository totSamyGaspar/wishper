//
//  LocalizedStrings.swift
//  TarotApp
//
//  Created by Edward Gasparian on 08.04.2025.
//

import Foundation

struct Localized {
    enum Key: String {
        case newSpread
        case title
        case history
        case settings
        case language
        case deleteAll
        case emptyHistory
        case drawAgain
        case date
        case yes
        case cancel
        case upright
        case reversed
        case meaningTitle
        case noMeaningAvailable
        case homeTitle
        case makeSpread
        case birthDate
        case backgroundMusic
        case soundEffect
    }
    
    static func t(_ key: Key, lang: String) -> String {
        translations[key.rawValue]?[lang] ?? key.rawValue
    }

    static let translations: [String: [String: String]] = [
        "soundEffect": [
            "ru": "Звуковые эффекты",
            "ua": "Звукові ефекти",
            "en": "Sound Effects"
        ],
        "backgroundMusic": [
            "ru": "Фоновая Музыка",
            "ua": "Фонова Mузика",
            "en": "Background Music"
        ],
        "newSpread": [
            "ru": "Сделать новый расклад",
            "ua": "Зробити новий розклад",
            "en": "Make a new spread"
        ],
        "title": [
            "ru": "Три карты",
            "ua": "Три карти",
            "en": "Three Cards"
        ],
        "history": [
            "ru": "История раскладов",
            "ua": "Історія розкладів",
            "en": "Reading History"
        ],
        "settings": [
            "ru": "Настройки",
            "ua": "Налаштування",
            "en": "Settings"
        ],
        "language": [
            "ru": "Язык",
            "ua": "Мова",
            "en": "Language"
        ],
        "deleteAll": [
            "ru": "Удалить всё",
            "ua": "Видалити все",
            "en": "Delete All"
        ],
        "emptyHistory": [
            "ru": "История пуста",
            "ua": "Історія пуста",
            "en": "History is empty"
        ],
        "drawAgain": [
            "ru": "Сделать новый расклад",
            "ua": "Зробити новий розклад",
            "en": "Draw Again"
        ],
        "date": [
            "ru": "Дата",
            "ua": "Дата",
            "en": "Date"
        ],
        "yes": [
            "ru": "Да",
            "ua": "Так",
            "en": "Yes"
        ],
        "cancel": [
            "ru": "Отмена",
            "ua": "Скасувати",
            "en": "Cancel"
        ],
        "upright": [
            "en": "Upright card",
            "ru": "Прямая карта",
            "ua": "Пряма карта"
        ],
        "reversed": [
            "en": "Reversed card",
            "ru": "Перевёрнутая карта",
            "ua": "Перевернута карта"
        ],
        "meaningTitle": [
            "en": "Meaning",
            "ru": "Значение",
            "ua": "Значення"
        ],
        "noMeaningAvailable": [
            "en": "No meaning available",
            "ru": "Значение недоступно",
            "ua": "Значення недоступне"
        ],
        "homeTitle": [
            "ru": "Таро Расклад",
            "ua": "Таро Розклад",
            "en": "Tarot Spread"
        ],
        "makeSpread": [
            "ru": "Сделать расклад",
            "ua": "Зробити розклад",
            "en": "Make a spread"
        ],
        "birthDate": [
            "ua": "Дата народження",
            "ru": "Дата рождения",
            "en": "Birth Date"
        ]
    ]
}
