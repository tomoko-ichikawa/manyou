require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
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

  scenario "タスク一覧のテスト" do
    login_as_yohei
    visit tasks_path

    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'

  end

  scenario "タスク作成のテスト" do
    login_as_yohei
    visit new_task_path
    fill_in 'task[task_name]', with: 'Factoryで作ったデフォルトのタイトル１'
    fill_in 'task[content]', with: 'Factoryで作ったデフォルトのコンテント１'
    click_on '登録する'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスク詳細のテスト" do
    login_as_yohei
    visit tasks_path
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
     login_as_yohei
     visit tasks_path
     expect(Task.order("updated_at DESC").map(&:id))
  end

  scenario "タスクが終了期限の降順に並んでいるかのテスト" do
    login_as_yohei
    visit tasks_path(sort_expired: "true")
    expect(Task.order("updated_at DESC").map(&:id))
  end

  scenario "viewにてタスクが絞り込めるかのテスト" do
    login_as_yohei
    visit tasks_path
    fill_in 'タスク名を検索', with: 'タイトル２'
    expect(page).to have_content 'タイトル２'
  end

  scenario "優先度が登録できるか" do
    login_as_yohei
    visit tasks_path(sort_priority: "true")
    expect(page).to have_content '高'
  end

  scenario "優先度順にソートできているか" do
    login_as_yohei
    visit tasks_path
    click_on '優先度でソートする'
    expect(Task.order("priority ASC").map(&:id))
 end

 scenario "タスクにラベルを付けられるか" do
    login_as_yohei
    visit new_task_path
    fill_in 'task[task_name]', with: 'Factoryで作ったデフォルトのタイトル１'
    fill_in 'task[content]', with: 'Factoryで作ったデフォルトのコンテント１'
    check "task[label_ids][]"
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
 end
end
