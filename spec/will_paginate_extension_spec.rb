require 'spec_helper'
require 'will_paginate/array'
require 'pager_api/pagination/will_paginate'

class DummyCtrl
  include PagerApi::Pagination::WillPaginate
  def params
    {}
  end

  def request
    DummyRequest.new
  end

  def headers
    {}
  end

  def render(arg)
    arg
  end
end

class DummyRequest
  def env
    {}
  end

  def query_parameters
    {}
  end

  def headers
    {}
  end

  def original_url
    ""
  end
end

describe PagerApi::Pagination::WillPaginate do
  before :all do
    @my_letters = ('a'..'z').to_a
  end

  let(:class_with_pagination) { DummyCtrl.new }
  it 'should properly give per page in response' do
    expect(class_with_pagination.paginate(@my_letters, per_page: 15)[:meta][:pagination][:per_page]).to eq(15)
  end

  it 'should properly give per page in response (30 per page)' do
    expect(class_with_pagination.paginate(@my_letters, per_page: 30)[:meta][:pagination][:per_page]).to eq(30)
  end
end
