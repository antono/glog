require 'spec_helper'

describe Glog::Template do

  subject { Glog::Template.wrap(Glog::Page.first, {}) }

  it "should have accessors for page, template and locals" do
    subject.locals = 'hello'
    subject.locals.should == 'hello'
    subject.template = '%strong hello'
    subject.template.should == '%strong hello'
    subject.locals = ['saluton']
    subject.locals.should == ['saluton']
  end

  describe ".wrap(page)" do
    it "should create new template object and assign page to @page" do
      page = Glog::Page.first
      described_class.wrap(page).page.should == page
    end

    it "should assing template file as @template if page defines template" do
      page = Glog::Page.first
      File.stub!(:read).and_return(:yep)
      page.template = 'itstemplate'
      described_class.wrap(page).template.should == :yep
    end

    it "should should find template for page if page is not defines template" do
      pending
    end
  end

  describe "#possible_paths_for(page_path)" do
    it "should retun ordered possible template paths for page_path" do
      subject.send(:possible_paths_for, 'very/nested/page/for/test').
        should == [
          'templates/very/nested/page/for/test.haml',    # <- twin template,
          'templates/very/nested/page/for/default.haml', # should match path
          'templates/very/nested/page/default.haml',     # and name of the page
          'templates/very/nested/default.haml',
          'templates/very/default.haml',
          'templates/default.haml'
        ]
    end
  end

  describe "#find_for(path)" do
    it "should return first found template as string" do
      subject # calling lambda
      matched_template = 'templates/very/nested/default.haml'
      File.stub!(:exist?).and_return(false)
      File.should_receive(:exist?).with(matched_template).and_return(true)
      File.should_receive(:read).with(matched_template).and_return(:file)
      subject.send(:find_for, 'very/nested/page').should be(:file)
    end
  end

  describe "#render(path)" do

    subject { Glog::Template.wrap(Glog::Page.first, :env => Glog.env, :config => Glog.config) }

    it "should render haml teplate from templates/{path} if path specified" do
      template = "%strong ololo"
      File.stub(:read).and_return(template)
      subject.render('hello/world').should == "<strong>ololo</strong>\n"
    end

    it "should pass hash of locals to any template" do
      template = "%strong= env[:ololo]"
      File.stub(:read).and_return(template)
      locals = { :env => { :ololo => 'hello' }}
      subject.render('hello/world', locals).should == "<strong>hello</strong>\n"
    end

    it "shuld render block content as haml" do
      template = "%strong= yield"
      File.stub(:read).and_return(template)
      subject.render('hello/world') do
        '%p hello1'
      end.should == "<strong><p>hello1</p></strong>\n"
    end

    it "shuld render nested block content as haml" do
      template = subject
      parent_template = "%body= yield"
      inner_template  = "%section"
      File.should_receive(:read).with('templates/parent.haml').and_return(parent_template)
      File.should_receive(:read).with('templates/inner.haml').and_return(inner_template)
      template.render('parent') do
        "%p hello\n= render('inner')"
      end.should == "<body>\n  <p>hello</p>\n  <section></section>\n</body>\n"
    end
  end
end
