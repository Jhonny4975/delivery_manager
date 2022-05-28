# frozen_string_literal: true

class BudgetDataFilterService
  attr_reader :deadlines, :transporters, :prices

  def initialize(search_params)
    @size = search_params[:height].to_d * search_params[:length].to_d * search_params[:width].to_d
    @deadlines = Deadline.where(max_distance: search_params[:distance].., min_distance: ..search_params[:distance])
    @budgets = Budget.where(
      max_size: @size.., min_size: ..@size,
      max_weight: search_params[:weight]..,
      min_weight: ..search_params[:weight]
    )
  end

  def call
    @deadlines = reapeated?(@deadlines)
    @budgets = reapeated?(@budgets)

    @transporters = @budgets.map(&:transporter)
  end

  def price_calculator(distance)
    @prices = @budgets.map do |budget|
      distance.to_d * budget.price
    end
  end

  private

  def reapeated?(objects)
    transporters_ids = []

    objects.each do |object|
      if transporters_ids.count(object.transporter_id) >= 1
        objects = objects.reject { |instance| instance == object }
      else
        transporters_ids << object.transporter_id
      end
    end

    objects
  end

  def transporter
    @transporters.select! do |transporter|
      transporter.deadline.ids.map do |id|
        @deadlines.ids.include?(id) unless @deadlines.size < 2
      end
    end
  end
end
