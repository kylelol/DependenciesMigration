import Foundation
import MyService

extension MyService {
    
    public static var live = MyService(
        doSomething: {
            print("We did something")
        }
    )
}
