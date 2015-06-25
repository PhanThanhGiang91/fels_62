require 'rails_helper'

RSpec.describe "admin/words/_word", type: :view do
  it "no render from other action directly" do
    expect(controller.request.path_parameters[:action]).to be_nil
  end
end
