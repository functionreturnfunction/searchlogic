require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

class TestView
  include Searchlogic::RailsHelpers

  def form_for *args, &block
    @form_for_args = args
    @form_for_block = block
  end

  attr_reader :form_for_args, :form_for_block
end

describe Searchlogic::RailsHelpers do
  context '#form_for' do
    before :each do
      @target = TestView.new
    end

    it 'should simply call super if no Searchlogic::Search object was provided' do
      args = Object.new

      # test block passing using identify function
      @target.form_for(args) {|t| t}

      @target.form_for_args.length.should == 1
      @target.form_for_args[0].should === args
      @target.form_for_block.call(args).should === args
    end

    it 'should alter its given arguments if one of them is a Searchlogic::Search object' do
      pending
    end
  end
end
