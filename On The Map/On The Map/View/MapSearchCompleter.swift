//
//  MapSearchCompleter.swift
//  On The Map
//
//  Created by Kiko Santos on 23/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//


import MapKit

class AcAddress: NSViewController, NSTableViewDelegate, NSTableViewDataSource, MKLocalSearchCompleterDelegate {
    
    var searchString:String?
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    
    @IBOutlet weak var tblAutoComplete: NSTableView!
    
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(AutoComplete), name: NSNotification.Name(rawValue: "AutoComplete"), object: nil)
        searchCompleter.delegate = self
        tblAutoComplete.refusesFirstResponder = true
    }
    
    
    
    @objc func notificationAutoComplete() {
        searchCompleter.queryFragment = searchString ?? ""
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tblAutoComplete.reloadData()
    }
    
    
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return searchResults.count
    }
    
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        // FILL IT
        
    }
    
}
