package EPrints::Plugin::MePrints::Widget::ImpactWebLink;

use EPrints::Plugin::MePrints::Widget;
@ISA = ( 'EPrints::Plugin::MePrints::Widget' );

use strict;
use LWP::Simple qw(get);

sub new
{
	my( $class, %params ) = @_;
	
	my $self = $class->SUPER::new(%params);

	$self->{name} = "Impact Web Links";
	$self->{visible} = "all";
	$self->{advertise} = 1;

	# $self->{surround} = 'Simple';
	$self->{render_title} = 1;
	$self->{show_in_controls} = 1;

	return $self;	
}

sub render_content
{
	my( $self ) = @_;

	my $session = $self->{session};
	my $user = $self->{user};
my $orcid = "0000-0002-0640-0422";

	my $frag = $session->make_doc_fragment;
	my $url = "/cgi/impactget?o=$orcid";
	$frag->appendChild( $session->make_element( "div", "id" => "impact_web_link" ) );
	$frag->appendChild( $session->make_javascript(<<"EOJ") );
new Ajax.Updater('impact_web_link', '$url', {method:'get'} );
EOJ

	return $frag;
}

1;
