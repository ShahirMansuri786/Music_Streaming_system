require "jwt"

module JwtToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def jwt_encode(payload, exp:  24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload , SECRET_KEY , 'HS256')
  end

  def jwt_decode(token)
    decoded = JWT.decode(token , SECRET_KEY )[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::ExpiredSignature
    raise 'Token has expired'
  rescue JWT::DecodeError
    raise 'Invalid token'
  end

end