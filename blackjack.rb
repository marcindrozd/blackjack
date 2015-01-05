SUITS = ["H", "S", "D", "C"]
VALUES = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]

def build_deck(number_of_decks)
  deck = []
  number_of_decks.times do
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << value.to_s + suit
      end
    end
  end
  deck.shuffle
end

def hit(who, deck)
  who << deck.pop
end

def count_total(array)
  total = 0
  array.each do |card|
    if card.to_i != 0
      total += card.to_i
    elsif card[0] == "A"
      total += 11
    else
      total += 10
    end
  end

  # Additional aces calculation
  array.select { |item| item =~ /[A]/}.count.times do
    total -= 10 if total > 21
  end 

  total
end

while true
  system("clear")

  puts "Hello! Let's play Blackjack!"
  puts "What is your name?"
  player_name = gets.chomp

  deck = build_deck(1)

  player_cards = []
  dealer_cards = []

  bust = false
  win = false

  2.times { hit(player_cards, deck) }
  2.times { hit(dealer_cards, deck) }

  puts "#{player_name} has the following cards in hand: #{player_cards.join(", ")}."
  puts "The total for #{player_name} is #{count_total(player_cards)}."
  puts "Dealer has the following cards in hand: #{dealer_cards.first} and one other card."
  puts

  while !bust && !win
    if count_total(player_cards) == 21
      puts "Blackjack! #{player_name} wins!"
      win = true
      break
    elsif count_total(player_cards) > 21
      puts "#{player_name} busts and loses!"
      bust = true
      break
    else
      puts "Would you like to hit or stay? (h/s)"
      answer = gets.chomp

      while answer.downcase != "h" && answer.downcase != "s"
        puts "Please select either 'h' for hit of 's' for stay."
        answer = gets.chomp
      end

      if answer == "h"
        puts "...Drawing another card..."
        hit(player_cards, deck)
        puts "#{player_name} has the following cards in hand: #{player_cards.join(", ")}."
        puts "The total for #{player_name} is #{count_total(player_cards)}."
      else
        puts "You selected to stay."
        puts
        break
      end
    end
  end

  if !bust && !win
    puts "Dealer has the following cards in hand: #{dealer_cards.join(", ")}"
    puts "The total for dealer is #{count_total(dealer_cards)}."
    while count_total(dealer_cards) < 17
      puts "...Drawing another card..."
      hit(dealer_cards, deck)
      puts "Dealer has the following cards in hand: #{dealer_cards.join(", ")}"
      puts "The total for dealer is #{count_total(dealer_cards)}."
      if count_total(dealer_cards) == 21
        puts "Blackjack! Dealer wins!"
        win = true
        break
      elsif count_total(dealer_cards) > 21
        puts "Dealer busts and loses!"
        bust = true
        break
      end
    end
  end

  if !bust && !win
    puts "#{player_name} cards total is: #{count_total(player_cards)}."
    puts "Dealer cards total is: #{count_total(dealer_cards)}."
    if count_total(player_cards) > count_total(dealer_cards)
      puts "#{player_name} wins!\n"
    elsif count_total(player_cards) < count_total(dealer_cards)
      puts "Dealer wins!\n"
    else
      puts "It's a tie!"
    end
  end

  sleep(2)

  puts "Would you like to play again? (y/n)"
  answer = gets.chomp
  break if answer.downcase != "y"
end

puts "Thank you! Bye!"