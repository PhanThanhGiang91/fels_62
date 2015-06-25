require 'rails_helper'

RSpec.describe "admin/words/show", type: :view do
  before :each do 
    @word = FactoryGirl.create :word
  end

  it "request to admin words controller and show action" do
    render
    expect(controller.request.path_parameters[:controller]).to eq "admin/words"
    expect(controller.request.path_parameters[:action]).to eq "show"
  end

  it "display content of show action" do 
    render
    expect(rendered).to include "Word Information"
  end
end
