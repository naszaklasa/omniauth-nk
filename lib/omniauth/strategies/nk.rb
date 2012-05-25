require 'omniauth-oauth2'
require 'multi_json'
require 'oauth'

module OmniAuth
  module Strategies
    class Nk < OmniAuth::Strategies::OAuth2
      
      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'
      DEFAULT_SCOPE = 'BASIC_PROFILE_ROLE,EMAIL_PROFILE_ROLE'
      
      option :name, "nk"

      option :client_options, {
          :site => 'https://nk.pl',
          :authorize_url => '/oauth2/login',
          :token_url     => '/oauth2/token'
      }

      def callback_phase
        if request.params['error'] || request.params['error_description']
          fail!(request.params['error'], CallbackError.new(request.params['error'], request.params['error_description'], request.params['error_uri']))
        end
        super
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = client.id
        end
      end

      def token_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
          params[:grant_type] ||= DEFAULT_GRANT
          params[:client_id] = client.id
          params[:client_secret] = client.secret
        end
      end

      uid do
        raw_info['entry']['id']
      end

      info do
        row = raw_info['entry']
        {
          :name       => row['name']['formatted'],
          :email      => row['emails'].instance_of?(Array) ? row['emails'].last['value'] : nil,
          :age        => row['age'].to_i,
          :gender     => row['gender'],
          :location   => row['currentLocation']['region'],
          :image      => row['thumbnailUrl'],
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        if @raw_info.nil?
          # OAuth is used to get user data
          fields = %w(id name emails age gender currentLocation thumbnailUrl)
          request_url = "http://opensocial.nk-net.pl/v09/social/rest/people/@me?fields=#{fields.join(',')}&nk_token=#{credentials['token']}"

          consumer = OAuth::Consumer.new(options.client_id, options.client_secret, {:site => 'http://opensocial.nk-net.pl'})
          @raw_info = MultiJson.decode(OAuth::AccessToken.new(consumer, credentials['token']).get(request_url).body.to_s)
        end
        @raw_info
      end
    end
  end
end
