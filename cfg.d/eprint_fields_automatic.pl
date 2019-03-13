
$c->{set_eprint_automatic_fields} = sub
{
	my( $eprint ) = @_;

	# some historic records end up with engagement values with only contain pdr_link=FALSE and web_link=FALSE
	# these should be filtered out
	{
		my @eng = @{$eprint->get_value( "imp_engagement" ) };
		my @new_eng = ();
		foreach my $e (@eng)
		{
			my $valid = 0;
			foreach my $k (keys %{$e})
			{
				if( defined $e->{$k} )
				{
					next if $k eq "pdr_link" && $e->{$k} eq "FALSE";
					next if $k eq "web_link" && $e->{$k} eq "FALSE";
					$valid++;
				}
			}
			if( $valid )
			{
				push @new_eng, $e;
			}
		}
		$eprint->set_value( "imp_engagement", \@new_eng ); 
	}

	my $imp_summary = $eprint->get_value("imp_summary");
	my $imp_title   = $eprint->get_value("imp_title");
	if( $imp_title && length($imp_title) )
	{
		$eprint->set_value( "imp_summary_short", $imp_title );
		$eprint->set_value( "title", $imp_title );
	}
	elsif( $imp_summary && length($imp_summary) )
	{
		my $imp_summary_short;
		my $max = 150;
		if( length( $imp_summary ) < $max )
		{
			$imp_summary_short = $imp_summary;
		}
		else
		{
			$imp_summary_short = substr($imp_summary, 0, $max);
			$imp_summary_short =~ s/[\r\n\t ]+/ /g; # tidy white space
			$imp_summary_short =~ s/ +$//; # trim training white space
			$imp_summary_short =~ s/[^ ]+$//; # trim last word/part word
			$imp_summary_short .= "...";
		}
		my $imp_summary_short_old = $eprint->get_value( "imp_summary_short" );
		if( !$imp_summary_short_old || length($imp_summary_short_old) || $imp_summary_short_old ne $imp_summary_short )
		{
			$eprint->set_value( "imp_summary_short", $imp_summary_short );
			# for compatibility with other systems, set the unused title to be the same as imp_summary_short
			$eprint->set_value( "title", $imp_summary_short );
		}
	}

	my @ief = ();
	foreach my $e ( @{$eprint->get_value("imp_engagement")} )
	{
		next unless $e->{ "web_link" } && $e->{ "web_link" } eq "TRUE";

		my $ef;
		foreach my $f (qw/ activity description nature date evid_submitted /)
		{
			$ef->{ $f } = $e->{ $f };
		}
		push @ief, $ef;
	}
	$eprint->set_value("imp_engagement_filtered", \@ief);

};
