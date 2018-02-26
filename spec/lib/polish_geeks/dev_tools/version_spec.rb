# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PolishGeeks::DevTools do
  it { is_expected.to be_const_defined(:VERSION) }
end
