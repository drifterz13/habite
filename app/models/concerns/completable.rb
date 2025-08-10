module Completable
  extend ActiveSupport::Concern

  included do
    before_save :set_default_period
  end

  def in_completable_period?
    in_completion_period? or endless?
  end

  def endless?
    end_at.nil?
  end

  def has_ended?
    end_at && Time.now > end_at
  end

  private

  def completion_period
    start_at..end_at
  end

  def in_completion_period?
    return false if not has_completion_period?

    completion_period.cover? Time.now
  end

  def has_completion_period?
    start_at.present? && end_at.present?
  end

  def set_default_period
    return nil if has_completion_period?

    self.start_at = Time.now
    self.end_at = start_at + 7.days
  end
end
