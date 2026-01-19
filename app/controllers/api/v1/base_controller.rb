module Api
  module V1
    class BaseController < ApplicationController
      include Pundit
    end
  end
end
