# frozen_string_literal: true

class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
    @budgets = Budget.all
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.transporter = current_user.transporter

    if @budget.save
      flash[:notice] = 'Orçamento cadastrado com sucesso!'

      redirect_to new_budget_path
    else
      flash.now[:notice] = 'Não foi possivel criar a orçamento.'

      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(
      :max_size,
      :min_size,
      :max_weight,
      :min_weight,
      :price
    )
  end
end
