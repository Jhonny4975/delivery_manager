# frozen_string_literal: true

puts
puts '--------------------------------------------------'
puts 'Start "seeds"'
puts '--------------------------------------------------'
puts

puts '-------------- creating transporters -------------'

FactoryBot.create_list(:transporter, 2)
visit_transporter = FactoryBot.create(:transporter, domain: 'gmail.com')

puts '----------------- creating users -----------------'

FactoryBot.create_list(:user, 2)
visit = FactoryBot.create(:user, email: 'visit@gmail.com', password: '123456')
FactoryBot.create(:user, email: 'visit@sistemadefrete.com.br', password: '123456')

puts '--------------- creating vehicles ----------------'

FactoryBot.create_list(:vehicle, 2)
FactoryBot.create(:vehicle, user: visit)

puts '---------------- creating budgets ----------------'

FactoryBot.create_list(:budget, 2)
FactoryBot.create(:budget, transporter: visit_transporter )

puts '--------------- creating deadlines ---------------'

FactoryBot.create_list(:deadline, 2)
FactoryBot.create(:deadline, transporter: visit_transporter )

puts '------------- creating service orders -------------'

FactoryBot.create_list(:service_order, 2)
FactoryBot.create(:service_order, transporter: visit_transporter )

puts
puts '--------------------------------------------------'
puts 'Finished "seeds"'
puts '--------------------------------------------------'
puts
