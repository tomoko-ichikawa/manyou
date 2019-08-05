class Task < ApplicationRecord
  enum priority: { 未着手: 0, 高: 1, 中: 2, 低: 3 }
end
