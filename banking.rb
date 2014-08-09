class Person
  attr_reader :person_status#, :name, :balance

  def initialize(name, balance)
    #@name = name
    #@balance = balance
    @person_status ={"name" => name, "balance" => balance}

    puts "Hi, #{@person_status['name']} You have $#{@person_status['balance']}."
  end
end

class Bank
  attr_reader :bank_name, :bank_account_status, :accounts_status

  def initialize(bank_name)
    @bank_name = bank_name
    @bank_account_status = Hash.new
    @accounts_status = Array.new
    puts "#{@bank_name} was just created."
  end

  def open_account(person)
    @bank_account_status = { "name" => person.person_status["name"], "balance" => 0, "bank" => @bank_name}
    @accounts_status << @bank_account_status
    puts "#{@bank_account_status["name"]}, thanks for opening an account at #{@bank_account_status["bank"]}!"
  end

  def show_acc(person)
    n = person.person_status["name"]
    if h = @accounts_status.find { |h| h['name'] == n }
        puts "Hey #{h['name']}, its you balance $#{h['balance']}"
    else
        puts 'Not found!'
    end
  end

  def show_all_acc()
    @accounts_status.each do |i|
      puts i
    end
  end

  def deposit(person, amount)
     if person.person_status["balance"] < amount
      puts "#{person.person_status['name']} does not have enough cash to deposit $#{amount}."
    else
      if h = @accounts_status.find { |h| h['name'] == person.person_status["name"]}
        h['balance'] += amount
        puts "#{h['name']} deposited #{amount} to #{h['bank']}. #{h['name']} has #{person.person_status["balance"]-=amount}. #{h['name']}'s acccount has #{h['balance']}."
      else
        puts 'Account not found!'
      end
    end

  end

  def withdraw(person, amount)
      if h = @accounts_status.find { |h| h['name'] == person.person_status["name"]}
        if h['balance'] < amount
          puts "#{person.person_status['name']} does not have enough money in the account to withdraw $#{amount}."
        else
          h['balance'] -= amount
          puts "#{h['name']} withdrew #{amount} from #{h['bank']}. #{h['name']} has #{person.person_status["balance"]+=amount}. #{h['name']}'s acccount has #{h['balance']}."
        end
      else
        puts 'Account not found!'
      end
  end

  def transfer(person, bank, amount)
    name_p = person.person_status["name"]
    bank_p = bank.bank_account_status['bank']

    if h = @accounts_status.find { |h| h['name'] == person.person_status["name"]}
      puts "#{h['name']} transfered $#{amount} from the #{h['bank']} account to the #{bank_p} account. The #{h['bank']} has $#{h['balance'] -= amount} "
      if b = bank.accounts_status.find { |b| b['bank'] == bank.bank_account_status['bank']}
        puts "and the bank #{b['bank']} account has  #{b['balance'] += amount} "
      end
    else
      puts "Account not found"
    end
  end

  def total_cash_in_bank
    total = 0
    @accounts_status.each do |i|
         total += i['balance']
    end
    return "#{@bank_account_status["bank"]} has $#{total} in the bank."
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
