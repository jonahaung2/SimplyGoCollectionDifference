//
//  MainQueue+Synchronous.swift
//  Msgr
//
//  Created by Aung Ko Min on 12/10/22.
//

import UIKit
public extension UICollectionView {
    
    func reload<T: DiffAware>(
        changes: [Change<T>],
        section: Int = 0,
        updateData: () -> Void,
        completion: ((Bool) -> Void)? = nil) {
            let changesWithIndexPath = IndexPathConverter().convert(changes: changes, section: section)
            performBatchUpdates({
                updateData()
                insideUpdate(changesWithIndexPath: changesWithIndexPath)
            }, completion: { finished in
                completion?(finished)
            })
            
            // reloadRows needs to be called outside the batch
            outsideUpdate(changesWithIndexPath: changesWithIndexPath)
        }
    
    // MARK: - Helper
    
    private func insideUpdate(changesWithIndexPath: ChangeWithIndexPath) {
        changesWithIndexPath.deletes.executeIfPresent {
            deleteItems(at: $0)
        }
        
        changesWithIndexPath.inserts.executeIfPresent {
            insertItems(at: $0)
        }
        
        changesWithIndexPath.moves.executeIfPresent {
            $0.forEach { move in
                moveItem(at: move.from, to: move.to)
            }
        }
    }
    
    private func outsideUpdate(changesWithIndexPath: ChangeWithIndexPath) {
        changesWithIndexPath.replaces.executeIfPresent {
            self.reloadItems(at: $0)
        }
    }
}
