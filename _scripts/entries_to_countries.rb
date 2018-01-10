require "json"
require "FileUtils"

countries_dir = "../collections/countries/"

# remove old files
p "Removing all country files"
FileUtils.rm_f Dir.glob("#{countries_dir}")


entries_file = File.read("../_data/databases/entries.json")
database_types_file = File.read("../_data/databases/database_types.json")
country_names_file = File.read("../_data/databases/country_names.json")

entries_json = JSON.parse(entries_file)
database_types_json = JSON.parse(database_types_file)
country_names_json = JSON.parse(country_names_file)

grouped_entries = entries_json.group_by { |h| h['country'] }.map do |_,entries|
  country_code = entries[0]['country']

  next if country_code.nil? || country_code.empty?

  # sort entries by db_type & agency
  entries = entries.sort do |a, b|
    case
    when (database_types_json[a['db_type']]['name'] <=> database_types_json[b['db_type']]['name']) == 0
      a['agency'] <=> b['agency']
    else
      database_types_json[a['db_type']]['name'] <=> database_types_json[b['db_type']]['name']
    end
  end

  country_name = country_names_json[country_code]

  header =
    "---\n"\
    "title: Databases #{country_name}\n"\
    "layout: page\n"\
    "permalink: /databases/countries/#{country_code}\n"\
    "---\n"\

  content = "<h3 class=\"database-listing-title\">
      <i class=\"fa fa-fw fa-database\"></i>
      External databases
    </h3>
    <p class=\"database-listing-summary\">
      What are the best public information sources in #{country_name}?
    </p>
    "

  content << "<div class=\"entries w-50\">"

  entries.each do |entry|
    agency = entry['agency'].gsub('"', '&quote;')
    notes = entry['notes'].gsub('"', '&quote;')
    db_type = database_types_json[entry['db_type']]['name']

    content << "{% include country_entry.html
      agency=\"#{agency}\"
      db_type=\"#{db_type}\"
      url=\"#{entry['url']}\"
      notes=\"#{notes}\"
      paid=\"#{entry['paid']}\"
      registration_required=\"#{entry['registration_required']}\"
      government_db=\"#{entry['government_db']}\"
    %} \n"
  end

  content << "</div>"

  # write entries to file
  filename = "#{countries_dir}/#{country_code}.html"

  p "Printing to file #{filename}"
  out_file = File.new(filename, "w")
  out_file.puts(header << content)
  out_file.close

end