=begin
  Some customization for tqq omniauth strategy.
=end

module OmniAuth
  module Strategies
    class Tqq
      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
            #如果uid为空，就用微博帐号名name作为唯一uid
            'uid' => user_hash["data"]['uid']||user_hash["data"]['name'],
            'user_info' => user_info,
            'extra' => {'user_hash' => user_hash}
          })
      end 
      
      def user_info
        user_hash = self.user_hash
        {
          'username' => user_hash["data"]['name'],
          'name' => user_hash["data"]['nick'],
          'email'=>user_hash["data"]['email'],
          'location' => user_hash["data"]['location'],
          'image' => user_hash["data"]['head'],
          'description' => user_hash['description'],
          'urls' => {
            'Tqq' => 't.qq.com'
          }
        }
      end
    end
  end
end