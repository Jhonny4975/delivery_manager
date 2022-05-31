# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    return if current_user.admin?

    @transporter = current_user.transporter
    @service_orders = @transporter.service_order
  end
end
