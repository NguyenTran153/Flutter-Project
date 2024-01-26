const countries = {
  "AF": "Afghanistan",
  "AL": "Albania",
  "DZ": "Algeria",
  "AS": "American Samoa",
  "AD": "Andorra",
  "AO": "Angola",
  "AI": "Anguilla",
  "AQ": "Antarctica",
  "AG": "Antigua and Barbuda",
  "AR": "Argentina",
  "AM": "Armenia",
  "AW": "Aruba",
  "AU": "Australia",
  "AT": "Austria",
  "AZ": "Azerbaijan",
  "BS": "Bahamas (the)",
  "BH": "Bahrain",
  "BD": "Bangladesh",
  "BB": "Barbados",
  "BY": "Belarus",
  "BE": "Belgium",
  "BZ": "Belize",
  "BJ": "Benin",
  "BM": "Bermuda",
  "BT": "Bhutan",
  "BO": "Bolivia (Plurinational State of)",
  "BQ": "Bonaire, Sint Eustatius and Saba",
  "BA": "Bosnia and Herzegovina",
  "BW": "Botswana",
  "BV": "Bouvet Island",
  "BR": "Brazil",
  "IO": "British Indian Ocean Territory (the)",
  "BN": "Brunei Darussalam",
  "BG": "Bulgaria",
  "BF": "Burkina Faso",
  "BI": "Burundi",
  "CV": "Cabo Verde",
  "KH": "Cambodia",
  "CM": "Cameroon",
  "CA": "Canada",
  "KY": "Cayman Islands (the)",
  "CF": "Central African Republic (the)",
  "TD": "Chad",
  "CL": "Chile",
  "CN": "China",
  "CX": "Christmas Island",
  "CC": "Cocos (Keeling) Islands (the)",
  "CO": "Colombia",
  "KM": "Comoros (the)",
  "CD": "Congo (the Democratic Republic of the)",
  "CG": "Congo (the)",
  "CK": "Cook Islands (the)",
  "CR": "Costa Rica",
  "HR": "Croatia",
  "CU": "Cuba",
  "CW": "Curaçao",
  "CY": "Cyprus",
  "CZ": "Czechia",
  "CI": "Côte d'Ivoire",
  "DK": "Denmark",
  "DJ": "Djibouti",
  "DM": "Dominica",
  "DO": "Dominican Republic (the)",
  "EC": "Ecuador",
  "EG": "Egypt",
  "SV": "El Salvador",
  "GQ": "Equatorial Guinea",
  "ER": "Eritrea",
  "EE": "Estonia",
  "SZ": "Eswatini",
  "ET": "Ethiopia",
  "FK": "Falkland Islands (the) [Malvinas]",
  "FO": "Faroe Islands (the)",
  "FJ": "Fiji",
  "FI": "Finland",
  "FR": "France",
  "GF": "French Guiana",
  "PF": "French Polynesia",
  "TF": "French Southern Territories (the)",
  "GA": "Gabon",
  "GM": "Gambia (the)",
  "GE": "Georgia",
  "DE": "Germany",
  "GH": "Ghana",
  "GI": "Gibraltar",
  "GR": "Greece",
  "GL": "Greenland",
  "GD": "Grenada",
  "GP": "Guadeloupe",
  "GU": "Guam",
  "GT": "Guatemala",
  "GG": "Guernsey",
  "GN": "Guinea",
  "GW": "Guinea-Bissau",
  "GY": "Guyana",
  "HT": "Haiti",
  "HM": "Heard Island and McDonald Islands",
  "VA": "Holy See (the)",
  "HN": "Honduras",
  "HK": "Hong Kong",
  "HU": "Hungary",
  "IS": "Iceland",
  "IN": "India",
  "ID": "Indonesia",
  "IR": "Iran (Islamic Republic of)",
  "IQ": "Iraq",
  "IE": "Ireland",
  "IM": "Isle of Man",
  "IL": "Israel",
  "IT": "Italy",
  "JM": "Jamaica",
  "JP": "Japan",
  "JE": "Jersey",
  "JO": "Jordan",
  "KZ": "Kazakhstan",
  "KE": "Kenya",
  "KI": "Kiribati",
  "KP": "Korea (the Democratic People's Republic of)",
  "KR": "Korea (the Republic of)",
  "KW": "Kuwait",
  "KG": "Kyrgyzstan",
  "LA": "Lao People's Democratic Republic (the)",
  "LV": "Latvia",
  "LB": "Lebanon",
  "LS": "Lesotho",
  "LR": "Liberia",
  "LY": "Libya",
  "LI": "Liechtenstein",
  "LT": "Lithuania",
  "LU": "Luxembourg",
  "MO": "Macao",
  "MG": "Madagascar",
  "MW": "Malawi",
  "MY": "Malaysia",
  "MV": "Maldives",
  "ML": "Mali",
  "MT": "Malta",
  "MH": "Marshall Islands (the)",
  "MQ": "Martinique",
  "MR": "Mauritania",
  "MU": "Mauritius",
  "YT": "Mayotte",
  "MX": "Mexico",
  "FM": "Micronesia (Federated States of)",
  "MD": "Moldova (the Republic of)",
  "MC": "Monaco",
  "MN": "Mongolia",
  "ME": "Montenegro",
  "MS": "Montserrat",
  "MA": "Morocco",
  "MZ": "Mozambique",
  "MM": "Myanmar",
  "NA": "Namibia",
  "NR": "Nauru",
  "NP": "Nepal",
  "NL": "Netherlands (the)",
  "NC": "New Caledonia",
  "NZ": "New Zealand",
  "NI": "Nicaragua",
  "NE": "Niger (the)",
  "NG": "Nigeria",
  "NU": "Niue",
  "NF": "Norfolk Island",
  "MP": "Northern Mariana Islands (the)",
  "NO": "Norway",
  "OM": "Oman",
  "PK": "Pakistan",
  "PW": "Palau",
  "PS": "Palestine, State of",
  "PA": "Panama",
  "PG": "Papua New Guinea",
  "PY": "Paraguay",
  "PE": "Peru",
  "PH": "Philippines (the)",
  "PN": "Pitcairn",
  "PL": "Poland",
  "PT": "Portugal",
  "PR": "Puerto Rico",
  "QA": "Qatar",
  "MK": "Republic of North Macedonia",
  "RO": "Romania",
  "RU": "Russian Federation",
  "RW": "Rwanda",
  "RE": "Réunion",
  "BL": "Saint Barthélemy",
  "SH": "Saint Helena, Ascension and Tristan da Cunha",
  "KN": "Saint Kitts and Nevis",
  "LC": "Saint Lucia",
  "MF": "Saint Martin (French part)",
  "PM": "Saint Pierre and Miquelon",
  "VC": "Saint Vincent and the Grenadines",
  "WS": "Samoa",
  "SM": "San Marino",
  "ST": "Sao Tome and Principe",
  "SA": "Saudi Arabia",
  "SN": "Senegal",
  "RS": "Serbia",
  "SC": "Seychelles",
  "SL": "Sierra Leone",
  "SG": "Singapore",
  "SX": "Sint Maarten (Dutch part)",
  "SK": "Slovakia",
  "SI": "Slovenia",
  "SB": "Solomon Islands",
  "SO": "Somalia",
  "ZA": "South Africa",
  "GS": "South Georgia and the South Sandwich Islands",
  "SS": "South Sudan",
  "ES": "Spain",
  "LK": "Sri Lanka",
  "SD": "Sudan (the)",
  "SR": "Suriname",
  "SJ": "Svalbard and Jan Mayen",
  "SE": "Sweden",
  "CH": "Switzerland",
  "SY": "Syrian Arab Republic",
  "TW": "Taiwan",
  "TJ": "Tajikistan",
  "TZ": "Tanzania, United Republic of",
  "TH": "Thailand",
  "TL": "Timor-Leste",
  "TG": "Togo",
  "TK": "Tokelau",
  "TO": "Tonga",
  "TT": "Trinidad and Tobago",
  "TN": "Tunisia",
  "TR": "Turkey",
  "TM": "Turkmenistan",
  "TC": "Turks and Caicos Islands (the)",
  "TV": "Tuvalu",
  "UG": "Uganda",
  "UA": "Ukraine",
  "AE": "United Arab Emirates (the)",
  "GB": "United Kingdom of Great Britain and Northern Ireland (the)",
  "UM": "United States Minor Outlying Islands (the)",
  "US": "United States of America (the)",
  "UY": "Uruguay",
  "UZ": "Uzbekistan",
  "VU": "Vanuatu",
  "VE": "Venezuela (Bolivarian Republic of)",
  "VN": "Viet Nam",
  "VG": "Virgin Islands (British)",
  "VI": "Virgin Islands (U.S.)",
  "WF": "Wallis and Futuna",
  "EH": "Western Sahara",
  "YE": "Yemen",
  "ZM": "Zambia",
  "ZW": "Zimbabwe",
  "AX": "Åland Islands"
};

const languageList = {
  "ab": {"name": "Abkhaz", "nativeName": "аҧсуа"},
  "aa": {"name": "Afar", "nativeName": "Afaraf"},
  "af": {"name": "Afrikaans", "nativeName": "Afrikaans"},
  "ak": {"name": "Akan", "nativeName": "Akan"},
  "sq": {"name": "Albanian", "nativeName": "Shqip"},
  "am": {"name": "Amharic", "nativeName": "አማርኛ"},
  "ar": {"name": "Arabic", "nativeName": "العربية"},
  "an": {"name": "Aragonese", "nativeName": "Aragonés"},
  "hy": {"name": "Armenian", "nativeName": "Հայերեն"},
  "as": {"name": "Assamese", "nativeName": "অসমীয়া"},
  "av": {"name": "Avaric", "nativeName": "авар мацӀ, магӀарул мацӀ"},
  "ae": {"name": "Avestan", "nativeName": "avesta"},
  "ay": {"name": "Aymara", "nativeName": "aymar aru"},
  "az": {"name": "Azerbaijani", "nativeName": "azərbaycan dili"},
  "bm": {"name": "Bambara", "nativeName": "bamanankan"},
  "ba": {"name": "Bashkir", "nativeName": "башҡорт теле"},
  "eu": {"name": "Basque", "nativeName": "euskara, euskera"},
  "be": {"name": "Belarusian", "nativeName": "Беларуская"},
  "bn": {"name": "Bengali", "nativeName": "বাংলা"},
  "bh": {"name": "Bihari", "nativeName": "भोजपुरी"},
  "bi": {"name": "Bislama", "nativeName": "Bislama"},
  "bs": {"name": "Bosnian", "nativeName": "bosanski jezik"},
  "br": {"name": "Breton", "nativeName": "brezhoneg"},
  "bg": {"name": "Bulgarian", "nativeName": "български език"},
  "my": {"name": "Burmese", "nativeName": "ဗမာစာ"},
  "ca": {"name": "Catalan; Valencian", "nativeName": "Català"},
  "ch": {"name": "Chamorro", "nativeName": "Chamoru"},
  "ce": {"name": "Chechen", "nativeName": "нохчийн мотт"},
  "ny": {"name": "Chichewa; Chewa; Nyanja", "nativeName": "chiCheŵa, chinyanja"},
  "zh": {"name": "Chinese", "nativeName": "中文 (Zhōngwén), 汉语, 漢語"},
  "cv": {"name": "Chuvash", "nativeName": "чӑваш чӗлхи"},
  "kw": {"name": "Cornish", "nativeName": "Kernewek"},
  "co": {"name": "Corsican", "nativeName": "corsu, lingua corsa"},
  "cr": {"name": "Cree", "nativeName": "ᓀᐦᐃᔭᐍᐏᐣ"},
  "hr": {"name": "Croatian", "nativeName": "hrvatski"},
  "cs": {"name": "Czech", "nativeName": "česky, čeština"},
  "da": {"name": "Danish", "nativeName": "dansk"},
  "dv": {"name": "Divehi; Dhivehi; Maldivian;", "nativeName": "ދިވެހި"},
  "nl": {"name": "Dutch", "nativeName": "Nederlands, Vlaams"},
  "en": {"name": "English", "nativeName": "English"},
  "eo": {"name": "Esperanto", "nativeName": "Esperanto"},
  "et": {"name": "Estonian", "nativeName": "eesti, eesti keel"},
  "ee": {"name": "Ewe", "nativeName": "Eʋegbe"},
  "fo": {"name": "Faroese", "nativeName": "føroyskt"},
  "fj": {"name": "Fijian", "nativeName": "vosa Vakaviti"},
  "fi": {"name": "Finnish", "nativeName": "suomi, suomen kieli"},
  "fr": {"name": "French", "nativeName": "français, langue française"},
  "ff": {"name": "Fula; Fulah; Pulaar; Pular", "nativeName": "Fulfulde, Pulaar, Pular"},
  "gl": {"name": "Galician", "nativeName": "Galego"},
  "ka": {"name": "Georgian", "nativeName": "ქართული"},
  "de": {"name": "German", "nativeName": "Deutsch"},
  "el": {"name": "Greek, Modern", "nativeName": "Ελληνικά"},
  "gn": {"name": "Guaraní", "nativeName": "Avañeẽ"},
  "gu": {"name": "Gujarati", "nativeName": "ગુજરાતી"},
  "ht": {"name": "Haitian; Haitian Creole", "nativeName": "Kreyòl ayisyen"},
  "ha": {"name": "Hausa", "nativeName": "Hausa, هَوُسَ"},
  "he": {"name": "Hebrew (modern)", "nativeName": "עברית"},
  "hz": {"name": "Herero", "nativeName": "Otjiherero"},
  "hi": {"name": "Hindi", "nativeName": "हिन्दी, हिंदी"},
  "ho": {"name": "Hiri Motu", "nativeName": "Hiri Motu"},
  "hu": {"name": "Hungarian", "nativeName": "Magyar"},
  "ia": {"name": "Interlingua", "nativeName": "Interlingua"},
  "id": {"name": "Indonesian", "nativeName": "Bahasa Indonesia"},
  "ie": {"name": "Interlingue", "nativeName": "Originally called Occidental; then Interlingue after WWII"},
  "ga": {"name": "Irish", "nativeName": "Gaeilge"},
  "ig": {"name": "Igbo", "nativeName": "Asụsụ Igbo"},
  "ik": {"name": "Inupiaq", "nativeName": "Iñupiaq, Iñupiatun"},
  "io": {"name": "Ido", "nativeName": "Ido"},
  "is": {"name": "Icelandic", "nativeName": "Íslenska"},
  "it": {"name": "Italian", "nativeName": "Italiano"},
  "iu": {"name": "Inuktitut", "nativeName": "ᐃᓄᒃᑎᑐᑦ"},
  "ja": {"name": "Japanese", "nativeName": "日本語 (にほんご／にっぽんご)"},
  "jv": {"name": "Javanese", "nativeName": "basa Jawa"},
  "kl": {"name": "Kalaallisut, Greenlandic", "nativeName": "kalaallisut, kalaallit oqaasii"},
  "kn": {"name": "Kannada", "nativeName": "ಕನ್ನಡ"},
  "kr": {"name": "Kanuri", "nativeName": "Kanuri"},
  "ks": {"name": "Kashmiri", "nativeName": "कश्मीरी, كشميري‎"},
  "kk": {"name": "Kazakh", "nativeName": "Қазақ тілі"},
  "km": {"name": "Khmer", "nativeName": "ភាសាខ្មែរ"},
  "ki": {"name": "Kikuyu, Gikuyu", "nativeName": "Gĩkũyũ"},
  "rw": {"name": "Kinyarwanda", "nativeName": "Ikinyarwanda"},
  "ky": {"name": "Kirghiz, Kyrgyz", "nativeName": "кыргыз тили"},
  "kv": {"name": "Komi", "nativeName": "коми кыв"},
  "kg": {"name": "Kongo", "nativeName": "KiKongo"},
  "ko": {"name": "Korean", "nativeName": "한국어 (韓國語), 조선말 (朝鮮語)"},
  "ku": {"name": "Kurdish", "nativeName": "Kurdî, كوردی‎"},
  "kj": {"name": "Kwanyama, Kuanyama", "nativeName": "Kuanyama"},
  "la": {"name": "Latin", "nativeName": "latine, lingua latina"},
  "lb": {"name": "Luxembourgish, Letzeburgesch", "nativeName": "Lëtzebuergesch"},
  "lg": {"name": "Luganda", "nativeName": "Luganda"},
  "li": {"name": "Limburgish, Limburgan, Limburger", "nativeName": "Limburgs"},
  "ln": {"name": "Lingala", "nativeName": "Lingála"},
  "lo": {"name": "Lao", "nativeName": "ພາສາລາວ"},
  "lt": {"name": "Lithuanian", "nativeName": "lietuvių kalba"},
  "lu": {"name": "Luba-Katanga", "nativeName": ""},
  "lv": {"name": "Latvian", "nativeName": "latviešu valoda"},
  "gv": {"name": "Manx", "nativeName": "Gaelg, Gailck"},
  "mk": {"name": "Macedonian", "nativeName": "македонски јазик"},
  "mg": {"name": "Malagasy", "nativeName": "Malagasy fiteny"},
  "ms": {"name": "Malay", "nativeName": "bahasa Melayu, بهاس ملايو‎"},
  "ml": {"name": "Malayalam", "nativeName": "മലയാളം"},
  "mt": {"name": "Maltese", "nativeName": "Malti"},
  "mi": {"name": "Māori", "nativeName": "te reo Māori"},
  "mr": {"name": "Marathi (Marāṭhī)", "nativeName": "मराठी"},
  "mh": {"name": "Marshallese", "nativeName": "Kajin M̧ajeļ"},
  "mn": {"name": "Mongolian", "nativeName": "монгол"},
  "na": {"name": "Nauru", "nativeName": "Ekakairũ Naoero"},
  "nv": {"name": "Navajo, Navaho", "nativeName": "Diné bizaad, Dinékʼehǰí"},
  "nb": {"name": "Norwegian Bokmål", "nativeName": "Norsk bokmål"},
  "nd": {"name": "North Ndebele", "nativeName": "isiNdebele"},
  "ne": {"name": "Nepali", "nativeName": "नेपाली"},
  "ng": {"name": "Ndonga", "nativeName": "Owambo"},
  "nn": {"name": "Norwegian Nynorsk", "nativeName": "Norsk nynorsk"},
  "no": {"name": "Norwegian", "nativeName": "Norsk"},
  "ii": {"name": "Nuosu", "nativeName": "ꆈꌠ꒿ Nuosuhxop"},
  "nr": {"name": "South Ndebele", "nativeName": "isiNdebele"},
  "oc": {"name": "Occitan", "nativeName": "Occitan"},
  "oj": {"name": "Ojibwe, Ojibwa", "nativeName": "ᐊᓂᔑᓈᐯᒧᐎᓐ"},
  "cu": {
    "name": "Old Church Slavonic, Church Slavic, Church Slavonic, Old Bulgarian, Old Slavonic",
    "nativeName": "ѩзыкъ словѣньскъ"
  },
  "om": {"name": "Oromo", "nativeName": "Afaan Oromoo"},
  "or": {"name": "Oriya", "nativeName": "ଓଡ଼ିଆ"},
  "os": {"name": "Ossetian, Ossetic", "nativeName": "ирон æвзаг"},
  "pa": {"name": "Panjabi, Punjabi", "nativeName": "ਪੰਜਾਬੀ, پنجابی‎"},
  "pi": {"name": "Pāli", "nativeName": "पाऴि"},
  "fa": {"name": "Persian", "nativeName": "فارسی"},
  "pl": {"name": "Polish", "nativeName": "polski"},
  "ps": {"name": "Pashto, Pushto", "nativeName": "پښتو"},
  "pt": {"name": "Portuguese", "nativeName": "Português"},
  "qu": {"name": "Quechua", "nativeName": "Runa Simi, Kichwa"},
  "rm": {"name": "Romansh", "nativeName": "rumantsch grischun"},
  "rn": {"name": "Kirundi", "nativeName": "kiRundi"},
  "ro": {"name": "Romanian, Moldavian, Moldovan", "nativeName": "română"},
  "ru": {"name": "Russian", "nativeName": "русский язык"},
  "sa": {"name": "Sanskrit (Saṁskṛta)", "nativeName": "संस्कृतम्"},
  "sc": {"name": "Sardinian", "nativeName": "sardu"},
  "sd": {"name": "Sindhi", "nativeName": "सिन्धी, سنڌي، سندھی‎"},
  "se": {"name": "Northern Sami", "nativeName": "Davvisámegiella"},
  "sm": {"name": "Samoan", "nativeName": "gagana faa Samoa"},
  "sg": {"name": "Sango", "nativeName": "yângâ tî sängö"},
  "sr": {"name": "Serbian", "nativeName": "српски језик"},
  "gd": {"name": "Scottish Gaelic; Gaelic", "nativeName": "Gàidhlig"},
  "sn": {"name": "Shona", "nativeName": "chiShona"},
  "si": {"name": "Sinhala, Sinhalese", "nativeName": "සිංහල"},
  "sk": {"name": "Slovak", "nativeName": "slovenčina"},
  "sl": {"name": "Slovene", "nativeName": "slovenščina"},
  "so": {"name": "Somali", "nativeName": "Soomaaliga, af Soomaali"},
  "st": {"name": "Southern Sotho", "nativeName": "Sesotho"},
  "es": {"name": "Spanish; Castilian", "nativeName": "español, castellano"},
  "su": {"name": "Sundanese", "nativeName": "Basa Sunda"},
  "sw": {"name": "Swahili", "nativeName": "Kiswahili"},
  "ss": {"name": "Swati", "nativeName": "SiSwati"},
  "sv": {"name": "Swedish", "nativeName": "svenska"},
  "ta": {"name": "Tamil", "nativeName": "தமிழ்"},
  "te": {"name": "Telugu", "nativeName": "తెలుగు"},
  "tg": {"name": "Tajik", "nativeName": "тоҷикӣ, toğikī, تاجیکی‎"},
  "th": {"name": "Thai", "nativeName": "ไทย"},
  "ti": {"name": "Tigrinya", "nativeName": "ትግርኛ"},
  "bo": {"name": "Tibetan Standard, Tibetan, Central", "nativeName": "བོད་ཡིག"},
  "tk": {"name": "Turkmen", "nativeName": "Türkmen, Түркмен"},
  "tl": {"name": "Tagalog", "nativeName": "Wikang Tagalog, ᜏᜒᜃᜅ᜔ ᜆᜄᜎᜓᜄ᜔"},
  "tn": {"name": "Tswana", "nativeName": "Setswana"},
  "to": {"name": "Tonga (Tonga Islands)", "nativeName": "faka Tonga"},
  "tr": {"name": "Turkish", "nativeName": "Türkçe"},
  "ts": {"name": "Tsonga", "nativeName": "Xitsonga"},
  "tt": {"name": "Tatar", "nativeName": "татарча, tatarça, تاتارچا‎"},
  "tw": {"name": "Twi", "nativeName": "Twi"},
  "ty": {"name": "Tahitian", "nativeName": "Reo Tahiti"},
  "ug": {"name": "Uighur, Uyghur", "nativeName": "Uyƣurqə, ئۇيغۇرچە‎"},
  "uk": {"name": "Ukrainian", "nativeName": "українська"},
  "ur": {"name": "Urdu", "nativeName": "اردو"},
  "uz": {"name": "Uzbek", "nativeName": "zbek, Ўзбек, أۇزبېك‎"},
  "ve": {"name": "Venda", "nativeName": "Tshivenḓa"},
  "vi": {"name": "Vietnamese", "nativeName": "Tiếng Việt"},
  "vo": {"name": "Volapük", "nativeName": "Volapük"},
  "wa": {"name": "Walloon", "nativeName": "Walon"},
  "cy": {"name": "Welsh", "nativeName": "Cymraeg"},
  "wo": {"name": "Wolof", "nativeName": "Wollof"},
  "fy": {"name": "Western Frisian", "nativeName": "Frysk"},
  "xh": {"name": "Xhosa", "nativeName": "isiXhosa"},
  "yi": {"name": "Yiddish", "nativeName": "ייִדיש"},
  "yo": {"name": "Yoruba", "nativeName": "Yorùbá"},
  "za": {"name": "Zhuang, Chuang", "nativeName": "Saɯ cueŋƅ, Saw cuengh"}
};

const itemsPerPage = [
  10,
  20,
  30,
  40,
];

const courseLevels = {
  '0': 'Any level',
  '1': 'Beginner',
  '2': 'High Beginner',
  '3': 'Pre-Intermediate',
  '4': 'Intermediate',
  '5': 'Upper-Intermediate',
  '6': 'Advanced',
  '7': 'Proficiency'
};

const userLevels = {
  "BEGINNER": "Pre A1 (Beginner)",
  "HIGHER_BEGINNER": "A1 (Higher Beginner)",
  "PRE_INTERMEDIATE": "A2 (Pre-Intermediate)",
  "INTERMEDIATE": "B1 (Intermediate)",
  "UPPER_INTERMEDIATE": "B2 (Upper-Intermediate)",
  "ADVANCED": "C1 (Advanced)",
  "PROFICIENCY": "C2 (Proficiency)",
};