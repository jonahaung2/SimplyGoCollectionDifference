
import Foundation

public func diff<T: DiffAware>(old: [T], new: [T]) -> [Change<T>] {
    let heckel = Heckel<T>()
    return heckel.diff(old: old, new: new)
}

public func preprocess<T>(old: [T], new: [T]) -> [Change<T>]? {
    switch (old.isEmpty, new.isEmpty) {
    case (true, true):
        // empty
        return []
    case (true, false):
        // all .insert
        return new.enumerated().map { index, item in
            return .insert(Insert(item: item, index: index))
        }
    case (false, true):
        // all .delete
        return old.enumerated().map { index, item in
            return .delete(Delete(item: item, index: index))
        }
    default:
        return nil
    }
}
