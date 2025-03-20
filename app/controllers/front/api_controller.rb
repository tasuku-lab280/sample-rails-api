# frozen_string_literal: true

module Front
  class ApiController < ApplicationController
    before_action :authenticate_user!

    private

    attr_reader :current_user

    def authenticate_user!
      header = request.headers['Authorization']
      return head :unauthorized if header.nil?

      token = header.split.last
      return head :unauthorized if token.nil?

      uid = 'uid' # TODO: decode token and get uid
      auth_provider = UserAuthProvider.find_by(provider: :auth0, uid:)
      head :unauthorized if auth_provider.nil?

      @current_user = auth_provider.user
    end
  end
end
