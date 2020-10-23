//
//  StarshipViewModel.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/23.
//

import Foundation
import RxSwift

struct StarshipListViewModel {
  
  let starships: [StarshipViewModel]
  
  init(_ starships: [Starship]) {
    self.starships = starships.compactMap(StarshipViewModel.init)
  }
}

extension StarshipListViewModel {
  
  func starshipAt(_ index: Int) -> StarshipViewModel {
    return starships[index]
  }
}

struct StarshipViewModel {
  let starship: Starship
  
  init(_ starship: Starship) {
    self.starship = starship
  }
}

extension StarshipViewModel {
  var titleLabelText: Observable<String> {
    return Observable<String>.just(self.starship.name)
  }
  
  var subtitleLabelText: Observable<String> {
    return Observable<String>.just(self.starship.model)
  }
  
  var item1LabelText: Observable<String> {
    return Observable<String>.just(self.starship.item1.label)
  }
  
  var item1ValueText: Observable<String> {
    return Observable<String>.just(self.starship.item1.value)
  }
  
  var item2LabelText: Observable<String> {
    return Observable<String>.just(self.starship.item2.label)
  }
  
  var item2ValueText: Observable<String> {
    return Observable<String>.just(self.starship.item2.value)
  }
  
  var item3LabelText: Observable<String> {
    return Observable<String>.just(self.starship.item3.label)
  }
  
  var item3ValueText: Observable<String> {
    return Observable<String>.just(self.starship.item3.value)
  }
  
  var listTitle: Observable<String> {
    return Observable<String>.just(self.starship.listTitle)
  }
}
