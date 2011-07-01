module Mbanker
  autoload :Account, 'mbanker/account'
  autoload :AccountsList, 'mbanker/accounts_list'
  autoload :Authenticator, 'mbanker/authenticator'
  autoload :Crawler, 'mbanker/crawler'
  autoload :PersistentCrawler, 'mbanker/persistent_crawler'
  autoload :Session, 'mbanker/session'

  def self.create_session username, password
    crawler = Crawler.new
    authenticator = Authenticator.new crawler, username, password
    Session.new crawler, authenticator
  end
end
