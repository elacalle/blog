require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'POST /login' do
    context 'successfull login' do
      let(:user) do
        FactoryBot.create(:user)
      end

      before do
        login user
      end

      it 'redirects to root' do
        expect(subject).to redirect_to(root_path)
      end

      it 'save session user id' do
        expect(session[:user_id]).to eq user.id
      end
    end

    context 'not sucessful login' do
      let(:user) do
        instance_double(
          'User',
          email: 'example@example.com',
          password: '12345678',
        )
      end

      before do
        login user
      end

      it 'display login page' do
        expect(subject).to redirect_to(login_path)
      end

      it 'not have user_id' do
        expect(session[:user_id]).to be_nil
      end

      it 'give error message' do
        expect(flash[:warning]).to include I18n.t('sessions.new.failed_login')
      end
    end
  end

  def login(user)
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
      },
    }
  end
end
