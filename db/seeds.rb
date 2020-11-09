User.destroy_all
Game.destroy_all
Question.destroy_all
GameQuestion.destroy_all 

#users
chelsey = User.create(name: "Chelsey", password: "1234")
jimmy = User.create(name: "Jimmy", password: "5678")
jackie = User.create(name: "Jackie", password: "9090")
erica = User.create(name: "Erica", password: "4332")
u6 = User.create(username: "A", password: "1234")
u7 = User.create(username: "B", password: "1235")
u8 = User.create(username: "C", password: "1236")
u9 = User.create(username: "D", password: "1237")
u10 = User.create(username: "E", password: "1238")

#games
game1 = Game.create(user_id: chelsey.id, lifeline_1: true, lifeline_2: true, lifeline_3: true )
game2 = Game.create(user_id: jimmy.id, lifeline_1: true, lifeline_2: true, lifeline_3: true )
game3 = Game.create(user_id: jackie.id, lifeline_1: true, lifeline_2: true, lifeline_3: true )
game4 = Game.create(user_id: jimmy.id, lifeline_1: true, lifeline_2: true, lifeline_3: true )
game5 = Game.create(user_id: erica.id, lifeline_1: true, lifeline_2: true, lifeline_3: true )
g6 = Game.create(user_id: u6.id, lifeline_1: true, lifeline_2: true, lifeline_3: true)
g7 = Game.create(user_id: u7.id, lifeline_1: true, lifeline_2: true, lifeline_3: true)
g8 = Game.create(user_id: u8.id, lifeline_1: true, lifeline_2: true, lifeline_3: true)
g9 = Game.create(user_id: u9.id, lifeline_1: true, lifeline_2: true, lifeline_3: true)
g10 = Game.create(user_id: u10.id, lifeline_1: true, lifeline_2: true, lifeline_3: true)


#Questions
q1 = Question.create(value_of_question: 10, difficulty: "easy", question: "What is the name of the green lady statue in NYC?", correct_answer: "Statue of Liberty", incorrect_answer_1: "Bull", incorrect_answer_2: "Cat", incorrect_answer_3: "Dog")
q2 = Question.create(value_of_question: 50, difficulty: "medium", question: "Where is Argentina?", correct_answer: "South America", incorrect_answer_1: "Bull", incorrect_answer_2: "Cat", incorrect_answer_3: "Dog")
q3 = Question.create(value_of_question: 10, difficulty: "easy", question: "Where is Mexico?", correct_answer: "Central America", incorrect_answer_1: "Bull", incorrect_answer_2: "Cat", incorrect_answer_3: "Dog")
q4 = Question.create(value_of_question: 100, difficulty: "hard", question: "What is the capital of Alaska?", correct_answer: "Juneau", incorrect_answer_1: "Bull", incorrect_answer_2: "Cat", incorrect_answer_3: "Dog")
q5 = Question.create(value_of_question: 100, difficulty: "hard", question: "What is the capital of Oregon?", correct_answer: "Salem", incorrect_answer_1: "Bull", incorrect_answer_2: "Cat", incorrect_answer_3: "Dog")

q6 = Question.create(value_of_question: 10, diffcicult: "easy", question: "What is the capital of France?", correct_answer: "Paris", incorrect_answer_1: "London", incorrect_answer_2: "Madrid", incorrect_answer_3: "Lyon")
q7 = Question.create(value_of_question: 10, diffcicult: "easy", question: "What is the capital of USA?", correct_answer: "Washington, DC", incorrect_answer_1: "London", incorrect_answer_2: "Madrid", incorrect_answer_3: "Lyon")
q8 = Question.create(value_of_question: 10, diffcicult: "easy", question: "What is the capital of Spain?", correct_answer: "Madrid", incorrect_answer_1: "London", incorrect_answer_2: "Barcelona", incorrect_answer_3: "Lyon")
q9 = Question.create(value_of_question: 50, diffcicult: "medium", question: "What is the capital of Canada?", correct_answer: "Ottawa", incorrect_answer_1: "London", incorrect_answer_2: "Madrid", incorrect_answer_3: "Lyon")
q10 = Question.create(value_of_question: 100, diffcicult: "hard", question: "What is the capital of Australia?", correct_answer: "Canberra", incorrect_answer_1: "London", incorrect_answer_2: "Madrid", incorrect_answer_3: "Lyon")

#gamequestion

gq1 = GameQuestion.create(game_id: game1.id, question_id: q4, correct_answer: 0)
gq2 = GameQuestion.create(game_id: game2.id, question_id: q3, correct_answer: 0)
gq3 = GameQuestion.create(game_id: game3.id, question_id: q2, correct_answer: 0)
gq4 = GameQuestion.create(game_id: game4.id, question_id: q1, correct_answer: 0)
gq5 = GameQuestion.create(game_id: game4.id, question_id: q5, correct_answer: 0)


gq6 = GameQuestion.create(game_id: g6.id, question_id: q6.id, correct_answer: 0)
gq7 = GameQuestion.create(game_id: g7.id, question_id: q7.id, correct_answer: 0)
gq8 = GameQuestion.create(game_id: g8.id, question_id: q8.id, correct_answer: 0)
gq9 = GameQuestion.create(game_id: g9.id, question_id: q9.id, correct_answer: 0)
gq10 = GameQuestion.create(game_id: g10.id, question_id: q10.id, correct_answer: 0)

