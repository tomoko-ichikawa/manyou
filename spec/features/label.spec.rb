require 'rails_helper'

RSpec.feature "ラベル管理機能", type: :feature do
  background do
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:admin_user)

    FactoryBot.create(:task, user: @user_2)
    FactoryBot.create(:second_task, user: @user_2)
    FactoryBot.create(:third_task, user: @user_2)

    FactoryBot.create(:label)
  end

  def login_as_yohei
    visit new_session_path
    fill_in "session[email]", with: @user_2.email
    fill_in "session[password]", with: "password"
    find("#login").click
  end

  scenario "タスクにラベルを付けられるか" do
     login_as_yohei
     visit new_task_path
     fill_in 'task[task_name]', with: 'test1'
     fill_in 'task[content]', with: 'test1'
     check "task_label_ids_1"
     click_on 'commit'
     expect(page).to have_content 'test1'
  end

  scenario "ラベルで検索できるか" do
    login_as_yohei
    visit new_task_path
    fill_in 'task[task_name]', with: 'test2'
    fill_in 'task[content]', with: 'test2'
    check "task_label_ids_2"
    click_on 'commit'

    visit tasks_path
    select 'ラベル1', from: 'task[label_id]'
    click_on '検索'

    expect(page).to have_content "タスク一覧"
    expect(page).to have_content "ラベル1"
  end
end
