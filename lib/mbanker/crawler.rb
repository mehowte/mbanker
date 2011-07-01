require 'mechanize'
module Mbanker
  class Crawler

    BASE_URI = 'https://www.mbank.com.pl/'
    PATHS = {
      :login => 'logon.aspx',
      :logout => 'logout.aspx',
      :accounts_list => 'accounts_list.aspx',
      :account_details => 'account_details.aspx',
      :account_name_change => 'contract_change_name.aspx',
      :operation_history => 'account_oper_list.aspx'
    }

    def initialize 
      @agent = Mechanize.new
    end
  
    def visit path_name
      p path_name
      @agent.get(BASE_URI + PATHS[path_name])
    end

    def visit_by_post path_name, parameters
      submit_navigation_form "/#{PATHS[path_name]}", parameters
    end

    
    def click link_or_button
      action = extract_action link_or_button
      parameters = extract_post_parameters link_or_button
      submit_navigation_form action, parameters
    end

    def extract_action link
      onclick_value = link.attribute('onclick').value
      onclick_value.gsub(/\A.*\('/, '').gsub(/'.*\Z/,'')
    end

    def extract_post_parameters link
      onclick_value = link.attribute('onclick').value
      onclick_value.gsub(/'/,'').split(',')[3]
    end

    def submit_navigation_form action, parameters
      navigation_form = @agent.page.form
      navigation_form.action = action
      navigation_form.__PARAMETERS = parameters
      navigation_form.method = 'POST'
      navigation_form.submit
    end




    def search selector
      @agent.page.search(selector)
    end

    def can_find? selector
      not search(selector).empty?
    end


    def get_form
      @agent.page.form
    end

    
  end
end
