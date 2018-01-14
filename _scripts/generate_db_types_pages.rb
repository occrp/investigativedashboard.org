require "json"
require "FileUtils"

topics_dir = "../collections/topics"

# remove old files
p "Removing all database types files"
FileUtils.rm_f Dir.glob("#{topics_dir}")


entries_file = File.read("../_data/databases/entries.json")
database_types_file = File.read("../_data/databases/database_types.json")
country_names_file = File.read("../_data/databases/country_names.json")

entries_json = JSON.parse(entries_file)
database_types_json = JSON.parse(database_types_file)
country_names_json = JSON.parse(country_names_file)

grouped_entries = entries_json.group_by { |h| h['db_type'] }.map do |_,entries|
  db_type = entries[0]['db_type']
  db_type_name = database_types_json[db_type] ? database_types_json[db_type]['name'] : db_type

  next if db_type.nil? || db_type.empty?

  # sort entries by country name
  entries = entries.sort do |a, b|
    a_country_name = country_names_json[a['country']] || ''
    b_country_name = country_names_json[b['country']] || ''
    case
    when (a_country_name <=> b_country_name) == 0
      a['agency'] <=> b['agency']
    else
      a_country_name <=> b_country_name
    end
  end

  header =
    "---\n"\
    "title: #{db_type_name}\n"\
    "layout: page\n"\
    "permalink: /databases/topics/#{db_type}\n"\
    "type: topic\n"\
    "---\n"\

  content = "<div class=\"entries w-75\">"

  entries.each do |entry|
    agency = entry['agency'].gsub('"', '&quote;')
    notes = entry['notes'].gsub('"', '&quote;')
    country_name = country_names_json[entry['country']] || 'All Databases'

    content << "{% include db_type_entry.html
      agency=\"#{agency}\"
      country_name=\"#{country_name}\"
      url=\"#{entry['url']}\"
      notes=\"#{notes}\"
      paid=\"#{entry['paid']}\"
      registration_required=\"#{entry['registration_required']}\"
      government_db=\"#{entry['government_db']}\"
    %} \n"
  end

  content << "</div>"

  # write entries to file
  filename = "#{topics_dir}/#{db_type}.html"

  p "Printing to file #{filename}"
  out_file = File.new(filename, "w")
  out_file.puts(header << content)
  out_file.close

end
