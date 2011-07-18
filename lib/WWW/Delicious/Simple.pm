# ABSTRACT: Simple interface to the Delicious API
package WWW::Delicious::Simple;

=head1 SYNOPSIS

    use WWW::Delicious::Simple;

    WWW::Delicious::Simple->get_url_info({ url => 'http://www.twitter.com' });

=head1 DESCRIPTION

A very simple interface, into a very small portion, of the Delicious (V2) API.
Patches welcome to support more of the API.

Returns decoded json returned from the API.

Possibly very unstable; may have future backwards incompatible releases, if
anyone sends any patches.

=head1 METHODS

=cut

use strict;
use warnings;

use JSON;

my $API_BASE = 'http://feeds.delicious.com/v2/json/urlinfo/data?url=';

=head2 get_url_info

    my $data = WWW::Delicious::Simple->get_url_info({ url => $url });

Returns the data Delicious has stored for the URL specified.

=cut

sub get_url_info {
    my ( $class, $args ) = @_;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $response = $ua->get( $API_BASE . $args->{url} );

    if ( $response->is_success ) {
        return decode_json $response->content;
    }
    else {
        die $response->status_line;
    }
}

=head1 SEE ALSO

L<Net::Delicious>, L<http://www.delicious.com/help/json>

=cut

1;
