module Helpers
  def sign_in(user)
    allow(action).to receive(:current_user).and_return(user)
  end

  def sign_in_as(role)
    email = "new@email.com"
    password = "some_password"

    user_params = {
      email: email,
      password: password,
      role: role
    }

    user = create_user(user_params)
    log_in(user, password)
  end

  private

  def create_user(params)
    Users::Creator.new.call(params).user
  end

  def log_in(user, password)
    visit '/sessions/new'

    within 'form' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password

      click_button 'Sign in'
    end
  end
end
