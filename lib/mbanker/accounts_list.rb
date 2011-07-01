module Mbanker
  class AccountsList
    attr_reader :accounts

    def initialize crawler
      @crawler = crawler
      fetch_accounts
    end

    private
    def fetch_accounts
      @accounts = []
      @crawler.visit :accounts_list
      full_names_and_numbers = @crawler.search('.Account a').map(&:text)
      balances = @crawler.search('.Amount a').map(&:text)
      availables = @crawler.search('.Amount span').map(&:text)
      accounts_count = full_names_and_numbers.count
      accounts_count.times do |index|
        attributes = {
          full_name_and_number: full_names_and_numbers[index],
          balance: balances[index],
          available_money: availables[index]
        }
        @accounts << Mbanker::Account.new(index, @crawler, attributes)
      end
    end
    
  end
end
