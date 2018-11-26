class Task < ApplicationRecord
  NOT_YET = I18n.t('view.not_yet_started').freeze
  START = I18n.t('view.start').freeze
  COMPLETE= I18n.t('view.complete').freeze

  validates:title, presence:true, length: { in: 1..250 }
  validates:content, presence:true, length: { in: 1..500 }
  validates:limit_datetime, presence:true
  validates:priority, presence:true

  enum priority: [ :low, :middle, :high]

  scope :not_yet_started, -> {where(status: NOT_YET)}
  scope :start, -> {where(status: START)}
  scope :complete, -> {where(status: COMPLETE)}
end
