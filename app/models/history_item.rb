class HistoryItem < ApplicationRecord
  belongs_to :product
  belongs_to :history
end
