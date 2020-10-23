//
//  FilmViewModel.swift
//  AlamoFire_tuto
//
//  Created by 김광수 on 2020/10/23.
//

import Foundation
import RxSwift

struct FilmListViewModel {
  let films: [FilmViewModel]
  
  init(_ films: [Film]) {
    self.films = films.compactMap(FilmViewModel.init)
  }
}

extension FilmListViewModel {

  func filmAt(_ index: Int)-> FilmViewModel {
    return self.films[index]
  }
  
}


struct FilmViewModel {
  let film: Film
  
  init(_ film: Film) {
    self.film = film
  }
}

extension FilmViewModel {
  
  var titleLabelText: Observable<String> {
    return Observable<String>.just(self.film.title)
  }
  
  var subtitleLabelText: Observable<String> {
    return Observable<String>.just(self.film.subtitleLabelText)
  }
  
  var item1LabelText: Observable<String> {
    return Observable<String>.just(self.film.item1.label)
  }
  
  var item1ValueText: Observable<String> {
    return Observable<String>.just(self.film.item1.value)
  }
  
  var item2LabelText: Observable<String> {
    return Observable<String>.just(self.film.item2.label)
  }
  
  var item2ValueText: Observable<String> {
    return Observable<String>.just(self.film.item2.value)
  }
  
  var item3LabelText: Observable<String> {
    return Observable<String>.just(self.film.item3.label)
  }
  
  var item3ValueText: Observable<String> {
    return Observable<String>.just(self.film.item3.value)
  }
  
  var listTitle: Observable<String> {
    return Observable<String>.just(self.film.listTitle)
  }
}
