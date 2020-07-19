require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { create(:user) }

  describe 'logout' do
    context 'successfull' do
      before do
        login user
        logout
      end

      it 'show success message' do
        expect(page).to have_content(I18n.t('sessions.destroy.success_logout'))
      end

      it 'logout link is removed' do
        expect(page).not_to have_content(I18n.t('logout'))
      end

      it 'appear login link' do
      end
    end
  end

  describe 'login' do
    context 'is successfull' do
      before { login user }

      it 'show success message' do
        expect(page).to have_content(I18n.t('sessions.create.success_login'))
      end

      it 'appear logout button' do
        expect(page).to have_content(I18n.t('logout'))
      end

      it 'appear user name' do
        expect(page).to have_content(I18n.t('hi', name: user.name))
      end
    end

    context 'not successful' do
      before do
        user.email = nil
        login user
      end

      it 'show error message' do
        expect(page).to have_content(I18n.t('sessions.new.failed_login'))
      end
    end
  end

  def logout
    click_on(I18n.t('logout'))
  end

  def login(user)
    visit(login_path)
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on I18n.t('sessions.new.login')
  end
end
