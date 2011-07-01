module Mbanker
  class PersistentCrawler

    def initialize crawler, authenticater
      @crawler, @authenticator = crawler, authenticater
      if @authenticator.authenticated?
        @authenticator.authenticate!
      end
    end
  
    def visit path_name
      @crawler.visit path_name
      unless @authenticator.session_error_absent?
        @authenticator.authenticate!
        @crawler.visit path_name
      end
    end

    def click link_or_button
      @crawler.click link_or_button
      unless @authenticator.session_error_absent?
        @authenticator.authenticate!
        @crawler.visit link_or_button
      end
    end

    def search selector
      @crawler.search selector
    end

    def can_find? selector
      @crawler.can_find? selector
    end

    def find_first selector
      @crawler.find_first selector
    end

    def extract_text selector
      @crawler.extract_text selector
    end

    def extract_texts selector
      @crawler.extract_texts selector
    end

    def get_form
      @crawler.get_form
    end
  end
end
