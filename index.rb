require 'colorize'
require 'tty-prompt'
require 'crayon'

$prompt = TTY::Prompt.new

banner = ''"

   ▄██████▄     ▄████████    ▄████████    ▄████████    ▄█   ▄█▄        ▄██████▄   ▄██████▄  ████████▄     ▄████████
  ███    ███   ███    ███   ███    ███   ███    ███   ███ ▄███▀       ███    ███ ███    ███ ███   ▀███   ███    ███
  ███    █▀    ███    ███   ███    █▀    ███    █▀    ███▐██▀         ███    █▀  ███    ███ ███    ███   ███    █▀
 ▄███         ▄███▄▄▄▄██▀  ▄███▄▄▄      ▄███▄▄▄      ▄█████▀         ▄███        ███    ███ ███    ███   ███
▀▀███ ████▄  ▀▀███▀▀▀▀▀   ▀▀███▀▀▀     ▀▀███▀▀▀     ▀▀█████▄        ▀▀███ ████▄  ███    ███ ███    ███ ▀███████████
  ███    ███ ▀███████████   ███    █▄    ███    █▄    ███▐██▄         ███    ███ ███    ███ ███    ███          ███
  ███    ███   ███    ███   ███    ███   ███    ███   ███ ▀███▄       ███    ███ ███    ███ ███   ▄███    ▄█    ███
  ████████▀    ███    ███   ██████████   ██████████   ███   ▀█▀       ████████▀   ▀██████▀  ████████▀   ▄████████▀
               ███    ███                             ▀

"''
# welcoming and Menu
puts banner.yellow
puts 'Hello, welcome to Discover your Greek God'.blue
puts "What is your name?"
name = gets.chomp
puts "Hi #{name}, please"

main_menu = [
  { name: 'Learn about the Greek Gods', value: 1 },
  { name: 'Questionnaire', value: 2 },
  { name: 'Help', value: 3 },
  { name: 'Exit', value: 4 }
]

user_option = $prompt.select('Select an option:'.yellow, main_menu)


class About_menu
  def option_1
    learn_god = [
      { name: 'Athena', value: 1 },
      { name: 'Ares', value: 2 },
      { name: 'Hermes', value: 3 }
    ]

    run_option_1 = $prompt.select('Select a God to learn more about:'.yellow, learn_god)

    # Option 1
    case run_option_1
    when 1
      puts Crayon.on_blue 'The goddess of wisdom and war. Shrewd and clever. The protector of civilization: focus on law and order, math, arts and crafts, and rational thought.'
    when 2
      puts Crayon.on_blue 'The god of war. Strong and violent personality, representing the physical prowess of war and the brutal acts that happen in war.'
    when 3
      puts Crayon.on_blue 'The messenger of the gods and conductor of souls. The patron of thieves, travelers, and merchants.'
    end
  end
end

# Option 2
class Questionnaire_menu
  attr_accessor :god_count

  def initialize
    @god_count = {
      athena: 0,
      ares: 0,
      hermes: 0
    }

    @question1 = 'You are waiting in line at a supermarket. The old lady in front of you drops a $50 note, without realising it. What do you do?'.yellow
    @question2 = "You're in a minor car accident. The person that rear-ended, approaches your window. What do you say?".yellow
    @question3 = 'You are sitting at the table eating dinner. Your loyal dog by your side staring at you. You have one chicken tender left. Do you?'.yellow

    @question1_answers = [
      { id: 'a', text: 'Pick it up and put it in your pocket', god_type: 'hermes' },
      { id: 'b', text: 'Inform the lady she has dropped it', god_type: 'athena' },
      { id: 'c', text: 'You are oblivous to what happened', god_type: 'ares' }
    ]
    @question2_answers = [
      { id: 'a', text: 'You owe me alot of money for that', god_type: 'hermes' },
      { id: 'b', text: 'No one makes me bleed my own blood', god_type: 'ares' },
      { id: 'c', text: 'Do you have insurance', god_type: 'athena' }
    ]
    @question3_answers = [
      { id: 'a', text: 'Give half to your dog', god_type: 'athena' },
      { id: 'b', text: 'Save it for later', god_type: 'hermes' },
      { id: 'c', text: 'Stare directly at your dog and eat the chicken tender', god_type: 'ares' }
    ]
  end

  # method to print question and various answer options
  def print_question(question, answers)
    puts question
    answers.each do |answer|
      puts "#{answer[:id]}. #{answer[:text]}"
    end
  end

  # error message if incorrect user input
  def get_user_answer
       user_answer = gets.chomp

    while !['a', 'b', 'c'].include?(user_answer)
      puts "Error, please select a different answer".red
      user_answer = gets.chomp
    end
    
    user_answer
  end

  # god counter
  def update_god_count(id, answers)
    answers.each do |answer|
      if id == answer[:id]
        god_key = answer[:god_type].to_sym
        @god_count[god_key] += 1
      end
    end
  end

  # keeps track of answers, and returns the highest selected God
  def check_user_god_type
    highest_count = 0
    selected_god = ''

    @god_count.each do |key, value|
      if value > highest_count
        highest_count = value
        selected_god = key.to_s
      end
    end

    selected_god
  end

  # code to execute questionnaire
  def run_questionnaire
    puts 'You will now be asked a series of questions, to determine which Greek God personality you share.'
    puts '================================================================================================'
    puts 'Please type in the option which best relates with you, followed by enter.'
    puts '========================================================================='

    print_question @question1, @question1_answers
    user_answer = get_user_answer
    update_god_count user_answer, @question1_answers

    print_question @question2, @question2_answers
    user_answer = get_user_answer
    update_god_count user_answer, @question2_answers

    print_question @question3, @question3_answers
    user_answer = get_user_answer
    update_god_count user_answer, @question3_answers

    puts 'You are the Greek God' + ' ' + check_user_god_type
  end
end

# help menu, explains general overview of application
class Help_menu
  def help_options
 puts "Discover your Greek God is a fun personality questionnaire which matches your personality with a Greek God.\n\nYou will be presented with a situation and a list of options. When prompted, you must select one of the available options by typing the letter corresponding to the choice and pressing enter. If you enter an invalid key which is not one of the available choices, you will be asked to enter a new key. After all questions have been answered your Greek God will be revealed!"
  end
end



# menu control flow
case user_option
when 1
  About_menu.new.option_1
when 2
  Questionnaire_menu.new.run_questionnaire
when 3
  puts Help_menu.new.help_options
when 4
  puts 'Exit'
end
