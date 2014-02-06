require 'spec_helper'

module Rubulage
  describe "#create" do
    before(:each) do
      db = Database.connection
      db.execute('DROP TABLE IF EXISTS transactions')
      db.execute('CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date DATETIME NOT NULL,
        odometer INTEGER NOT NULL,
        price INTEGER NOT NULL,
        gallons INTEGER NOT NULL,
        total INTEGER NOT NULL,
        missed TINYINT(1) NOT NULL DEFAULT 0,
        partial TINYINT(1) NOT NULL DEFAULT 0
      )')
    end

    context "with valid attributes" do
      valid = {date: Time.now, odometer: 123, gallons: 123, price: 123}
      it "saves the new transaction in the database" do
        expect{
          Transactions.create!(valid)
        }.to change(Transactions,:count).by(1)
      end
      it "returns the saved object" do
        tx = Transactions.create!(valid)
        expect(tx.class).to eq(Transactions)
        expect(tx.id).to eq(1)
      end
    end

    context "with invalid attributes" do

      invalid = {date: Time.now, odometer: 123, gallons: 123, price: 'BAD'}

      it "returns an error with invalid attributes" do
        expect{
            Transactions.create!(invalid)
          }.to raise_error
        expect(Transactions.count).to eq(0)
      end

      it "returns and error with missing required attributes" do
        expect{
            Transactions.create!({date: Time.now})
          }.to raise_error
        expect(Transactions.count).to eq(0)
      end

    end
  end

end
