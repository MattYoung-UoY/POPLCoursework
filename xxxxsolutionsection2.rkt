#lang racket

(define (a-game amount)
  (begin
    (display "You decided to go with the number ")
    (display amount)
    (newline)
    (cond
      [(or (< amount 2) (> amount 30)) (display "Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds")]
      [else
       (begin
         (display "GREAT!!!
Remember, in the game, if the player wins, then he scores 1 point [Game Machine will increase player's account(number) by 1 pound, and deduct 2 pounds from its account].
If the player loses, then he will lose 2 points [Game Machine will deduct 2 pounds from player's account(number), and add 1 pound in its account].
During the game, if the player doesn't have any credit, then the game ends. The player can start a new game by re-register with a deposit.
Generating a random number is now requested. Game Machine is about to generate a random number and compare it with the player's number.")
         (let ([number amount]) number)
       )
       ]
    )
  )
)