import UIKit

public class loggerswift: NSObject {
    
    public func notification(s:AnyObject){
        #if DEBUG
            print("\(s)")
        #endif
    }
    
    public func success(s:AnyObject){
        #if DEBUG
            print("✅ \(s)")
        #endif
    }
    
    public func warning(s:String){
        #if DEBUG
            print("❗WARNING: - \(s)")
        #endif
    }
    
    public func error(s:String){
        #if DEBUG
            print("❌ ERROR: - \(s)")
        #endif
    }
    
    public func emptyRow(){
        #if DEBUG
            print("")
        #endif
    }
    
    public func blankLine(){
        #if DEBUG
            print("--------------------")
        #endif
    }
    
    public func blankStartLine(){
        #if DEBUG
            print("")
            print("--------------------")
        #endif
    }
    
    public func blankEndLine(){
        #if DEBUG
            print("--------------------")
            print("")
        #endif
    }
}
