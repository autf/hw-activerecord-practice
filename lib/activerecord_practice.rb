require 'sqlite3'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')

class Customer < ActiveRecord::Base
  def to_s = "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  
  def self.any_candice = Customer.where(first: 'Candice')
  def self.with_valid_email = Customer.where("email like '%@%'")
  def self.with_dot_org_email = Customer.where("email like '%@%.org'")
  def self.with_invalid_email = Customer.where.not("email like '%@%'")
  def self.with_blank_email = Customer.where('email is null or email = ""')
  def self.born_before_1980 = Customer.where('birthdate < "1980-01-01"')
  def self.with_valid_email_and_born_before_1980 = Customer.where('email like "%@%" and birthdate < "1980-01-01"')
  # def self.with_valid_email_and_born_before_1980 = self.with_valid_email.and(self.born_before_1980)
  def self.last_names_starting_with_b = Customer.where('last like "B%"').order(:birthdate) # `order`, not `sort`
  def self.twenty_youngest = Customer.order(:birthdate).reverse_order.limit(20)
  def self.update_gussie_murray_birthdate = Customer.find_by(first: 'Gussie', last: 'Murray').update(birthdate: Time.parse('February 8,2004'))
  def self.change_all_invalid_emails_to_blank = Customer.where('email is null or email not like "%@%"').update_all(email: '')
  def self.delete_meggie_herman = Customer.find_by(first: 'Meggie', last: 'Herman').delete
  def self.delete_everyone_born_before_1978 = Customer.where('birthdate <= "1997-12-31"').delete_all
end
