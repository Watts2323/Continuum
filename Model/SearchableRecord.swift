//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Xavier on 9/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation


protocol SearchableRecord{
    
    func matches(searchTerm: String) -> Bool
    
}
