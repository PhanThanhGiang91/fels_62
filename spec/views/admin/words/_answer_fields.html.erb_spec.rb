require 'rails_helper'

RSpec.describe "admin/words/_answer_fields", type: :view do
  before :each do
    @word = Word.new
    @categories = Category.paginate page: params[:page]
  end

  it "no render from other action directly" do
    expect(controller.request.path_parameters[:action]).to be_nil
  end

  it "display list of all subject for admin to select for create question" do
    render "admin/words/modal"
    expect(rendered).to include "remove"
  end
end
