class Task < ApplicationRecord
  enum priority: { not_entered: 0, high: 1, medium: 2, low: 3 }
end
