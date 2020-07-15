require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  describe 'GET /post/new' do
    context 'logged' do
      before do
        login user
        get new_post_path
      end

      it 'have OK http status' do
        expect(response).to have_http_status 200
      end

      it 'render new post template' do
        expect(subject).to render_template :new
      end
    end

    context 'logout' do
      before { get new_post_path }

      it 'have OK http status' do
        expect(response).to have_http_status 302
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /post' do
    let(:new_post) do
      instance_double(
        'Post',
        title: Faker::Lorem.sentence(word_count: 3),
        content: Faker::Lorem.sentence(word_count: 10)
      )
    end

    context 'logged' do
      before { login user }

      context 'sucessful' do
        before { create_post new_post }

        it 'redirects to root url' do
          expect(response).to redirect_to root_path
        end

        it 'save the post' do
          new_post = build(:post)

          expect { create_post(new_post) }.to change(Post, :count).by 1
        end

        it 'return success message' do
          expect(flash[:success]).to eq I18n.t('posts.create.success')
        end
      end

      context 'unsucessfull' do
        let(:new_post) do
          instance_double(
            'Post',
            title: '',
            content: ''
          )
        end

        before { create_post new_post }

        it 'not redirect' do
          expect(response).not_to redirect_to root_path
        end

        it 'not save the post' do
          new_post = build(:post, title: '')

          expect { create_post(new_post) }.to change(Post, :count).by 0
        end

        it 'not return a message' do
          expect(flash[:success]).to be_nil
        end
      end
    end

    context 'logout' do
      let(:new_post) { build(:post) }

      it 'do not create post' do
        expect { create_post(new_post) }.to change(Post, :count).by 0
      end
    end
  end

  def create_post(post)
    post posts_path, params: {
      post: {
        title: post.title,
        content: post.content,
      },
    }
  end
end
