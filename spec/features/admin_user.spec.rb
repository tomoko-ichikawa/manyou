require 'rails_helper'

RSpec.feature "ユーザーテスト機能", type: :feature do

  background do
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:admin_user)
  end

  def login_as_yohei
    visit new_session_path
    fill_in "session[email]", with: @user_2.email
    fill_in "session[password]", with: "password"
    find("#login").click
  end

  scenario "マイページが正しく動作する" do
    login_as_yohei
    visit user_path(id: @user_2.id)

    expect(page).to have_content "洋平さん"
    expect(page).not_to have_content "市川"
  end

  scenario "ユーザー一覧のテスト" do
    login_as_yohei
    visit user_path(id: @user_2.id)

    expect(page).to have_content '洋平さん'
  end

  scenario "ユーザー作成のテスト" do
    login_as_yohei
    visit new_admin_user_path(id: @user_2.id)

    fill_in "user[user_name]", with: "ユーザー作成テスト"
    fill_in "user[email]", with: "create_user_test@example.com"
    check "user[admin]"
    fill_in "user[password]" ,with: "password"
    fill_in "user[password_confirmation]" ,with: "password"

    click_on "登録"

    expect(page).to have_content 'ユーザー作成テスト'
  end

  scenario "ユーザー詳細のテスト" do
    login_as_yohei
    visit user_path(id: @user_2.id)

    click_link '詳細'

    expect(page).to have_content '洋平さん'
  end

  scenario "ユーザー編集のテスト" do
    login_as_yohei
    visit edit_admin_user_path(id: @user_2.id)

    fill_in "user[user_name]", with: "ユーザー編集テスト"
    fill_in "user[email]", with: "create_user_test@example.com"
    check "user[admin]"
    fill_in "user[password]" ,with: "password"
    fill_in "user[password_confirmation]" ,with: "password"

    click_on "登録"

    expect(page).to have_content 'ユーザー編集テスト'
  end

  scenario "ユーザー削除のテスト" do
    login_as_yohei
    visit admin_user_path(id: @user_2.id)

    click_on "削除"

    save_and_open_page

    expect(page).to have_selector 'a[data-method=delete]', text: '削除'
  end

end
