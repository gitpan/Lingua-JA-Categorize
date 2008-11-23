use inc::Module::Install;
name 'Lingua-JA-Categorize';
all_from 'lib/Lingua/JA/Categorize.pm';

requires 'Class::Accessor::Fast';
requires 'Class::Data::Inheritable';
requires 'Algorithm::NaiveBayes';
requires 'Lingua::JA::TFIDF';
requires 'Lingua::JA::Expand';

requires 'YAML';
requires 'HTML::Feature';
requires 'POE';
requires 'POE::Component::Server::HTTP';
requires 'Template';
requires 'HTTP::Request::AsCGI';
requires 'CGI';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;