module Mbanker
  class Account
    attr_reader :index, :name, :label, :number, :iban_number, :bic_number, :account_type
    attr_reader :owner, :plenipotentiary, :client_role, :balance, :available_money

    def initialize index, crawler, attributes
      @index, @crawler = index, crawler
      if attributes.key? :full_name_and_number
        extract_label_name_and_number attributes[:full_name_and_number]
      end
      [:balance, :available_money].each do |attribute_name|
        if attributes.key? attribute_name
          instance_variable_set(:"@#{attribute_name}", attributes[attribute_name])
        end
      end
    end

    def change_name new_name
      visit_account_details
      @crawler.click change_name_button
      
      @crawler.get_form.tbVarPartAccName = new_name
      @crawler.click confirm_button
    end

    def fetch_details
      visit_account_details 
      extract_label_and_name @crawler.search('fieldset:nth-child(2) .content').first.text
      @number = @crawler.search('fieldset:nth-child(3) .content').first.text
      @iban_number = @crawler.search('fieldset:nth-child(4) .content').first.text
      @bic_number = @crawler.search('fieldset:nth-child(5) .content').first.text
      @account_type = @crawler.search('fieldset:nth-child(6) .content').first.text
      @owner = @crawler.search('fieldset:nth-child(7) li').first.text
      @plenipotentiary = @crawler.search('fieldset:nth-child(8) li').first.text
      @client_role = @crawler.search('fieldset:nth-child(9) .content').first.text
      @balance = @crawler.search('fieldset:nth-child(10) .amount').first.text
      @available_money = @crawler.search('fieldset:nth-child(11) .amount').first.text
    end


    private

    def extract_label_name_and_number full_name_and_number
      label_and_name, @number = full_name_and_number.gsub(/\A(.+) ((\d\s?){26})\Z/,'\1,\2').split(',').map(&:strip)
      extract_label_and_name label_and_name
    end

    def extract_label_and_name label_and_name
      @label, @name = label_and_name.split(' - ').map(&:strip)
      @name ||= ''
    end

    def visit_account_details
      @crawler.visit :accounts_list
      @crawler.click account_link
    end

    def change_name_button
      @crawler.search('.button:nth-child(2)').first
    end

    def confirm_button
      @crawler.search('#Confirm').first
    end

    def account_link
      @crawler.search('p.Account a')[@index]
    end
  end
end

