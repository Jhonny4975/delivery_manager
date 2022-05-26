# frozen_string_literal: true

class DeadlinesController < ApplicationController
  def new
    @deadlines = Deadline.all
    @deadline = Deadline.new
  end

  def create
    @deadline = Deadline.new(deadline_params)
    @deadline.transporter = current_user.transporter

    if @deadline.save
      flash[:notice] = 'prazo cadastrado.'

      redirect_to new_deadline_path
    else
      flash.now[:notice] = 'Não foi possivel criar o prazo.'

      render :new
    end
  end

  private

  def deadline_params
    params.require(:deadline).permit(
      :max_distance,
      :min_distance,
      :period
    )
  end
end
