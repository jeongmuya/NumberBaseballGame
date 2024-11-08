//
//  main.swift
//  NumberBaseballGame
//
//  Created by YangJeongMu on 11/8/24.
//

import Foundation

// BaseballGame.swift
class BaseballGame {
    // MARK: - Properties
    private var answer: [Int] = []
    
    // MARK: - Public Methods
    func start() {
        setupGame()
        playGame()
    }
    
    // MARK: - Private Methods
    private func setupGame() {
        answer = makeAnswer()
        print("< 게임을 시작합니다 >")
    }
    
    private func makeAnswer() -> [Int] {
        var numbers: Set<Int> = []
        while numbers.count < 3 {
            let randomNum = Int.random(in: 1...9)
            numbers.insert(randomNum)
        }
        return Array(numbers)
    }
    
    private func playGame() {
        while true {
            print("숫자를 입력하세요")
            guard let userInput = readLine() else { continue }
            
            // 입력값 검증
            guard let userNumbers = validateInput(userInput) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            // 결과 확인
            let result = checkResult(userNumbers)
            
            // 게임 종료 조건
            if result.strikes == 3 {
                print("정답입니다!")
                break
            }
            
            // 결과 출력
            printResult(result)
        }
    }
    
    private func validateInput(_ input: String) -> [Int]? {
        // 1. 3자리 숫자인지 확인
        guard input.count == 3,
              let number = Int(input) else { return nil }
        
        // 2. 각 자리수를 배열로 변환
        let digits = String(number).compactMap { Int(String($0)) }
        
        // 3. 유효성 검사
        guard digits.count == 3,                    // 3자리인지
              !digits.contains(0),                  // 0을 포함하지 않는지
              Set(digits).count == digits.count     // 중복된 숫자가 없는지
        else { return nil }
        
        return digits
    }
    
    private func checkResult(_ userNumbers: [Int]) -> (strikes: Int, balls: Int) {
        var strikes = 0
        var balls = 0
        
        for (index, number) in userNumbers.enumerated() {
            if number == answer[index] {
                strikes += 1
            } else if answer.contains(number) {
                balls += 1
            }
        }
        
        return (strikes, balls)
    }
    
    private func printResult(_ result: (strikes: Int, balls: Int)) {
        if result.strikes == 0 && result.balls == 0 {
            print("Nothing")
        } else {
            var resultString = ""
            if result.strikes > 0 {
                resultString += "\(result.strikes)스트라이크"
            }
            if result.balls > 0 {
                if !resultString.isEmpty {
                    resultString += " "
                }
                resultString += "\(result.balls)볼"
            }
            print(resultString)
        }
    }
}

// main.swift
let game = BaseballGame()
game.start()
