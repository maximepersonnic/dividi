# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemindersController, type: :controller do
  it '#index (Mes emprunts) responds successfully' do
    user = FactoryBot.create(:user)
    user.confirm
    sign_in user
    get :index
    expect(response).to be_successful
  end
end
