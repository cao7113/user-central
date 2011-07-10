source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'devise', '1.3.3'#:git => 'git://github.com/plataformatec/devise.git'
gem 'omniauth', '0.2.6'

#2.3.15 can't work with rails3. Hint: there is replacement in rails3, called 
gem 'will_paginate', '3.0.pre2'

group :production do
  gem 'pg'
  gem 'mongrel', '1.1.5'
  ##==heroku bamboo not support Procfile
  #gem 'thin'
end
group :development, :test do
  gem 'mongrel', '1.1.5'
  gem 'mysql2', '0.2.7'
  gem 'ruby-debug'
end
