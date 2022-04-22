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
# Welcoming and Menu
puts banner.yellow
puts 'Hello. Welcome to Discover your Greek God'.blue

main_menu = [
  { name: 'Learn about the Greek Gods', value: 1 },
  { name: 'Questionnaire', value: 2 },
  { name: 'Help', value: 3 },
  { name: 'Exit', value: 4 }
]

user_option = $prompt.select('Select an option:'.yellow, main_menu)

# Option 1
class About
  def option_1
    learn_god = [
      { name: 'Athena', value: 1 },
      { name: 'Ares', value: 2 },
      { name: 'Hermes', value: 3 }
    ]

    run_option_1 = $prompt.select('Select a God to learn more about:'.yellow, learn_god)

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
class Questionnaire
  attr_accessor :god_count

  def initialize
    @god_count = {
      athena: 0,
      ares: 0,
      hermes: 0
    }

    @question1 = 'You are waiting in line at a supermarket. The old lady in front of you drops a $50 note, without realising it. What do you do?'
    @question2 = "You're in a minor car accident. The person that rear-ended, approaches your window. What do you say?"
    @question3 = 'You are sitting at the table eating dinner. Your loyal dog by your side staring at you. You have one chicken tender left. Do you?'

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

  def print_question(question, answers)
    puts question
    answers.each do |answer|
      puts "#{answer[:id]}. #{answer[:text]}"
    end
  end

  # def get_user_answer
  #     while user_answer != ['a', 'b', 'c'].includes(user_answer)
  #     puts "error, please select a different answer"
  #     user_answer = gets.chomp
  #     end

  #     return user_answer
  # end

  def get_user_answer
    user_answer = ''
    while user_answer != %w[a b c]
      puts 'error, please select a different answer'
      user_answer = gets.chomp
    end

    user_answer
  end

  def update_god_count(id, answers)
    answers.each do |answer|
      if id == answer[:id]
        god_key = answer[:god_type].to_sym
        @god_count[god_key] += 1
      end
    end
  end

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

  # Code to execute questionnaire
  def run_questionnaire
    puts 'You will now be asked a series of questions, to determine which Greek God personality you share.'
    puts '================================================================================================'
    puts 'Please type in the option which best relates with you, followed by enter.'
    puts '========================================================================='

    print_question @question1, @question1_answers
    user_answer = gets.chomp
    update_god_count user_answer, @question1_answers

    print_question @question2, @question2_answers
    user_answer = gets.chomp
    update_god_count user_answer, @question2_answers

    print_question @question3, @question3_answers
    user_answer = gets.chomp
    update_god_count user_answer, @question3_answers

    puts 'You are the Greek God' + ' ' + check_user_god_type
  end
end

# menu control flow
case user_option
when 1
  About.new.option_1
when 2
  Questionnaire.new.run_questionnaire
when 3
  puts 'Help'
when 4
  puts 'Exit'
end
