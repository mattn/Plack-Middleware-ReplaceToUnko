package Plack::Middleware::ReplaceToUnko;
use strict;
use parent qw(Plack::Middleware);
use Plack::Util::Accessor qw/unko_image_url/;
our $VERSION = '0.01';

sub call {
    my ( $self, $env ) = @_;

    if ( $env->{PATH_INFO} ne $self->unko_image_url
        && $env->{PATH_INFO} =~ /^.+\.(png|jpg|jpeg|gif)$/ ) {

        my $scheme = qr{\Q$env->{'psgi.url_scheme'}\E};
        my $host = $env->{HTTP_HOST};
        $host = qr{\Q$host\E};
        if ( $env->{HTTP_REFERER} !~ m{\A$scheme://$host(?:/|\Z)} ) {
            return [ '301', [
                    'Location'       => $self->unko_image_url,
                    'Content-Length' => 4
                ], ['unko'] ];
        }
    }
    $self->app->($env);
}

1;

__END__

=head1 NAME

=head1 SYNOPSIS

    enable "ReplaceToUnko";

=head1 DESCRIPTION

=head1 AUTHOR

Yasuhiro Matsumoto

=head1 SEE ALSO

L<Plack>

=cut

