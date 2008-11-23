package Lingua::JA::Categorize;
use strict;
use warnings;
use Lingua::JA::Categorize::Tokenizer;
use Lingua::JA::Categorize::Categorizer;
use Lingua::JA::Categorize::Generator;
use Lingua::JA::Categorize::Result;
use base qw( Lingua::JA::Categorize::Base );

__PACKAGE__->mk_accessors($_) for qw( tokenizer categorizer generator );

our $VERSION = '0.00001';

sub new {
    my $class = shift;
    my %args  = @_;
    my $self  = $class->SUPER::new( \%args );
    $self->tokenizer( Lingua::JA::Categorize::Tokenizer->new );
    $self->categorizer( Lingua::JA::Categorize::Categorizer->new );
    $self->generator( Lingua::JA::Categorize::Generator->new );
    return $self;
}

sub categorize {
    my $self     = shift;
    my $text     = shift;
    my $word_set = $self->tokenizer->tokenize( \$text, 20 );
    my $score    = $self->categorizer->categorize($word_set);
    return Lingua::JA::Categorize::Result->new(
        word_set => $word_set,
        score    => $score
    );
}

sub generate {
    my $self       = shift;
    my $categories = shift;
    my $brain      = $self->categorizer->brain;
    $self->generator->generate( $categories, $brain );
}

sub load {
    my $self      = shift;
    my $save_file = shift;
    $self->categorizer->load($save_file);
}

sub save {
    my $self      = shift;
    my $save_file = shift;
    $self->categorizer->save($save_file);
}

1;
__END__

=head1 NAME

Lingua::JA::Categorize - a Naive Bayes Classifier for Japanese document.

=head1 SYNOPSIS

  use Lingua::JA::Categorize;

  # generate
  my $c = Lingua::JA::Categorize->new;
  $c->generate($category_conf);
  $c->save('save_file');

  # categorize
  my $c = Lingua::JA::Categorize->new;
  $c->load('save_file');
  my $result = $c->categorize($text);
  print Dumper $result->list;

=head1 DESCRIPTION

Lingua::JA::Categorize is a Naive Bayes classifier for Japanese document.

B<THIS MODULE IS IN ITS ALPHA QUALITY.>

=head1 METHODS

=head2 new

=head2 categorize

=head2 generate

=head2 load

=head2 save

=head2 tokenizer

=head2 categorizer

=head2 generator

=head1 AUTHOR

takeshi miki E<lt>miki@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
