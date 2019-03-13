$c->{summary_page_metadata_1} = [qw/
  creators_name
  imp_summary
  imp_unfunded
/];

$c->{summary_page_metadata_2} = [qw/
  sword_depositor
  userid
  datestamp
  lastmod
/];


$c->{eprint_render} = sub
{
  my( $eprint, $repository, $preview ) = @_;

  my $boxes =
  {
    box1 =>
    {
      citation => "box_no_titles",
      params =>
      {
        box_title => [ $repository->make_text("Engagement"), "XHTML" ],
      },
      data =>
      {
        box_id => "box1",
        box_metadata => [ qw/ imp_engagement_filtered / ],
      }
    },
    box2 =>
    {
      citation => "box",
      params =>
      {
        box_title => [ $repository->make_text("Evidence"), "XHTML" ],
      },
      data =>
      {
        box_id => "box2",
        box_metadata => [ qw/ imp_evidence_link imp_evidence_of_change / ],
      }
    },
    box3 =>
    {
      citation => "box_fold",
      params =>
      {
        box_title => [ $repository->make_text("Difference"), "XHTML" ],
      },
      data =>
      {
        box_id => "box3",
        box_metadata => [ qw/ imp_difference imp_difference_other  / ],
      }
    },
    box4 =>
    {
      citation => "box_fold",
      params =>
      {
        box_title => [ $repository->make_text("Funding"), "XHTML" ],
      },
      data =>
      {
        box_id => "box4",
	# imp_fund_glasgow_ke_fund
        box_metadata => [ qw/ funding_funder_name funding_funder_code  imp_fund_esrc_iaa imp_fund_epsrc_iaa imp_fund_bbsrc_iaa imp_fund_stfc_iaa imp_fund_chancellors_fund imp_fund_other imp_additional_funding / ],
      }
    },
    box5 =>
    {
      citation => "box_fold_no_titles",
      params =>
      {
        box_title => [ $repository->make_text("External Collaborators"), "XHTML" ],
      },
      data =>
      {
        box_id => "box5",
        box_metadata => [ qw/ imp_external_collaborators / ],
        # box_metadata => [ qw/ imp_external_collaborators_organisation imp_external_collaborators_name imp_external_collaborators_position / ],
      }
    },
    box6 =>
    {
      citation => "box_fold",
      params =>
      {
        box_title => [ $repository->make_text("Esteem"), "XHTML" ],
      },
      data =>
      {
        box_id => "box6",
        box_metadata => [ qw/ imp_esteem_prize imp_esteem_editor imp_esteem_committee_chair imp_esteem_advisory_panel imp_esteem_other / ],
      }
    },
    box7 =>
    {
      citation => "box_fold_no_titles",
      params =>
      {
        box_title => [ $repository->make_text("External Links"), "XHTML" ],
      },
      data =>
      {
        box_id => "box7",
        box_metadata => [ qw/ link / ],
      }
    },
  };

  my $succeeds_field = $repository->dataset( "eprint" )->field( "succeeds" );
  my $commentary_field = $repository->dataset( "eprint" )->field( "commentary" );

  my $flags = { 
    has_multiple_versions => $eprint->in_thread( $succeeds_field ),
    in_commentary_thread => $eprint->in_thread( $commentary_field ),
    preview => $preview,
  };
  my %fragments = ();

  # Put in a message describing how this document has other versions
  # in the repository if appropriate
  if( $flags->{has_multiple_versions} )
  {
    my $latest = $eprint->last_in_thread( $succeeds_field );
    if( $latest->value( "eprintid" ) == $eprint->value( "eprintid" ) )
    {
      $flags->{latest_version} = 1;
      $fragments{multi_info} = $repository->html_phrase( "page:latest_version" );
    }
    else
    {
      $fragments{multi_info} = $repository->render_message(
        "warning",
        $repository->html_phrase( 
        "page:not_latest_version",
        link => $repository->render_link( $latest->get_url() ) ) );
    }
  }		

  # Now show the version and commentary response threads
  if( $flags->{has_multiple_versions} )
  {
    $fragments{version_tree} = $eprint->render_version_thread( $succeeds_field );
  }	
  if( $flags->{in_commentary_thread} )
  {
    $fragments{commentary_tree} = $eprint->render_version_thread( $commentary_field );
  }

  foreach my $key ( keys %fragments ) { $fragments{$key} = [ $fragments{$key}, "XHTML" ]; }
	
  my $page = $repository->xml()->create_document_fragment();
  $page->appendChild( $eprint->render_citation( "summary_page_1", %fragments, flags=>$flags ) );

  # hidden box2 for now
  foreach my $b ( qw/ box1 box3 box4 box5 box6 box7 / )
  {
    $eprint->{tmp__id} = $boxes->{$b}->{data}->{box_id};

    my $has_content = 0;
    foreach my $f ( @{ $boxes->{$b}->{data}->{box_metadata} } )
    {
      if( $eprint->is_set( $f ) )
      {
        $has_content = 1;
        last;
      }
    }

    if( $has_content )
    {
      my $div = $repository->make_element( "div", "id" => "$b" ) ;# , class => "summary_page_box_container" );
      $div->appendChild( $eprint->render_citation( $boxes->{$b}->{citation}, %{ $boxes->{$b}->{params} }, data=>$boxes->{$b}->{data} ) );
      $page->appendChild( $div );
    }
  }
  delete $eprint->{tmp__id};

  $page->appendChild( $eprint->render_citation( "summary_page_2", %fragments, flags=>$flags ) );

  my $title = $eprint->render_citation("brief");

  my $links = $repository->xml()->create_document_fragment();
  if( !$preview )
  {
    $links->appendChild( $repository->plugin( "Export::Simple" )->dataobj_to_html_header( $eprint ) );
####    $links->appendChild( $repository->plugin( "Export::DC" )->dataobj_to_html_header( $eprint ) );
  }

  return( $page, $title, $links );
};
