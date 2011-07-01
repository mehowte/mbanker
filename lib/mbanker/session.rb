module Mbanker
  class Session
    attr_accessor :crawler, :persistent_crawler
    
    def initialize crawler, authorizer 
      @crawler, @authorizer = crawler, authorizer 
      @persistent_crawler = Mbanker::PersistentCrawler.new @crawler, @authorizer
    end

    def accounts
      @accounts_list ||= Mbanker::AccountsList.new @persistent_crawler
      @accounts_list.accounts
    end

  end
end
