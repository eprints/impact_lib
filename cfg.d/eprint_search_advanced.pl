
$c->{search}->{advanced} = 
{
	search_fields => [
{ meta_fields => ['creators_name'] },

{ meta_fields => ['imp_summary'] },
#{ meta_fields => ['imp_summary_short'] },

{ meta_fields => ['title'] },
{ meta_fields => ['divisions'] },
{ meta_fields => ['eprint_status'] }, # admin only

{ meta_fields => ['imp_additional_funding'] },
{ meta_fields => ['imp_contact_public_engagement'] },
{ meta_fields => ['imp_unfunded'] },

#{ meta_fields => ['imp_esteem_prize'] },
#{ meta_fields => ['imp_esteem_editor'] },
#{ meta_fields => ['imp_esteem_committee_chair'] },
#{ meta_fields => ['imp_esteem_advisory_panel'] },
#{ meta_fields => ['imp_esteem_other'] },

#{ meta_fields => ['imp_fund_glasgow_ke_fund'] },
#{ meta_fields => ['imp_fund_esrc_iaa'] },
#{ meta_fields => ['imp_fund_epsrc_iaa'] },
#{ meta_fields => ['imp_fund_bbsrc_iaa'] },
#{ meta_fields => ['imp_fund_stfc_iaa'] },
#{ meta_fields => ['imp_fund_chancellors_fund'] },
#{ meta_fields => ['imp_fund_other'] },

{ meta_fields => ['imp_difference'] },
{ meta_fields => ['imp_difference_other'] },

#{ meta_fields => ['imp_evidence_link'] },
#{ meta_fields => ['imp_evidence_of_change'] },

{ meta_fields => ['imp_external_collaborators'] },
#{ meta_fields => ['imp_pdr_link'] },
#{ meta_fields => ['imp_web_link'] },
{ meta_fields => ['documents.imp_evidence_type'] },
{ meta_fields => ['documents.imp_evidence_type_other'] },

{ meta_fields => [ "documents" ] },
{ meta_fields => [ "documents.format" ] },
	],
	preamble_phrase => "cgi/advsearch:preamble",
	title_phrase => "cgi/advsearch:adv_search",
	citation => "result",
	page_size => 20,
	order_methods => {
		"bytitle" 	 => "title/type"
	},
	default_order => "bytitle",
	show_zero_results => 1,
};
