//
//  Symbols.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation

struct Symbols {
  static var random = list.randomElement()!
  
  static func randomList(size count: Int) -> [String] {
    list.shuffled().prefix(count).map { $0 }
  }
  
  static let list = [
    "house.fill",
    "ticket.fill",
    "gamecontroller.fill",
    "theatermasks.fill",
    "ladybug.fill",
    "books.vertical.fill",
    "moon.zzz.fill",
    "umbrella.fill",
    "paintbrush.pointed.fill",
    "leaf.fill",
    "globe.americas.fill",
    "clock.fill",
    "building.2.fill",
    "gift.fill",
    "graduationcap.fill",
    "heart.rectangle.fill",
    "phone.bubble.left.fill",
    "cloud.rain.fill",
    "building.columns.fill",
    "mic.circle.fill",
    "comb.fill",
    "person.3.fill",
    "bell.fill",
    "hammer.fill",
    "star.fill",
    "crown.fill",
    "briefcase.fill",
    "speaker.wave.3.fill",
    "tshirt.fill",
    "tag.fill",
    "airplane",
    "pawprint.fill",
    "case.fill",
    "creditcard.fill",
    "infinity.circle.fill",
    "dice.fill",
    "heart.fill",
    "camera.fill",
    "bicycle",
    "radio.fill",
    "car.fill",
    "flag.fill",
    "map.fill",
    "figure.wave",
    "mappin.and.ellipse",
    "facemask.fill",
    "eyeglasses",
    "tram.fill",
  ]
}
