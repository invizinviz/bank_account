class Person
  attr_reader :name, :balance, :person_hash

  def initialize(name, balance)
    @name = name
    @balance = balance
    @person_hash ={"name" => name,
                                "balance" => balance}

    puts "Hi, #{@person_hash['name']} You have $#{@person_hash['balance']}."
  end
end

class Bank
  attr_reader :bank_name, :person_acc, :persons_arr

  def initialize(bank_name)
    @bank_name = bank_name
    @person_acc = Hash.new
    @persons_arr = Array.new
    puts "#{@bank_name} was just created."
  end

  def open_account(person)
    @person_acc = { "name" => person.person_hash["name"],
                           "balance" => 0,
                           "bank" => @bank_name}
    @persons_arr << @person_acc
    puts "#{@person_acc["name"]}, thanks for opening an account at #{@person_acc["bank"]}!"
  end

  def show_acc(person)
    n = person.person_hash["name"]
    if h = @persons_arr.find { |h| h['name'] == n }
        puts "Hey #{h['name']}, its you balance $#{h['balance']}"
    else
        puts 'Not found!'
    end
  end

  def show_all_acc()
    @persons_arr.each do |i|
      puts i
    end
  end

  def deposit(person, amount)
     if person.person_hash["balance"] < amount
      puts "#{person.person_hash['name']} does not have enough cash to deposit $#{amount}."
    else
      if h = @persons_arr.find { |h| h['name'] == person.person_hash["name"]}
        h['balance'] += amount
        puts "#{h['name']} deposited #{amount} to #{h['bank']}. #{h['name']} has #{person.person_hash["balance"]-=amount}. #{h['name']}'s acccount has #{h['balance']}."
      else
        puts 'Account not found!'
      end
    end

  end

  def withdraw(person, amount)
      if h = @persons_arr.find { |h| h['name'] == person.person_hash["name"]}
        if h['balance'] < amount
          puts "#{person.person_hash['name']} does not have enough money in the account to withdraw $#{amount}."
        else
          h['balance'] -= amount
          puts "#{h['name']} withdrew #{amount} from #{h['bank']}. #{h['name']} has #{person.person_hash["balance"]+=amount}. #{h['name']}'s acccount has #{h['balance']}."
        end
      else
        puts 'Account not found!'
      end
  end

  def transfer(person, bank, amount)
    name_p = person.person_hash["name"]
    bank_p = bank.person_acc['bank']

    if h = @persons_arr.find { |h| h['name'] == person.person_hash["name"]}
      puts "#{h['name']} transfered $#{amount} from the #{h['bank']} account to the #{bank_p} account. The #{h['bank']} has $#{h['balance'] -= amount} "
      if b = bank.persons_arr.find { |b| b['bank'] == bank.person_acc['bank']}
        puts "and the bank #{b['bank']} account has  #{b['balance'] += amount} "
      end
    else
      puts "Account not found"
    end
  end

  def total_cash_in_bank
    total = 0
    @persons_arr.each do |i|
         total += i['balance']
    end
    return "#{@person_acc["bank"]} has $#{total} in the bank."
  end
end

##############################
chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)
chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)
chase.transfer(me, wells_fargo, 100)

####Extra Credit level 1: Validate
chase.deposit(me, 5000)
chase.withdraw(me, 5000)

####Extra Credit level 2: Count totals
puts chase.total_cash_in_bank
puts wells_fargo.total_cash_in_bank
