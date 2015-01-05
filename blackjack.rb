SUITS = ["hearts", "spades", "diamonds", "clubs"]
VALUES = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]

def build_deck(number_of_decks)
  deck = []
  number_of_decks.times do
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << value.to_s + " of " + suit
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
    elsif card[0] == "A" && total <= 10
      total += 11
    elsif card[0] == "A" && total > 10
      total += 1
    else
      total += 10
    end
  end
  total
end

while true
  system("clear")
  deck = build_deck(1)

  player_cards = []
  dealer_cards = []

  bust = false

  2.times { hit(player_cards, deck) }
  2.times { hit(dealer_cards, deck) }

  puts "Player has the following cards in hand: #{player_cards.join(", ")}."
  puts "The total for player is #{count_total(player_cards)}."
  puts "Dealer has the following cards in hand: #{dealer_cards.first} and one other card."
  puts

  sleep(2)

  while !bust
    if count_total(player_cards) == 21
      puts "Blackjack! Player wins!"
      break
    elsif count_total(player_cards) > 21
      puts "Player busts and loses!"
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
        puts "Player has the following cards in hand: #{player_cards.join(", ")}."
        puts "The total for player is #{count_total(player_cards)}."
      else
        puts "You selected to stay."
        puts
        break
      end
    end
  end

  puts "Dealer has the following cards in hand: #{dealer_cards.join(", ")}"
  puts "The total for dealer is #{count_total(dealer_cards)}."

  if !bust
    while count_total(dealer_cards) < 17
      puts "...Drawing another card..."
      hit(dealer_cards, deck)
      if count_total(dealer_cards) == 21
        puts "Blackjack! Dealer wins!"
        break
      elsif count_total(dealer_cards) > 21
        puts "Dealer busts and loses!"
        bust = true
        break
      end
    end
  end

  if !bust
    puts "Player cards total is: #{count_total(player_cards)}."
    puts "Dealer cards total is: #{count_total(dealer_cards)}."
    if count_total(player_cards) > count_total(dealer_cards)
      puts "Player wins!\n"
    else
      puts "Dealer wins!\n"
    end
  end

  sleep(2)

  puts "Would you like to play again? (y/n)"
  answer = gets.chomp
  break if answer.downcase != "y"
end