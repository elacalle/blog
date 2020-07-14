module Helpers
  module Authentication
    def login(user)
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password,
        },
      }
    end
  end
end
