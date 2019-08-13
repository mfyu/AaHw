# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TagTopic.destroy_all
TagTopic.create(name: 'porn')
TagTopic.create(name: 'sports')
TagTopic.create(name: 'news')
TagTopic.create(name: 'kpop')
TagTopic.create(name: 'gaming')

Tagging.destroy_all
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'porn').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.xvideos.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'porn').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.reddit.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'sports').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.reddit.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'news').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.reddit.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'gaming').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.reddit.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'kpop').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.reddit.com').id)
Tagging.create(tag_topic_id: TagTopic.find_by(name: 'news').id , shortened_url_id: ShortenedUrl.find_by(long_url: 'www.google.com').id)