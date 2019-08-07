# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  background do
     FactoryBot.create(:task)
     FactoryBot.create(:second_task)
  end

  scenario "タスク一覧のテスト" do
# あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path
    save_and_open_page
    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'

  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'task[task_name]', with: 'Factoryで作ったデフォルトのタイトル１'
    fill_in 'task[content]', with: 'Factoryで作ったデフォルトのコンテント１'
    click_on '登録する'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスク詳細のテスト" do
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
     visit tasks_path
     expect(Task.order("updated_at DESC").map(&:id))
  end

  scenario "viewにてタスクが絞り込めるかのテスト" do
    visit tasks_path
    fill_in 'タスク名を検索', with: 'タイトル２'
    expect(page).to have_content 'タイトル２'
  end
end
