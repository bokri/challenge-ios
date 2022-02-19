//
//  ViewModel.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa


public class ViewModel {
    
    private weak var delegate: ViewDelegate?
    private let disposeBag = DisposeBag()
    
    private var state = BehaviorRelay<State>(value: .loading)
    public var banks = BehaviorRelay<[String: [Bank]]>(value: [:])
    public var countries: [String] = []

    private var databaseToken: DatabaseToken?
    
    public init() {
        let countryCode = Locale.current.languageCode ?? String(Locale.preferredLanguages[0].prefix(2))
        
        self.databaseToken = BankinManager.banksDatabaseTokens(completion: { banks in
            let banksGroupedByCountries = Dictionary(grouping: banks, by: { (element: Bank) in
                return element.countryCode
            })
            
            self.countries = banksGroupedByCountries.keys.sorted { lhs, rhs in
                if lhs == countryCode.uppercased() {
                    return true
                } else if rhs == countryCode.uppercased() {
                    return false
                } else {
                    return true
                }
            }
            
            self.banks.accept(banksGroupedByCountries)
        })
        
        self.banks
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { banks in
                if banks.isEmpty {
                    self.state.accept(.error)
                } else {
                    self.state.accept(.success)
                }

                self.delegate?.reloadTableView()
            }).disposed(by: self.disposeBag)

        self.state.subscribe(onNext: { state in
            switch state {
            case .loading:
                self.delegate?.showLoading()
            case .error:
                self.delegate?.showError()
            case .success:
                self.delegate?.showSuccess()
            }
        }).disposed(by: self.disposeBag)
    }
    
    public func setupDelegate(delegate: ViewDelegate?) {
        self.delegate = delegate
    }
    
    deinit {
        self.databaseToken?.invalidate()
    }

    public func loadingFlow() {
        self.state.accept(.loading)

        BankinManager.fetchBanks()
            .subscribe(onError: { error in
                self.state.accept(.error)
            }).disposed(by: self.disposeBag)
    }
    
    public func loadNextPage() {
        BankinManager.fetchNextPage()
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}

public enum State {
    case loading
    case success
    case error
}
