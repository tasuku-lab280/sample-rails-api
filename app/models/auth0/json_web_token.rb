# frozen_string_literal: true

# ref: https://auth0.com/blog/building-secure-apis-with-rails-6-and-auth0/

require 'net/http'

module Auth0
  class JsonWebToken
    def self.verify(token)
      options = {
        algorithms: 'RS256',
        iss: "https://#{ENV.fetch('AUTH0_DOMAIN')}/",
        verify_iss: true,
        aud: ENV.fetch('AUTH0_AUDIENCE'),
        verify_aud: true
      }
      JWT.decode(token, nil, true, **options) do |header|
        jwks_hash[header['kid']]
      end
    end

    def self.jwks_hash
      jwks_raw = Net::HTTP.get(URI("https://#{ENV.fetch('AUTH0_DOMAIN')}/.well-known/jwks.json"))
      jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
      jwks_keys.to_h do |k|
        [k['kid'], OpenSSL::X509::Certificate.new(Base64.decode64(k['x5c'].first)).public_key]
      end
    end
  end
end
