require 'rails_helper'

RSpec.feature "Signups", type: :feature do
  before do
    visit('/signup')
  end

  describe 'signup' do
    context 'data is valid' do
      let(:user) do
        instance_double(
          'User',
          email: Faker::Internet.email,
          name: Faker::Internet.username,
          password: Faker::String.random(length: 9),
        )
      end

      before do
        register_with(user)
      end

      it 'do not have error component' do
        expect(page).not_to have_css('.warning')
      end
    end

    context 'data is not valid' do
      let(:user) do
        User.new
      end

      before do
        register_with(user)
      end

      it 'display error component' do
        expect(page).to have_css('.warning')
      end

      it 'display error messages' do
        user.valid?
        user.errors.full_messages.each do |error_message|
          expect(page).to have_content(error_message)
        end
      end
    end
  end

  def register_with(user)
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password

    find_button(I18n.t('users.new.signup')).click
  end
end
