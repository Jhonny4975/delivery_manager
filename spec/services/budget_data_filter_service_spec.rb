# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BudgetDataFilterService, type: :model do
  describe '#call' do
    let(:search_params) do
      {
        height: 1,
        length: 1,
        width: 2,
        weight: 20,
        distance: 200
      }
    end

    it 'filtered parameters?' do
      create_list(:transporter, 3)
      transporter = create(:transporter)
      create(:budget, price: 0.5, max_weight: search_params[:weight], min_weight: 0.1,
                      min_size: 0.1, max_size: search_params[:width], transporter: transporter)
      create(:budget, min_weight: search_params[:weight], max_weight: 40,
                      min_size: search_params[:width], max_size: 3, transporter: transporter)
      deadline = create(:deadline, max_distance: search_params[:distance], min_distance: 1, transporter: transporter)
      create(:deadline, max_distance: 400, min_distance: search_params[:distance], transporter: transporter)
      price = (search_params[:distance] * transporter.budget.first.price)
      search_data = described_class.new(search_params)

      search_data.call
      search_data.price_calculator(search_params[:distance])

      expect(search_data.transporters.size).to eq 1
      expect(search_data.transporters.first).to eq transporter
      expect(search_data.deadlines.size).to eq 1
      expect(search_data.deadlines.first).to eq deadline
      expect(search_data.prices.size).to eq 1
      expect(search_data.prices.first.to_i).to eq price
    end

    it 'with inactive transporter' do
      transporter = create(:transporter, stats: 'inactive')
      create(:deadline, max_distance: search_params[:distance], min_distance: 1, transporter: transporter)
      create(:budget, price: 0.5, max_weight: search_params[:weight], min_weight: 0.1,
                      min_size: 0.1, max_size: search_params[:width], transporter: transporter)
      search_data = described_class.new(search_params)

      search_data.call

      expect(search_data.transporters).to be_empty
    end

    it 'when the price is less than the minimum value' do
      search_params[:distance] = 10
      transporter = create(:transporter, min_price: 50)
      create(:budget, price: 0.5, max_weight: search_params[:weight], min_weight: 0.1,
                      min_size: 0.1, max_size: search_params[:width], transporter: transporter)
      search_data = described_class.new(search_params)

      search_data.price_calculator(search_params[:distance])

      expect(search_data.prices.last).to eq transporter.min_price
    end
  end
end
