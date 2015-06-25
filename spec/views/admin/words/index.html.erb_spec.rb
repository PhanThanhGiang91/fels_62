require 'rails_helper'

RSpec.describe "admin/words/index", type: :view do
  before :each do
    @word = FactoryGirl.create :word
    @words = Word.all.paginate page: params[:page]
    @categories = Category.paginate page: params[:page]
  end

  it "request to admin words controller and index action" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "admin/words"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "should response to show list words" do
    render
    expect(rendered).to include "myModal"
  end

  it "should response to show list words" do
    render
    expect(rendered).to include @word.content
  end
end
