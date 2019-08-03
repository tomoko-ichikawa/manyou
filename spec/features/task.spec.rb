# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do

  end

  scenario "タスク作成のテスト" do

  end

  scenario "タスク詳細のテスト" do

  end
end
