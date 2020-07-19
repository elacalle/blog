require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  feature 'User create a post' do
    let(:user) { create(:user) }
    let(:post) { build(:post) }

    before do
      login user
      visit new_post_path(post)
    end

    context 'post fields are visible' do
      it 'have title' do
        expect(page).to have_content(I18n.t('activerecord.attributes.post.title'))
      end

      it 'cotent field' do
        expect(page).to have_content(I18n.t('activerecord.attributes.post.content'))
      end

      it 'save button' do
        expect(page).to have_selector(:link_or_button, I18n.t('posts.new.save'))
      end
    end

    context 'post is invalid' do
      it 'display error messages' do
        find_button(I18n.t('posts.new.save')).click

        post.errors.full_messages.each do |message|
          expect(page).to have_content(message)
        end
      end
    end

    context 'post is valid' do
      before do
        fill_in 'post[title]', with: post.title
        fill_in 'post[content]', with: post.content

        find_button(I18n.t('posts.new.save')).click
      end

      it 'display success message' do
        expect(page).to have_content(I18n.t('posts.create.success'))
      end

      it 'shows the post in the main page' do
        visit root_path

        expect(page).to have_content(post.title)
        expect(page).to have_content(post.content)
      end
    end
  end

  def login(user)
    visit '/login'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on I18n.t('sessions.new.login')
  end
end
