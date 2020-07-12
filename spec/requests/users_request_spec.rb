require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    before { get signup_path }

    it "Have OK http status" do
      expect(response).to have_http_status(200)
    end

    it 'render signup page' do
      expect(subject).to render_template(:new)
    end
  end

  describe 'POST /signup' do
    context 'successful' do
      let(:user) { build(:user) }

      before { signup user }

      it 'create user' do
        user = build(:user)

        expect { signup user }.to change(User, :count).by 1
      end

      it 'exists success message' do
        expect(flash[:success]).not_to be_nil
      end

      it 'have login message' do
        expect(flash[:success]).to include I18n.t('users.create.success')
      end
    end

    context 'unsucessful' do
      let(:user) do
        instance_double(
          'User',
          name: '',
          email: '',
          password: '',
          password_confirmation: '',
        )
      end

      it 'not create user' do
        expect { signup user }.to change(User, :count).by 0
      end
    end
  end

  def signup(user)
    post signup_path, params: {
      user: {
        name: user.name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password,
      },
    }
  end
end
