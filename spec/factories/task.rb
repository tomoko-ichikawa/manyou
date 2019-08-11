FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { '2019.08.07' }
    status { "未着手" }
    priority { '高' }
    user_id {'ユーザー1'}
  end

  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2019.10.31' }
    status { "進行中" }
    priority { '中' }
    user_id {'ユーザー2'}
  end

  factory :third_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル３' }
    content { 'Factoryで作ったデフォルトのコンテント３' }
    deadline { '2019.11.30' }
    status { "終了" }
    priority { '低' }
    user_id {'ユーザー3'}
  end
end
