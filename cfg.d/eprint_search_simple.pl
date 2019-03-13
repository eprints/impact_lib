$c->{search}->{simple} = 
{
	search_fields => [
		{
			id => "q",
			meta_fields => [
				"documents",
				"imp_summary",
				"title",
				"creators_name"
			]
		},
	],
#	preamble_phrase => "cgi/search:preamble",
	title_phrase => "cgi/search:simple_search",
	citation => "result",
	page_size => 20,
	order_methods => {
		"bytitle" 	 => "title/type"
	},
	default_order => "bytitle",
	show_zero_results => 1,
};
