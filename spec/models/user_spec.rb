require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(140) }

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(140) }
  it { should validate_uniqueness_of(:email) }
  %w(
    wrongemail wrongemail@ wrong@email wrong@.email wrong.@email..es. .wrong@emailes
  ).each do |email|
    it { should_not allow_value(email).for(:email) }
  end

  it { should have_secure_password }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_presence_of(:password_confirmation) }
end
