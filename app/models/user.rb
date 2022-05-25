# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :transporter, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :the_email_domain_valid?, on: :create

  validates :branch_office_name, uniqueness: true

  private

  def the_email_domain_valid?
    return self.admin = true if email.end_with?('@sistemadefrete.com.br')

    Transporter.find_each do |transporter|
      return self.transporter = transporter if email.end_with?(transporter.domain)
    end

    errors.add(:email, 'não corresponde a nenhuma transportadora cadastrada.') if transporter.nil?
  end
end
