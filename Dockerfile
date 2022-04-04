FROM ruby:3.1.0
#RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
#WORKDIR /myapp
#COPY src/* /myapp/src/
#COPY main.rb /myapp/main.rb

COPY . ./
RUN gem install rest-client

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Configure the main process to run when running the image
CMD ["ruby", "main.rb"]
