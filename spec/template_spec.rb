require 'spec_helper'

describe Glog::Template do

  subject { Glog::Template.wrap(Glog::Page.first, {}) }

  it "has accessors for page, template and locals" do
    subject.locals = 'hello'
    expect(subject.locals).to eq 'hello'
    subject.template = '%strong hello'
    expect(subject.template).to eq '%strong hello'
    subject.locals = ['saluton']
    expect(subject.locals).to eq ['saluton']
  end

  describe ".wrap(page)" do
    it "should create new template object and assign page to @page" do
      page = Glog::Page.first
      expect(described_class.wrap(page).page).to eq page
    end

    it "assings template file as @template if page defines template" do
      page = Glog::Page.first
      allow(File).to receive(:read).and_return(:yep)
      page.template = 'itstemplate'
      expect(described_class.wrap(page).template).to eq :yep
    end
  end

  describe "#possible_paths_for(page_path)" do
    it "retuns ordered possible template paths for page_path" do
      expect(subject.send(:possible_paths_for, 'very/nested/page/for/test'))
        .to eq [
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
      allow(File).to receive(:exist?).and_return(false)
      expect(File).to receive(:exist?).with(matched_template).and_return(true)
      expect(File).to receive(:read).with(matched_template).and_return(:file)
      res = subject.send(:find_for, 'very/nested/page')
      expect(res).to be(:file)
    end
  end

  describe "#render(path)" do
    subject { Glog::Template.wrap(Glog::Page.first, :env => Glog.env, :config => Glog.config) }

    it "renders haml teplate from templates/{path} if path specified" do
      template = "%strong ololo"
      allow(File).to receive(:read).and_return(template)
      res = subject.render('hello/world')
      expect(res).to eq "<strong>ololo</strong>\n"
    end

    it "passes hash of locals to any template" do
      template = "%strong= env[:ololo]"
      allow(File).to receive(:read).and_return(template)
      locals = { :env => { :ololo => 'hello' }}
      tpl = subject.render('hello/world', locals)
      expect(tpl).to eq "<strong>hello</strong>\n"
    end

    it "shuld render block content as haml" do
      template = "%strong= yield"
      allow(File).to receive(:read).and_return(template)
      tpl = subject.render('hello/world') do
        '%p hello1'
      end
      expect(tpl).to eq "<strong><p>hello1</p></strong>\n"
    end

    it "renders nested block content as haml" do
      template = subject
      parent_template = "%body= yield"
      inner_template  = "%section"
      allow(File).to receive(:read).with('templates/parent.haml').and_return(parent_template)
      allow(File).to receive(:read).with('templates/inner.haml').and_return(inner_template)

      tpl = template.render('parent') do
        "%p hello\n= render('inner')"
      end
      expect(tpl).to eq "<body>\n  <p>hello</p>\n  <section></section>\n</body>\n"
    end
  end
end
