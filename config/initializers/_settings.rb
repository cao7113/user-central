APP_NAME="udo-central"

DEPLOYMENT={
  :demo_online=>{:name=>"Udo Central Demo",
                 :provider=>{:name=>"Heroku", :url=>"http://www.heroku.com"},
                 :domain=>"heroku.com",
                 :url=>"http://#{APP_NAME}.heroku.com"
                 }
}

#some settings in global TODO should remove from here
UC_PROVIDER_NAME = "uc"
