class HomeController < ApplicationController
  def index
  end
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom/urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーログイン'
  end
end
