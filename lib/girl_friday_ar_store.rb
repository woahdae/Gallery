class GirlFridayArStore
  class CreateStore < ActiveRecord::Migration
    def change
      create_table :girl_friday_messages do |t|
        t.string :queue_name
        t.text :msg
      end

      add_index :girl_friday_messages, :queue_name
    end
  end

  class GirlFridayMessage < ActiveRecord::Base
    serialize :msg, Marshal

    if !table_exists?
      CreateStore.migrate(:up)
    end
  end

  def initialize(name, options = {})
    @queue_name = name
  end

  def push(work)
    GirlFridayMessage.create!(
      :queue_name => @queue_name,
      :msg        => work)
  end

  def pop
    msg = GirlFridayMessage.where(:queue_name => @queue_name).lock(true).first
    msg.try(:delete)
    msg
  end

  def size
    GirlFridayMessage.count
  end
end
