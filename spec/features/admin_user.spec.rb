require 'rails_helper'

RSpec.feature "ユーザーテスト機能", type: :feature do

  background do
  # あらかじめタスク一覧のテストで使用するためのユーザーを作成する
  @user1=FactoryBot.create(:user)
  end

  before do
  #ログイン画面から、まずはログイン
    visit new_session_path

    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'password'
    click_button 'ログイン'
  end

  scenario "ユーザー作成のテスト" do
    visit admin_users_path

    click_on '登録'

    fill_in 'user_name',with:'User'
    fill_in 'email',with:'user@user.com'
    fill_in 'password',with:'user'
    fill_in 'password confirmation',with:'user'

    expect(page).to have_content 'User'
  end

end
