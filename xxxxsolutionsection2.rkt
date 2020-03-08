#lang racket

;Defining the a-game-amount function
(define (a-game amount)
  (begin
    ;Displaying the welcome text
    (display "You decided to go with the number ")
    (display amount)
    (newline)
    ;Displays the appropriate text depending on if the user has entered a valid value or not
    (cond
      ;If the input is not valid, it informs the user that this is the case
      [(or (< amount 2) (> amount 30)) (display "Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds")]
      ;If the input is valid, it informs the user that this is the case
      [else
       (begin
         (display "GREAT!!!
Remember, in the game, if the player wins, then he scores 1 point [Game Machine will increase player's account(number) by 1 pound, and deduct 2 pounds from its account].
If the player loses, then he will lose 2 points [Game Machine will deduct 2 pounds from player's account(number), and add 1 pound in its account].
During the game, if the player doesn't have any credit, then the game ends. The player can start a new game by re-register with a deposit.
Generating a random number is now requested. Game Machine is about to generate a random number and compare it with the player's number.")
         ;Creates the local variable number
         (let ([number amount])
           (begin
             (newline)
             ;Defines the request function
             (define (the-game-number request)
               ;Checks which function has been requested
               (cond
                 [(equal? request 'randomnum)
                  ;Defines the randomnum function
                  (define (randomnum randnum)
                    ;Generates a random number from 2 to 50 inclusive, and stores it in the local variable random
                    (let([random (+ 2 (random 49))])
                      (begin
                        ;Informs the user of the random number
                        (display "The random number is: ")
                        (display random)
                        (newline)
                        (display "Game Player, your number is: ")
                        (display number)
                        (newline)
                        (newline)
                        (display "If your number is less than or equal the random number, you lose, otherwise you win.")
                        (newline)
                        ;Informs the user if they have won or lost
                        (cond
                          [(or (< number random) (equal? number random)) (display "Unfortunately, you have lost, Game Machine will deduct 2 pounds from your account.")]
                          [else (display "Great, you have won, Game Machine will add one pound in your account.")]
                        )
                      )
                    )
                  ) randomnum]
                 [(equal? request 'increasemoney)
                  ;Defines the increasemoney function
                  (define increasemoney
                    (begin
                      ;Informs the player of the previous amount
                      (display "Game Player, previously you had: ")
                      (display number)
                      (display " pound(s)")
                      (newline)
                      (newline)
                      (display "You have scored 1 point, and been awarded 1 pound by the Game Machine!")
                      (newline)
                      ;Increments number
                      (set! number (+ number 1))
                      ;Informs the user of the new amount
                      (display "You now have: ")
                      (display number)
                      (display " pound(s)")
                    )
                  ) increasemoney
                 ]
                 [(equal? request 'decreasemoney)
                  ;Defines the decreasemoney function
                  (define decreasemoney
                    (begin
                      ;Informs the player of the previous amount
                      (display "Game Player, previously you had: ")
                      (display number)
                      (display " pound(s)")
                      (newline)
                      (newline)
                      (display "You have lost, Game Machine is deducting 2 pounds from your account!")
                      ;Decrements the amount by 2
                      (set! number (- number 2))
                      (newline)
                      (newline)
                      ;Informs the user of the new amount
                      (display "You now have: ")
                      (display number)
                      (display " pound(s)")
                      (newline)
                      ;Checks to see if the new amount is enough to play a game, and informs the user appropriately
                      (cond
                        [(> number 1) (display "You still have enough credit to play.")]
                        [else (display "Sorry, you are out of credit, which you can't continue to play. To continue playing, you need to top-up. See you soon!!!")]
                        )
                      )
                    ) decreasemoney
                 ]
                 [(equal? request 'topup)
                  ;Defines the topup function
                  (define (topup amount)
                    (begin
                      ;Creates the local variable t and sets it to amount
                      (let ([t amount])
                        (begin
                          ;Sets number equal to t
                          (set! number t)
                          ;Informs the user of the new amount
                          (display "Game Player, you just topped up: ")
                          (display number)
                          (display " pound(s)")
                          (newline)
                          ;Checks to see if the new amount is enough to play a game, and informs the user appropriately
                          (cond
                            [(> number 2) (display "Great, you can play now")]
                            [else (display "Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds")]
                          )
                        )
                      )
                    )
                  ) topup
                 ]
                 ;Gives an error if the requested function is not known
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

;Defines the game machine amount
(define game_machine_amount 10)

;Defines the game_machine_decrement function
(define (game_machine_decrement)
  (begin
    ;Informs the user how much the game machine has
    (display "Game Machine, previously you had: ")
    (display game_machine_amount)
    (display " pound(s)")
    (newline)
    ;Decrements the game_machine_amount by 2
    (set! game_machine_amount (- game_machine_amount 2))
    ;Informs the user of the new game_machine_amount
    (display "You now have: ")
    (display game_machine_amount)
    (display " pound(s)")
    (newline)
    ;Checks to see if the new game_machine_amount is enough to play a game, and informs the user appropriately
    (cond
      [(> game_machine_amount 1) (display "Game Machine, there is still enough money in the machine for a game to be played")]
      [else (display "Game Machine, there isn't any credit in the machine for a game to be played, needs to top up")]
    )
  )
)

;Defines the game_machine_increment function
(define (game_machine_increment)
  (begin
    ;Informs the user of the current game_machine_amount
    (display "Game Machine, before you had: ")
    (display game_machine_amount)
    (display " pound(s)")
    (newline)
    ;Increments game_machine_amount
    (set! game_machine_amount (+ game_machine_amount 1))
    ;Informs the user of the new game_machine_amount
    (display "You now have: ")
    (display game_machine_amount)
    (display " pound(s)")
  )
)