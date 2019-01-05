# frozen_string_literal: true

FactoryBot.define do
  factory :task, class: Task do
    title { 'i do' }
    content { 'wow wow' }
  end
  factory :second_task, class: Task do
    title { 'we do' }
    content { 'are you ready we go on' }
  end
end
