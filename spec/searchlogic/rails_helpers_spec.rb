require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

class ViewBase
  def form_for *args, &block
    @form_for_args = args
    @form_for_block = block
  end

  attr_reader :form_for_args, :form_for_block
end

class TestView < ViewBase
  include Searchlogic::RailsHelpers
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
      # test block passing using identify function
      @target.form_for_block.call(args).should === args
    end

    context 'with Searchlogic::Search object provided' do
      before :each do
        @search = Searchlogic::Search.new(nil, nil)
        @html_method = :the_method
        @html_arg = {:method => @html_method}
        @url = 'the url'
      end

      it 'should alter its given arguments if one of them is a Searchlogic::Search object' do
        # test block passing using identify function
        @target.form_for(@search, :html => @html_arg, :url => @url) {|t| t}

        @target.form_for_args.length.should == 3
        @target.form_for_args.second.should == @search
        args = @target.form_for_args.extract_options!
        args[:html][:method].should == @html_method
        args[:url].should == @url
        # test block passing using identify function
        @target.form_for_block.call(args).should === args
      end
    end
  end
end
