RSpec::Matchers.define :be_struct_with_params do |class_name, params|
  match do |actual|
    actual.to_h == params && actual.class == class_name
  end
end
