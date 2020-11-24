require "pry"

class Transfer
  attr_reader :sender, :receiver, :amount 
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.balance > @amount && @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.valid? && @status == "pending"
      @receiver.balance += @amount 
      @sender.balance -= @amount
      @status = "complete"
    elsif !self.valid?
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer
    if @status == "complete"
      @receiver.balance -= @amount 
      @sender.balance += @amount
      @status = "reversed"
    end
  end

end
