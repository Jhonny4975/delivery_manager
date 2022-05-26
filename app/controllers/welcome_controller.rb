# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @transporter = current_user.transporter
  end
end
