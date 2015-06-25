require 'rails_helper'

RSpec.describe "admin/words/edit", type: :view do
  before :each do
    @word = FactoryGirl.create(:word)
    @categories = Category.paginate page: params[:page]
  end

  it "request to admin words controller and edit action" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "admin/words"
    expect(controller.request.path_parameters[:action]).to eq "edit"
  end

  it "display title of edit action" do
    render
    expect(rendered).to include "Edit Word"
  end
end
