require 'rails_helper'

RSpec.describe Admin::WordsController, type: :controller do
  let!(:word) {FactoryGirl.create :word}
  let!(:category) {FactoryGirl.create :category}

  describe "GET #index" do
    it "should response to display list all admin words" do
      get :index

      expect(response).to render_template "index"
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the posts into @words" do
      other_words = Word.all
      get :index

      expect(assigns(:words)).to match_array(other_words)
    end
  end

  describe "GET #edit" do
    it "should response to display admin words information" do
      get :edit, id: word.id

      expect(response).to render_template "edit"
    end

    it "responds successfully with an HTTP 200 status code" do
      get :edit, id: word.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the posts into @words" do
      get :edit, id: word.id

      expect(assigns(:word)).to match(word)
    end
  end

  describe "GET #show" do
    it "should response to admin words infomation" do
      get :show, id: word.id

      expect(response).to render_template "show"
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: word.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the posts into @words" do
      get :show, id: word.id

      expect(assigns(:word)).to match(word)
    end
  end

  describe "POST #create" do
    let!(:params) {{word: {content: Faker::Name.title, category_id: category.id}}}

    context "with valid attributes" do
      it "should present flash success" do
        post :create, params

        expect(flash[:success]).to be_nil
      end

      it "should present object word after create success" do
        other_word = Word.create params[:word]
        get :create, params

        expect(Word.last.attributes.except("id", "created_at", "updated_at")).to eq other_word.attributes.except("id", "created_at", "updated_at")
      end
    end

    context "with invalid attributes" do 
      it "should present flash danger" do
        params[:title] = nil
        post :create, params

        expect(flash[:danger]).to be_nil
      end

      it "should not pesent object word ofter create fail" do
        old_count = category.words.count
        params[:word][:category_id] = nil
        post :create, params

        expect(category.words.count).to eq old_count
      end
    end
  end

  describe "PATCH #update" do
    content = Faker::Name.title
    let!(:params) {{word: {content: content}, id: word.id}}

    context "with valid attributes" do
      it "should present flash success" do
        patch :update, params

        expect(flash[:success]).to be_present
      end

      it "should update title of word" do
        patch :update, params

        expect(Word.find(word.id).content).to eq content
      end
    end

    context "with invalid attributes" do
      it "should not update title of word" do
        params[:word][:content] = nil
        old_content = word.content
        patch :update, params

        expect(Word.find(word.id).content).to eq old_content
      end

      it "should present flash danger" do
        params[:word][:content] = ""
        patch :update, params

        expect(flash[:danger]).to eq "words update faild"
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid attributes" do
      it "should present flash success" do
        delete :destroy, id: word.id

        expect(flash[:success]).to be_present
      end

      it "should not present object" do
        delete :destroy, id: word.id

        old_word = Word.find(word.id) rescue nil
        expect(old_word).to be_nil
      end
    end

    context "with invalid attributes" do
      it "should present flash danger" do
        delete :destroy, id: ""

        expect(flash[:danger]).to be_nil
      end

      it "should present object if can not destroy" do
        old_count = category.words.count
        delete :destroy, id: ""

        expect(category.words.count).to eq old_count
      end
    end
  end
end
