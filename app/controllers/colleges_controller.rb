# encoding: UTF-8

require 'rubygems'
require 'mechanize'
require 'iconv'

class CollegesController < ApplicationController

  def index
    @colleges = College.all;
  end

  def refreshOpenData
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    ic = Iconv.new("UTF-8", "UTF-16")

    server_txt = a.get('http://stats.moe.gov.tw/files/school/102/u1_new.txt')
    content_roll = ic.iconv(server_txt.content).split("\n").drop(3)
    
    content_roll.each do |line|
      lines = line.split("\t")

      cs = College.where( [ "code = ?", lines[0] ] )
      if cs.nil? or cs.size == 0
        c = College.new()
      else
        c = cs.first
      end
      c.code = lines[0]
      c.name = lines[1]
      c.administrative = lines[2]
      c.address = lines[3]
      c.telephone = lines[4]
      c.home_page = lines[5]
      c.category = lines[6]
      c.save
    end

  end

end
