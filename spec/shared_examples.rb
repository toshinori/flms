# -*- coding: utf-8 -*-

shared_examples_for :to_invalid_after_attr_change do |name, test_values|
    describe name do
      test_values.each do |label, value|
        context "when set '#{value}'(#{label.to_s})" do
          subject { target_model }
          it { ->{ subject[name] = value}.should change(subject, :invalid?).from(false).to(true)}
          it {
            subject[name] = value
            should have_at_least(1).errors_on(name)
          }
        end
    end
  end
end

shared_examples_for :not_invalid_after_attr_change do |name, test_values|
    describe name do
      test_values.each do |value|
        context "when set '#{value}'(valid value)" do
          subject { target_model }
          it { ->{ subject[name] = value}.should_not change(subject, :invalid?).from(true).to(false)}
          it {
            subject[name] = value
            should have_at_most(0).errors_on(name)
          }
        end
    end
  end
end

shared_examples_for :can_find_by_id do |model|
  it { ->{ model.class.find(subject.id) }.should_not raise_error(ActiveRecord::RecordNotFound) }
end

shared_examples_for :can_not_find_by_id do |model, id|
  it { ->{ model.class.find(subject.id) }.should raise_error(ActiveRecord::RecordNotFound) }
end

shared_examples_for :when_model_is_new do |model|
  subject { model }
  its(:valid?) { should_not be_true }
  its(:save) { should_not be_true }
end

shared_examples_for :when_model_is_valid do |model|
  subject { model }
  its(:valid?) { should be_true }
  its(:save) { should be_true }
end

shared_examples_for :valid_js_response do |action|
  subject { response }
  its(:status) { should == 200 }
  it { should render_template(action) }
  it { should_not render_with_layout }
  its(:content_type) { should  === 'text/javascript' }
end

shared_examples_for :redirected_to_page_not_found do
  it { should redirect_to(Constants.path.not_found) }
end
