mBanker
=======

Missing API for online mBank services.

Client for nonexistent mBank API. 

Installation
------------

gem install mbanker

Usage
-----

``` ruby

require 'mbanker'

# opening session
session = Mbanker.create_session USERNAME, PASSWORD

# printing accounts info
session.accounts.each do |account|
  puts "#{account.label} - #{account.name}"
  puts "  number: #{account.number}"
  puts "  balance: #{account.balance}"
  puts "  available money: #{account.balance}"
  
  # fetch and print account details
  account.fetch_details
  puts "  details:"
  puts "    iban number: #{account.iban_number}"
  puts "    bic number: #{account.bic_number}"
  puts "    owner: #{account.owner}"
  puts "    account type: #{account.account_type}"
  puts "    client role: #{account.client_role}"
  puts "    plenipotentiary: #{account.plenipotentiary}"
end

session.accounts.first.change_name "MONEY JAR"

```

Development and testing
-------------
    
    git clone git://github.com/mehowte/mbanker.git
    cd mbanker
    bundle
    bundle exec rspec spec



License
-------

Copyright © 2011 Michal Taszycki

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.


