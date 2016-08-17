class MailTemplate < ActiveRecord::Base 
  belongs_to :mail_kind,  :class_name => "MailKind", :foreign_key => "kind"
  belongs_to :stu_state
  LANGUAGE = [
    ["English", "eng"],
    ["中文", "chn"]
  ]
  
  validates_presence_of   :kind, :title, :content
  validates_inclusion_of  :language,  :in => LANGUAGE.map {|disp, value| value}
  def self.xiao_all
    MailTemplate.find(:all,:conditions=>"stu_state_id=3")
  end
  
  def self.rcrm_all
    MailTemplate.find(:all,:conditions=>"stu_state_id=1")
  end
end
