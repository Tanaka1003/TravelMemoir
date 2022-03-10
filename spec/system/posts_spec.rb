# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:post) { create(:post, title:'hoge',body:'body') }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)にログインページへのリンクが表示されているか' do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
      it 'トップ画面(root_path)に新規登録ページへのリンクが表示されているか' do
        except(page).to have_link "新規登録", href: new_user_registration_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe 'ログイン画面(new_user_session_path)のテスト' do
    before do
      visit new_user_session_path
    end
    context '表示の確認' do
      it '新規登録画面へのリンクが存在しているか' do
        except(page).to have_link '新規登録'
      end
      it 'ログインボタンが表示されている' do
        except(page).to have_button 'ログイン'
      end
    end
    context 'ログイン処理のテスト' do
      it 'ログイン後のリダイレクト先は正しいか' do
        fill_in 'user[name]', Faker::Lorem
        fill_in 'user[password]', Faker::Lorem
        click_button 'ログイン'
        except(page).to have_current_path posts_path
      end
    end
  end

  describe "新規登録画面(new_user_registration_path)のテスト" do
    context '表示の確認' do
      it 'ログイン画面へのリンクが存在しているか' do
        expect(page).to have_link 'ログイン'
      end
      it '新規登録ボタンが表示されている' do
        except(page).to have_button '新規登録'
      end
    end
    context '新規登録処理のテスト' do
      it '新規登録後のリダイレクト先は正しいか' do
        fill_in 'user[name]', Faker::Lorem
        fill_in 'user[age]', Faker::Lorem
        fill_in 'user[address]', Faker::Lorem
        click_button '新規登録'
        except(page).to have_current_path posts_path
      end
    end
  end

  describe "投稿画面(new_post_path)のテスト" do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: Faker::Lorem
        fill_in 'post[destination]', with: Faker::Lorem
        fill_in 'post[body]', with: Faker::Lorem
        fill_in 'tag[name]', with: Faker::Lorem
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it '投稿されたものが表示されているか' do
        except(page).to have_content user.name
        expect(page).to have_content post.destination
        except(page).to have_content tag.name
        except(page).to have_content comments.count
        expect(page).to have_link "詳細", href: post_path
      end
      it '検索エンジンが存在しているか' do
        except(page).to have_field ''
      end
    end
    context '検索処理のテスト' do
      it '検索後のリダイレクト先は正しいか' do
        fill_in 'user[destination]', with: Faker::Lorem
        fill_in 'tag[name]', with: Faker::Lorem
        click_button '検索'
        except(page).to have_current_path posts_path
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it 'いいねボタンは表示されているか' do
        excect(page).to have_button 'いいね'
      end
      it 'いいねボタン処理後の表示切り替わっているか' do
        click_button 'いいね'
        excect(page).to 'いいねしない'
      end
      it 'フォローするボタンが表示されているか' do
        except(page).to have_button 'フォローする'
      end
      it 'フォローするボタン処理後の表示切り替わっているか' do
        click_button 'フォローする'
        excect(page).to 'フォローしない'
      end
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context 'post削除のテスト' do
      it 'postの削除' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it '編集前のタイトル・旅行先・本文・タグ名がフォームに表示されているか' do
        expect(page).to have_field 'post[title]', with: post.title
        except(page).to have_field 'post[destination]', with: post.destination
        expect(page).to have_field 'post[body]', with: post.body
        except(page).to have_selector 'tag'
      end
      it '更新ボタンが表示されているか' do
        expect(page).to have_button '更新'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[image_id]', with: Faker::Lorem
        fill_in 'post[title]', with: Faker::Lorem
        fill_in 'post[destination]', with: Faker::Lorem
        fill_in 'post[body]', with: Faker::Lorem
        fill_in 'tag[name]', with: Faker::Lorem
        click_button '更新'
        expect(page).to have_current_path post_path(post)
      end
    end
  end

  describe 'マイページ画面のテスト' do
    before do
      visit edit_user_path(user)
    end
    context '表示の確認' do
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it '編集ボタンは表示されているか' do
        except(page).to have_button '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
  end

  describe 'マイページ編集画面のテスト' do
    context '表示の確認' do
      it 'マイページへのリンクが存在しているか' do
        except(page).to have_link 'マイページ'
      end
      it '投稿一覧へのリンクが存在しているか' do
        except(page).to have_link '投稿一覧'
      end
      it '新規投稿へのリンクが存在しているか' do
        except(page).to have_link '新規投稿'
      end
      it 'サインアウトへのリンクが存在しているか' do
        except(page).to have_link 'サインアウト'
      end
      it '編集前のユーザー名・年齢・居住地がフォームに表示されているか' do
        expect(page).to have_field 'user[name]', with: user.name
        except(page).to have_field 'user[age]', with: user.age
        expect(page).to have_field 'user[address]', with: user.address
      end
      it '更新ボタンは表示されているか' do
        except(page).to have_button '更新'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'profile_image', with: Faker::Lorem
        fill_in 'user[name]', with: Faker::Lorem
        fill_in 'user[age]', with: Faker::Lorem
        fill_in 'user[address]', with: Faker::Lorem
        click_button '更新'
        expect(page).to have_current_path user_path(user)
      end
    end
  end
end