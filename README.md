# The Investigative Dashboard Databases

## Prerequisites
You will need the following things properly installed on your computer:

* [jekyll](https://jekyllrb.com/.com/)


## Running / Development
* `jekyll serve`
* Visit your app at [http://127.0.0.1:4000/](http://127.0.0.1:4000/).


## Adding new database entries

#### 1. Add the entry to the appropriate country in the `_data/country_entries.json` file.
Example: Entry
```json
{
    "id":1,
    "agency":"Financial Services Commission",
    "db_type":"business",
    "country":"VG",
    ...
}
```
Will go into the Virgin Islands part of the data file:
```json
{
    "country_code":"VG",
    "country_name":"Virgin Islands, British",
    "entries":[
      {
          "id":1,
          "agency":"Financial Services Commission",
          "db_type":"business",
          "country":"VG",
          ...
      },
    ...
    ]
}
```

#### 2. Add the entry to the appropriate database type in the `_data/topics_entries.json` file.
Example: Entry
```json
{
    "id":1,
    "agency":"Financial Services Commission",
    "db_type":"business",
    "country":"VG",
    ...
}
```
Will go into the Virgin Islands part of the data file:
```json
{
    "db_type":"business",
    "db_type_name":"Business Registry",
    "entries":[
      {
          "id":1,
          "agency":"Financial Services Commission",
          "db_type":"business",
          "country":"VG",
          ...
      },
    ...
    ]
}
```

