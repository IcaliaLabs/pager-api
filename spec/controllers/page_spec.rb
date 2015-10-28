require 'pager_api/pagination/will_paginate'
require 'spec_helper'

describe 'pagination' do
  let(:mock_controller) { controller(ActionController::Base) }

  it 'should implement pagination' do
    mock_controller.extend(PagerApi::Pagination::WillPaginate)
  end
end
