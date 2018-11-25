class Task < ApplicationRecord
  NOT_YET = I18n.t('view.not_yet_started').freeze
  START = I18n.t('view.start').freeze
  COMPLETE= I18n.t('view.complete').freeze
  validates:title, presence:true
  validates:content, presence:true

  scope :not_yet_started, -> {where(status: NOT_YET)}
  scope :start, -> {where(status: START)}
  scope :complete, -> {where(status: COMPLETE)}
end
