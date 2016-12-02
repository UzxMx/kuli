require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class WechatAuthenticatable < Authenticatable
      def valid?
        params[:code].present? and params[:state].present? and params[:state] == 'senxie'
      end

      def authenticate!
        begin
          puts "wechat authenticate!"
          json = get_access_token(params[:code])
          user_info = get_user_info(json[:access_token], json[:openid])

          openid = user_info[:openid]
          user = mapping.to.where(open_id: openid).first_or_create! do |user|
            user.open_id = openid
          end
          user.raw_auth = JSON.generate(user_info)
          user.save!
          remember_me(user)
          success!(user)
        rescue Exception => e
          puts e
          fail
        end
      end

      private
        def get_access_token(code)
          send_request("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Kuli::Application::WECHAT_APP_ID}&secret=#{Kuli::Application::WECHAT_APP_SECRET}&code=#{code}&grant_type=authorization_code")
        end

        def get_user_info(access_token, open_id)
          send_request("https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{open_id}&lang=zh_CN")
        end

        def send_request(url)
          url = URI.parse(url)
          req = Net::HTTP::Get.new(url.to_s)
          res = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') { |http|
            http.request(req)
          }
          # in ruby it's symbolize_names, in rails it's symbolize_keys
          json = JSON.parse(res.body, symbolize_names: true)
          json     
        end      
    end
  end
end

Warden::Strategies.add(:wechat_authenticatable, Devise::Strategies::WechatAuthenticatable)