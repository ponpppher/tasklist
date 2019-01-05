# frozen_string_literal: true

require 'rails_helper'

feature 'ユーザー作成機能', type: :feature do
  background do
    user_min = FactoryBot.create(:user, name: 'mincon', email: 'ppp@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
    FactoryBot.create(:task, title: 'first task', user: user_min, limit_datetime: '20181201')

    user_turai = FactoryBot.create(:user, name: 'turai', email: 'aaa@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
    FactoryBot.create(:task, title: 'turai task', user: user_turai, limit_datetime: '20181211')

    user_turai = FactoryBot.create(:user, name: 'peko', email: 'bbb@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
  end

  scenario 'ユーザー作成' do
    visit new_user_path
    fill_in '名前', with: 'excel'
    fill_in 'メールアドレス', with: 'vb@gmail.com'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in 'user_password_digest', with: 'aaaaaa'
    click_button('登録する')
    click_link 'Profile'
    expect(page).to have_content 'excel'
    expect(page).to have_content 'vb@gmail.com'
  end

  scenario 'ログインしてない状態でタスクページに飛ぶとログインページに行く' do
    visit tasks_path
    expect(page).to have_selector 'h1', text: 'login'
  end

  scenario 'タスク作成' do
    visit new_session_path
    fill_in 'Email', with: 'ppp@gmail.com'
    fill_in 'Password', with: 'aaaaaa'
    click_button '保存する'

    expect(page).to have_content 'first task'
  end

  scenario '別ユーザーのタスクが表示されない事' do
    visit new_session_path
    fill_in 'Email', with: 'ppp@gmail.com'
    fill_in 'Password', with: 'aaaaaa'
    click_button '保存する'

    expect(page).not_to have_content 'turai task'
    expect(page).to have_content 'first task'
  end

  scenario 'ログイン時は別ユーザーの詳細画面へ行けない事' do
    visit new_session_path
    fill_in 'Email', with: 'ppp@gmail.com'
    fill_in 'Password', with: 'aaaaaa'
    click_button '保存する'

    visit user_path(3)
    expect(page).not_to have_content 'user: turai'
    expect(page).to have_content 'user: mincon'
  end
end
