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
         (let ([number amount])
           (begin
             (newline)
             (define (the-game-number request)
               (cond
                 [(equal? request 'randomnum)
                  (define (randomnum randnum)
                    (let([random (+ 2 (random 49))])
                      (begin
                        (display "The random number is: ")
                        (display random)
                        (newline)
                        (display "Game Player, your number is: ")
                        (display number)
                        (newline)
                        (newline)
                        (display "If your number is less than or equal the random number, you lose, otherwise you win.")
                        (newline)
                        (cond
                          [(or (< number random) (equal? number random)) (display "Unfortunately, you have lost, Game Machine will deduct 2 pounds from your account.")]
                          [else (display "Great, you have won, Game Machine will add one pound in your account.")]
                        )
                      )
                    )
                  ) randomnum]
                 [(equal? request 'increasemoney) (display "increasemoney")]
                 [(equal? request 'decreasemoney)
                  (define decreasemoney
                    (begin
                      (display "Game Player, previously you had: ")
                      (display number)
                      (display " pound(s)")
                      (newline)
                      (newline)
                      (display "You have lost, Game Machine is deducting 2 pounds from your account!")
                      (set! number (- number 2))
                      (newline)
                      (newline)
                      (display "You now have: ")
                      (display number)
                      (display " pound(s)")
                      (newline)
                      (cond
                        [(> number 1) (display "You still have enough credit to play.")]
                        [else (display "Sorry, you are out of credit, which you can't continue to play. To continue playing, you need to top-up. See you soon!!!")]
                        )
                      )
                    ) decreasemoney
                 ]
                 [(equal? request 'topup)
                  (define (topup amount)
                    (begin
                      (let ([t amount])
                        (begin
                          (set! number t)
                          (cond
                            [(> number 2)
                             (begin
                               (display "Game Player, you just topped up: ")
                               (display number)
                               (display " pound(s)")
                               (newline)
                               (display "Great, you can play now")
                             )
                            ]
                            [else
                             (begin
                               (display "Game Player, you just topped up: ")
                               (display number)
                               (display " pound(s)")
                               (newline)
                               (display "Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds")
                             )
                            ]
                          )
                        )
                      )
                    )
                  ) topup
                 ]
                 [else (error "unknown request" request)]
                 )
               ) the-game-number
             )
           )
         )
       ]
    )
  )
)