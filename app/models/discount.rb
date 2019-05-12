# frozen_string_literal: true

class Discount < ApplicationRecord
  KINDS = %w[set extra].freeze

  belongs_to :cart

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, if: :is_set?
  validates :count, numericality: { greater_than_or_equal_to: 0 }, if: :is_extra?
  validates :kind, inclusion: { in: KINDS }

  scope :sets, -> { where(kind: 'set') }
  scope :extras, -> { where(kind: 'extra') }

  def is_set?
    kind == 'set'
  end

  def is_extra?
    kind == 'extra'
  end

end
