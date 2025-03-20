# frozen_string_literal: true

module Front
  class ApiController < ApplicationController
    before_action :authenticate_user!

    private

    def current_user
      # TODO: Implement
    end

    def authenticate_user!
      # TODO: Implement
    end
  end
end
