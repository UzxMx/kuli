require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class MockAuthenticatable < Authenticatable
      def valid?
        !request.original_fullpath.start_with?('/admin')
      end

      def authenticate!
        puts "mock authenticate!"
        user = mapping.to.first_or_create! do |user|
          user.open_id = 'o-QDzvksNB70P__MU397VkXswLlg'
          user.raw_auth = '{"openid":"o-QDzvksNB70P__MU397VkXswLlg","nickname":"Xiang","sex":1,"language":"zh_CN","city":"","province":"","country":"中国","headimgurl":"http://wx.qlogo.cn/mmopen/iafdHmPYdKoAiaZ3jQcRV17Qt2M6kjdlopPiaHqml5aQCRQm4SOrtIeOdLjJ7QEt15LQiaFzyysgUWpAiahmuRD1Ata0Ka2sbXl8S/0","privilege":[]}'
        end
        remember_me(user)
        success!(user)
      end
    end
  end
end

Warden::Strategies.add(:mock_authenticatable, Devise::Strategies::MockAuthenticatable)