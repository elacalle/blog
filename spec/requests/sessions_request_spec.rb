require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe 'GET /login' do
    before { get login_path }

    it 'have OK http status' do
      expect(response).to have_http_status 200
    end

    it 'render login page' do
      expect(subject).to render_template(:new)
    end
  end

  describe 'POST /login' do
    context 'successfull' do
      before { login user }

      it 'redirects to root' do
        expect(subject).to redirect_to root_path
      end

      it 'save session user id' do
        expect(session[:user_id]).to eq user.id
      end
    end

    context 'not sucessful' do
      let(:user) do
        instance_double(
          'User',
          email: 'example@example.com',
          password: '12345678',
        )
      end

      before { login user }

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

  describe 'DELETE /destroy' do
    context 'user is logged in' do
      before do
        login user
        delete logout_path
      end

      it 'user_id is removed' do
        expect(session[:user_id]).to be_nil
      end

      it 'show message' do
        expect(flash[:success]).to eq I18n.t('sessions.destroy.success_logout')
      end

      it 'redirect to root_url' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'user is logged out' do
      before { delete logout_path }

      it 'not show message' do
        expect(flash[:success]).to be_nil
      end

      it 'not redirect to root_url' do
        expect(subject).not_to redirect_to(root_url)
      end
    end
  end
end
