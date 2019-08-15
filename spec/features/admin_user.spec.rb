require 'rails_helper'

RSpec.feature "ユーザーテスト機能", type: :feature do

  background do
  # あらかじめタスク一覧のテストで使用するためのユーザーを作成する
  user = FactoryBot.create(:user)
  end

  before do
  #ログイン画面から、まずはログイン
    visit new_session_path

    click_link 'ログイン'
    fill_in 'session[email]', with: 'test@test.com'
    fill_in 'session[password]', with: 'password'

  end

  scenario "ユーザー一覧のテスト" do
    visit admin_users_path

    expect(page).to have_content 'test@test.com'
  end

  scenario "ユーザー作成のテスト" do
    visit admin_users_path

    click_link '登録'

    fill_in 'user_user_name',with:'User'
    fill_in 'user_email',with:'user@user.com'
    fill_in 'user_password',with:'user'
    fill_in 'user_password_confirmation',with:'user'

    expect(page).to have_content 'User'
  end

  scenario "ユーザー詳細のテスト" do
    visit admin_users_path

    click_link '詳細'

    expect(page).to have_content 'DIC'
  end

  scenario "ユーザー更新のテスト" do
    visit admin_users_path

    click_on '編集'

    fill_in 'Name',with:'Admin'
    fill_in 'Email',with:'admin@user.com'
    fill_in 'Password',with:'admin'
    fill_in 'Password_confirmation',with:'admin'

    click_on '更新'

    expect(page).to have_content 'Admin'
  end

  scenario "ユーザー削除のテスト" do
    visit admin_users_path

    click_on '削除'

    save_and_open_page

    expect(page).not_to have_content 'DIC'
  end

end
