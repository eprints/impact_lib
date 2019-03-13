package EPrints::Plugin::Export::CaseStudyTemplateHTML;
use EPrints::Plugin::Export::HTMLFile;

@ISA = ( "EPrints::Plugin::Export::HTMLFile" );

use strict;

sub new
{
	my( $class, %opts ) = @_;

	my $self = $class->SUPER::new( %opts );

	$self->{name} = "Case Study Template HTML";
	$self->{accept} = [ 'dataobj/eprint', 'list/eprint' ];
	$self->{visible} = "all";
	$self->{suffix} = ".html";
	$self->{mimetype} = "text/html; charset=utf-8";
	
	return $self;
}

sub output_dataobj
{
	my( $plugin, $dataobj ) = @_;

	my $xml = $plugin->xml_dataobj( $dataobj );

	return EPrints::XML::to_string( $xml, undef, 1 );
}

sub xml_dataobj
{
	my( $plugin, $dataobj ) = @_;

	my $p = $plugin->{session}->make_element( "p", class=>"citation" );
	$p->appendChild( $dataobj->render_citation_link( "case_study_template" ) );

	return $p;
}

1;
