import UIKit

//Є код

enum CityPreferenceItem: String {
    case nonSmoker = "non_smoker"
    case silence = "silence"
}

class Object {
    public var preselectedConditionsPreferenceOldValue: [String]? = [String]()
    public var preselectedConditionsPreferenceNewValue: [String]? = [String]()
    
    private func сityPreferencesChangedValue(preselectedConditionsPreferenceNewValue: [String], cityPreferenceItem: String) -> Int {
        if self.preselectedConditionsPreferenceOldValue?.count ?? 0 > 0 {
            let preselectedConditionsPreferenceOldValue = self.preselectedConditionsPreferenceOldValue ?? [String]()
            if preselectedConditionsPreferenceNewValue.contains(cityPreferenceItem) && !preselectedConditionsPreferenceOldValue.contains(cityPreferenceItem) {
                return 1
            } else if preselectedConditionsPreferenceNewValue.count > 0 && !preselectedConditionsPreferenceNewValue.contains(cityPreferenceItem) && preselectedConditionsPreferenceOldValue.contains(cityPreferenceItem) {
                return -1
            }
            else if preselectedConditionsPreferenceNewValue.count == 0 {
                if preselectedConditionsPreferenceOldValue.contains(cityPreferenceItem) {
                    return -1
                }
                else {
                    return 0
                }
            }
            return 0
        } else {
            if preselectedConditionsPreferenceNewValue.count > 0 && preselectedConditionsPreferenceNewValue.contains(cityPreferenceItem) {
                return 1
            }
            return 0
        }
    }
    
    public func getDifference() -> [String: Bool] {
        var result = [String: Bool]()
        [CityPreferenceItem.nonSmoker, CityPreferenceItem.silence].forEach({ item in
            let state = сityPreferencesChangedValue(preselectedConditionsPreferenceNewValue: self.preselectedConditionsPreferenceNewValue ?? [String](), cityPreferenceItem: item.rawValue)
            if state != 0 {
                result[item.rawValue] = state != 1 ? false : true
            }
        })
        return result
    }
}

/*
 Задача - максимально його відрефакторить, не зламавши тести нижче.
 */

/*******************************************************************
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!CODE BELOW IS READ_ONLY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ************************************************************************/

func test(number: Int, input1: [String]?, input2: [String]?, expectation: [String: Bool]) {
    let example = Object()
    example.preselectedConditionsPreferenceOldValue = input1
    example.preselectedConditionsPreferenceNewValue = input2
    
    let difference = example.getDifference()
    
    print("Test \(number): " + "\(difference == expectation ? "passed" : "failed")")
}

test(number: 1, input1: nil, input2: ["silence", "non_smoker"], expectation: ["non_smoker": true, "silence": true])
test(number: 2, input1: [], input2: ["silence", "non_smoker"], expectation: ["non_smoker": true, "silence": true])
test(number: 3, input1: ["silence"], input2: ["silence", "non_smoker"], expectation: ["non_smoker" : true])
test(number: 4, input1: ["non_smoker"], input2: ["silence", "non_smoker"], expectation: ["silence":true])
test(number: 5, input1: ["non_smoker", "silence"], input2: ["silence", "non_smoker"], expectation: [:])

test(number: 6, input1: nil, input2: ["silence"], expectation: ["silence": true])
test(number: 7, input1: [], input2: ["silence"], expectation: ["silence": true])
test(number: 8, input1: ["silence"], input2: ["silence"], expectation: [:])
test(number: 9, input1: ["non_smoker"], input2: ["silence"], expectation: ["non_smoker":false, "silence":true])
test(number: 10, input1: ["non_smoker", "silence"], input2: ["silence"], expectation: ["non_smoker":false])

test(number: 11, input1: nil, input2: ["non_smoker"], expectation: ["non_smoker": true])
test(number: 12, input1: [], input2: ["non_smoker"], expectation: ["non_smoker": true])
test(number: 13, input1: ["silence"], input2: ["non_smoker"], expectation: ["non_smoker":true, "silence":false])
test(number: 14, input1: ["non_smoker"], input2: ["non_smoker"], expectation: [:])
test(number: 15, input1: ["non_smoker", "silence"], input2: ["non_smoker"], expectation: ["silence":false])

test(number: 16, input1: nil, input2: [], expectation: [:])
test(number: 17, input1: [], input2: [], expectation: [:])
test(number: 18, input1: ["silence"], input2: [], expectation: ["silence":false])
test(number: 19, input1: ["non_smoker"], input2: [], expectation: ["non_smoker": false])
test(number: 20, input1: ["non_smoker", "silence"], input2: [], expectation: ["non_smoker":false, "silence":false])

test(number: 21, input1: nil, input2: nil, expectation: [:])
test(number: 22, input1: [], input2: nil, expectation: [:])
test(number: 23, input1: ["silence"], input2: nil, expectation: ["silence":false])
test(number: 24, input1: ["non_smoker"], input2: nil, expectation: ["non_smoker": false])
test(number: 25, input1: ["non_smoker", "silence"], input2: nil, expectation: ["non_smoker":false, "silence":false])

