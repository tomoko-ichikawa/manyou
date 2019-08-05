# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  background do
      # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する

      # backgroundの中に記載された記述は、そのカテゴリ内（feature "タスク管理機能", type: :feature do から endまでの内部）
      # に存在する全ての処理内（scenario内）で実行される
      # （「タスク一覧のテスト」でも「タスクが作成日時の降順に並んでいるかのテスト」でも、background内のコードが実行される）
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
  end


  scenario "タスク一覧のテスト" do
# あらかじめタスク一覧のテストで使用するためのタスクを二つ作成す

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
    # ここにテスト内容を記載する
  end
end
