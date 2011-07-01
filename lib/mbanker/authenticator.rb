module Mbanker
  class Authenticator
    attr_accessor :crawler

    def initialize crawler, login, password
      @crawler, @login, @password = crawler, login, password
    end

    def authenticated?
      crawler.visit :accounts_list
      session_error_absent?
    end

    def authenticate!
      crawler.visit :login
      login_form = crawler.get_form
      login_form.customer = @login
      login_form.password = @password
      login_form.submit
      unless session_error_absent?
        raise "Could not authenticate"
      end
    end

    def unauthenticate!
      crawler.visit :logout
    end

    def session_error_absent?
      not crawler.can_find?('.error.noSession')
    end

  end
end
