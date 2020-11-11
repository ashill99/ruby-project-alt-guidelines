require "tty-prompt"

prompt = TTY::Prompt.new

require "tty-prompt"
require "pry"

class CLI

    @@current_game = nil 
    @@prompt = TTY::Prompt.new

    def greet 
        pastel = Pastel.new
        font = TTY::Font.new(:starwars)
        font2 = TTY::Font.new(:doom)
        puts pastel.yellow(font2.write("                                                                WHO"))        
        # sleep(0.5)
        puts ""
        puts pastel.yellow(font2.write("                 WANTS                                              TO"))  
        # sleep(0.5)
        puts pastel.yellow(font2.write("BE                                                                                                              A"))                                                                           
        # sleep(0.5)
        puts ""
        puts pastel.green(font.write("         THOUSANDAIRE"))
        puts ""
    end

    def run 
        greet
        # sleep(1)
        display_menu
    end 

    def display_menu 
            choices = [ 
                { "Log in" => 1},
                { "Create new user" => 2},
                { "See Leaderboard" => 3},
                { "Quit" => 4}
            ]
            user_input = @@prompt.select("What would you like to do?", choices)
                case user_input 
                when 1 
                    CLI.log_in
                when 2 
                    CLI.new_user_create 
                when 3
                    CLI.leaderboard
                when 4
                    exit! 
                end
    end

    def self.log_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Welcome back! Remind us of your name?")
        password = prompt.mask("Enter your password:")
        if User.find_by(username: username, password: password)
            @user = User.find_by(username: username, password: password)
            @user
            CLI.play_menu
        elsif User.find_by(username: username)
            puts "Incorrect Password, please try again:"
            CLI.log_in
            # quit if entered 3 times?
        else 
            system('clear')
            puts "hmm...we can't find you. Create a new user? "
            CLI.new_user_create
        end
    end 

    def self.play_menu 
        choices = [ 
                { "Play a new game" => 1},
                { "See high scores" => 2},
                { "See leaderboard" => 3},
                { "Delete your account" => 4},
                { "Quit" => 5}
            ]
            user_input = @@prompt.select("Welcome! Are you ready to win big?", choices)
                case user_input 
                when 1 
                    puts "Get your trigger finger ready!"
                    CLI.start_game 
                when 2 
                    puts "The scores on the doors are..."
                    CLI.see_scores
                when 3
                    puts "Take me to your leader"
                    CLI.leaderboard
                when 4
                    User.delete(@user)
                    puts "You have deleted your user account."
                    system('clear')
                    CLI.log_in
                when 5
                    puts "The pressure got too much for you huh?"
                    exit!
                end
    end

    def self.new_user_create
        prompt = TTY::Prompt.new
        username = prompt.ask("Whats your name, friend?")
        password = prompt.mask("Set your password:")
            if User.find_by(username: username, password: password)
            puts "User already exists, log in here:"
            CLI.log_in
        else 
        @user = User.create(username: username, password: password)
        CLI.play_menu
        end 
    end

    def self.start_game    
        prompt = TTY::Prompt.new
        @score = 0 
        @this_game = Game.create(user_id: @user.id, lifeline_1: true, lifeline_2: true, lifeline_3: true, score: @score)

        CLI.question_easy
        @score += 10 
        CLI.update_score
                #how do we not hard code this?
        CLI.question_easy
        @score += 10 
        CLI.update_score        #how do we not hard code this?
        CLI.question_easy
        @score += 10 
        CLI.update_score        #how do we not hard code this?
        # CLI.question_medium
        # CLI.question_medium
        # CLI.question_medium
        # CLI.question_medium
        # CLI.question_hard
        # CLI.question_hard
        # CLI.question_hard
        
        # @@current_game.score = @score 
        CLI.update_score
        puts "Congratulations, you are officially a Thousandaire"
        #    binding.pry
    end

#QUESTIONS -how to avoid repeats.

    def self.update_score 
        @this_game.update_column(:score, @score) 
    end

    def self.question_easy 
        p " "
        
            question = Question.all.select { |q| q.difficulty == "easy"}.sample
            answers = [ 
                  {"#{question.correct_answer}" => 1},
                  {"#{question.incorrect_answer_1}" => 2},
                  {"#{question.incorrect_answer_2}" => 3},
                  {"#{question.incorrect_answer_3}" => 4}
                      ].shuffle
            lifelines = [
                    {"50/50" => 5},
                    {"Phone a Friend" => 6},
                    {"Ask the Audience" => 7},
                    ]
            # 5answers = [
            #         {"#{question.correct_answer}" => 1},
            #         {"#{question.incorrect_answer_1}" => 2}
            #             ].shuffle
                    loop do
                        
                        user_answer = @@prompt.select("#{question.question}",
                        answers, "\n Use a lifeline:",  lifelines)
        
        # p @score 
        # p @this_game
        
        # answers = [ 
        #     { "#{Question.first.incorrect_answer_1}" => 1},
        #     { "#{Question.first.incorrect_answer_2}" => 2},
        #     { "#{Question.first.correct_answer}" => 3},
        #     { "#{Question.first.incorrect_answer_3}" => 4}
        # ]
        # user_answer = @@prompt.select("#{Question.first.question}",
        #  answers)
        # if user_answer == Question.first.correct_answer
        #     continue_game
        # else 
        #     puts "Incorrect! You lose!!!"
        #     # display_score 
    end

#QUESTIONS -how to avoid repeats.
    def self.question_easy 
        question = Question.all.select { |q| q.difficulty == "easy"}.sample
        GameQuestion.create(game_id: @this_game.id, question_id: question.id, correct_answer: question.correct_answer)
        binding.pry
     
        answers = [ 
                "#{question.incorrect_answer_1}",
                "#{question.incorrect_answer_2}",
                "#{question.correct_answer}",
                "#{question.incorrect_answer_3}"
    ].shuffle
            user_answer = @@prompt.select("#{question.question}",
             answers)
            
            if user_answer == question.correct_answer
                # sleep(1.5)
                puts "Congratulations, #{@user.username}, that is the correct answer"
                puts "You banked #{question.value_of_question}"
               when 2 
                puts "Incorrect! You lose!!!"
                #  display score 
                exit!
               when 3 
                puts "Incorrect! You lose!!!"
                      #  display score 
                      exit!
               when 4 
                puts "Incorrect! You lose!!!"
                      #  display score 
                      exit!
               when 5 
                # 50_50
               when 6 
                puts "You have 30 seconds to phone a friend, make it count" 
                    CLI.phone_a_friend 
            #    rescue
            #     retry  
            #    end
               when 7 
                puts "You have 30 seconds to ask the audience, let's hope they know!" 
                CLI.ask_the_audience
               end 
            end

                            case user_answer 
                            when 1
                                # sleep(1.5)
                                puts "Congratulations, #{@user.username}, that is the correct answer"
                                puts "You banked #{question.value_of_question}"
                            break
                        when 2 
                            puts "Incorrect! You lose!!!"
                            puts "You scored #{@this_game.score} points."
                            #  display score 
                            exit
                           when 3 
                            puts "Incorrect! You lose!!!"
                                  #  display score 
                                  puts "You scored #{@this_game.score} points."
                                  exit
                           when 4 
                            puts "Incorrect! You lose!!!"
                                  #  display score 
                                  puts "You scored #{@this_game.score} points."
                                  exit
                           when 5 
                            # 50_50
                                # puts user_answer2 = @@prompt.select("#{question.question}",
                                # 5050_answers)
                                # if user_answer2 == 1
                                #     break 
                                # else 
                                #     puts "You had a 50/50 chance and you blew it!"
                                #     exit
                                # end 
                           when 6 
                            # if Game.lifeline_2 == true 
                            puts "You have 30 seconds to phone a friend, make it count" 
                                CLI.phone_a_friend 
                            #     Game.lifeline_2 = false 
                            # end
                            # else 
                                # puts "You have used your lifeline"
                                # lifelines.reject { |h| h["Phone a Friend"] }
                           when 7 
                            puts "You have 30 seconds to ask the audience, let's hope they know!" 
                            CLI.ask_the_audience
                           end
                        end
                    end      

            # def timer(seconds)
            #     Timer.new(seconds) { raise Timeout::Error, "timeout!" }
            # end

            def check_phone_a_friend 
                Game.all.select { |game| game.user_id == @user}
            end


            def self.time_seconds 
                t1 = Time.now 
                puts t1.sec 
            end 

            def self.countdown_timer 
                3.downto(0) do |i|
                    puts "00:00:#{'%02d' % i}"
                    sleep 1
                    # "I'm sorry time is up"
                end
            end
            
            # def 50_50 
            # end

            def self.phone_a_friend 
                CLI.countdown_timer 
            end

            def self.ask_the_audience
                CLI.countdown_timer
            end
            
            def self.leaderboard 
                all_scores = Game.all.max_by(10) { |g| g.score} 
                user_id = all_scores.map { |game| game.user_id }
                players = user_id.map {|id| User.find(id).username}
                scores = all_scores.map { |g| g.score }
                # binding.pry
                i = 0
                while i < 10
                 puts "#{i + 1}. #{players[i]}: #{scores[i]}"
                 i +=1
                end 
             end
        
             def self.see_scores
                players_games = Game.all.find_all { |g| g.user_id == @user.id}
                p1 = players_games.map { |pg| pg.score}
                p2 = p1.max(5)
                puts "Your top scores are:\n"  
                p2.each.with_index(1) do |s, i| puts "#{i}. #{s}" end
            end 

    # def self.question_medium 
    #     question = Question.all.select { |q| q.difficulty == "medium"}.sample
     
    #     answers = [ 
    #             "#{question.incorrect_answer_1}",
    #             "#{question.incorrect_answer_2}",
    #             "#{question.correct_answer}",
    #             "#{question.incorrect_answer_3}"
    # ].shuffle
    #         user_answer = @@prompt.select("#{question.question}",
    #          answers)
    #         #  binding.pry
    #         if user_answer == question.correct_answer
    #             # sleep(1.5)
    #             puts "Congratulations, that is the correct answer"
    #             puts "You banked #{question.value_of_question}"
    #             #add question value to user high score 
    #             # total = @this_game.score += question.value_of_question

    #             # continue_game
    #         else 
    #             puts "Incorrect! You lose!!!"
    #             # display_score 
    #             exit!
    #         end
    #     end
    
    # def self.question_hard
    #     question = Question.all.select { |q| q.difficulty == "hard"}.sample
     
    #     answers = [ 
    #             "#{question.incorrect_answer_1}",
    #             "#{question.incorrect_answer_2}",
    #             "#{question.correct_answer}",
    #             "#{question.incorrect_answer_3}"
    # ].shuffle
    #         user_answer = @@prompt.select("#{question.question}",
    #          answers)
    #         #  binding.pry
    #         if user_answer == question.correct_answer
    #             # sleep(1.5)
    #             puts "Congratulations, that is the correct answer"
    #             #add question value to user high score 
    #             # User.score += question.value_of_question

    #             # continue_game
    #         else 
    #             puts "Incorrect! You lose!!!"
    #             # display_score 
    #             exit!
    #         end
    #     end
end
