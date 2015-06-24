FROM      ruby:2.1.6
MAINTAINER V David Zvenyach <vladlen.zvenyach@gsa.gov>
RUN apt-get update && apt-get install pdftk -y
WORKDIR /iaa-gem
ADD . /iaa-gem
RUN gem install bundler -v 1.10.4
RUN bundle install
CMD ["/iaa-gem/bin/console"]