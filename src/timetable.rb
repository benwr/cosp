#!/usr/bin/env ruby

require 'open-uri' 
require 'nokogiri'


def get_course (subject, id)
  subject = subject.upcase
  term = 201201
  number = id

  found = false;

  crn = 0;
  
  
  while (not found)
    url = base_url + ".P_ProcRequest?\
history=Y;CAMPUS=0&TERMYEAR=#{term}&CORE_CODE=AR%25&SUBJ_CODE=#{subject}\
&SCHDTYPE=%25&CRSE_NUMBER=#{number}&crn=&open_only=\
&BTN_PRESSED=FIND+class+sections&inst_name=&PRINT_FRIEND=Y"
    response = Nokogiri::HTML(open(url))
    response.xpath("//font[@size=1]").each do |field|
      if field.text =~ /^\d+$/
        found = true
        crn = field.text.to_i
      end
    end
    
  end
end

class Timetable
  def initialize(url="https://banweb.banner.vt.edu/ssb/prod/HZSKVTSC", 
                 sem='201301',
                 search_format=".P_ProcRequest?history=Y&CAMPUS=0&TERMYEAR=%{term}&CORE_CODE=AR%%25&SUBJ_CODE=%{subject}&SCHDTYPE=%%25&CRSE_NUMBER=%{number}&crn=&open_only=&BTN_PRESSED=FIND+class+sections&inst_name=&PRINT_FRIEND=Y")
    @url = url
    @current_term = sem
    @search_format = search_format
  end

  def get_course(subj, id)  # returns a hash table with subject, id, title, 
    term = @current_term    # description, example crn, credit count, prereqs, 
    results = []            # coreqs
    while (!(results = search(term, subj, id)))
      term = self.previous_semester(term)
    end
  end

  private
  def search(term, subj, id) # returns a 2d array of the results
    search_string = search_format % {   :term => term,
                                     :subject => subj,
                                      :number => id}
    resp = Nokogiri::HTML(open(@url + search_string))
    puts resp.to_s
  end

  def previous_semester(sem)
    # semester strings are yyyytt, where tt = 01 means spring, tt = 07 
    # means summer I, tt = 07 is summer II, and tt = 09 is fall.
    case sem[-1]
    when '1'
      return (sem[0..3].to_i  - 1).to_s + '09'
    when '6'
      return sem[0..3] + '01'
    when '7'
      return sem[0..3] + '06'
    when '9'
      return sem[0..3] + '07'
    else
      raise ValueError, "Does not appear to be a valid term identifier: #{sem}"
    end
  end
end
