

class GeetestController< ApplicationController

  def  register
    sdk =  Geetest.new(ENV['GEE_TEST_ID'], ENV['GEE_TEST_KEY'])
    result_from_gee_test_server = sdk.pre_process(ENV['GEE_TEST_ID'])
    render :json=> result_from_gee_test_server
  end
end