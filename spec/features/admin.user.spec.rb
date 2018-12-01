require 'rails_helper'

feature 'ユーザー管理画面のテスト' do
  background do
    user_min = FactoryBot.create(:user, name: "mincon", email: "ppp@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa")
    FactoryBot.create(:task, title: 'first task', user: user_min, limit_datetime: '20181201')

    user_turai = FactoryBot.create(:user, name: "turai", email: "aaa@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa")
    FactoryBot.create(:task, title: 'turai task', user: user_turai, limit_datetime: '20181211')

    user_peco = FactoryBot.create(:user, name: "peco", email: "bbb@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa")

    visit new_session_path
    fill_in 'Email', with:'ppp@gmail.com'
    fill_in 'Password', with:'aaaaaa'
    click_button '保存する'
  end

  scenario 'ユーザー一覧の表示' do
    visit admin_users_path
    expect(page).to have_content 'name: mincon'
    expect(page).to have_content 'email: ppp@gmail.com'
    expect(page).to have_content 'task count: 1'

    expect(page).to have_content 'name: turai'
    expect(page).to have_content 'email: aaa@gmail.com'
    expect(page).to have_content 'task count: 1'

    expect(page).to have_content 'name: peco'
    expect(page).to have_content 'email: bbb@gmail.com'
    expect(page).to have_content 'task count: 0'
  end

  scenario 'ユーザー作成' do
    visit admin_users_path

    click_link 'Create User'
    fill_in '名前', with:'create_user'
    fill_in 'メールアドレス', with:'create@gmail.com'
    fill_in 'パスワード', with:'aaaaaa'
    fill_in 'user_password_digest', with:'aaaaaa'
    click_button '登録する'
    
    expect(page).to have_content 'name: create_user'
    expect(page).to have_content 'email: create@gmail.com'
    expect(page).to have_content 'task count: 0'
  end
  scenario 'ユーザー詳細' do
    visit admin_users_path

    user = User.find_by(name: "mincon")
    click_link '詳細', href: admin_user_path(user.id)

    expect(page).to have_content 'title: first task'
    expect(page).to have_content 'content:'
    expect(page).to have_content 'status:'
    expect(page).to have_content 'priority: middle'
    expect(page).to have_content 'limit: 2018-12-01 00:00:00 +0900'
  end

  scenario 'ユーザー更新' do
    visit admin_users_path
    user = User.find_by(name: "mincon")
    click_link '編集', href: edit_admin_user_path(user.id)

    fill_in '名前', with:'change_name'
    fill_in 'メールアドレス', with:'edit@gmail.com'
    fill_in 'パスワード', with:'aaaaaa'
    fill_in 'user_password_digest', with:'aaaaaa'

    click_button '更新する'

    expect(page).to have_content 'name: change_name'
    expect(page).to have_content 'email: edit@gmail.com'
    expect(page).to have_content 'task count: 1'
    
  end

  scenario 'ユーザー削除' do
    visit admin_users_path
    user = User.find_by(name: "mincon")
    click_link '削除', href: admin_user_path(user.id)

    expect(page).not_to have_content 'name: mincon'
    expect(page).not_to have_content 'email: ppp@gmail.com'
    expect(page).not_to have_content 'task count: 1'
  end

end