require 'rails_helper'

module Cadmin
  RSpec.describe ArticleCategory, type: :model do
    it "Is a valid ArticleCategory" do
      ac = Cadmin::ArticleCategory.create(name: 'Test Category')
      expect(ac.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Category: #{ac.name}"
    end
  end

  RSpec.describe Article, type: :model do
    it "Is a valid Article" do
      article = Article.create(title: 'Hello test', content: 'Hello world from test!', status: 1,user_id: 1, article_category_id: 1)
      expect(article.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Article: #{article.title}"
    end
  end

  RSpec.describe Comment, type: :model do
    it "Is a valid Comment" do
      comment = Comment.create(content: 'Its a comment', user_id: 1, article_id: 1)
      expect(comment.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Comment: #{comment.content}"
    end
  end

  RSpec.describe Conversation, type: :model do
    it "Is a valid Conversation" do
      conversation = Conversation.create(sender_id: 1, recipient_id: 2)
      expect(conversation.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Conversation: #{conversation.recipient_id}"
    end
  end

  RSpec.describe Discount, type: :model do
    it "Is a valid Discount" do
      discount = Discount.create(name: 'test', type_discount: 'default', description: '0 descuento', amount: 0.00)
      expect(discount.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Discount: #{discount.name}"
    end
  end

  RSpec.describe EventService, type: :model do
    it "Is a valid EventService" do
      es = EventService.create(event_id: 1, service_id: 2, discount_id: 2, start_time: 3)
      expect(es.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> EventService: #{es.event_id}"
    end
  end

  RSpec.describe Event, type: :model do
    it "Is a valid Event" do
      envent = Event.create(title: 'Marcos y Carolina',customer_id: 3, type_name:'wedding', number:'0000001', date: '10/08/2022', guests: 100,  employee_id: 1, place_id: 1, observations: 'evento creado con seeds')
      expect(envent.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Event: #{envent.title}"
    end
  end

  RSpec.describe InterviewOption, type: :model do
    it "Is a valid InterviewOption" do
      option = InterviewOption.create(id:1, gift: 'thing', song: 'all you need is test')
      expect(option.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> InterviewOption: #{option.gift}"
    end
  end

  RSpec.describe Interview, type: :model do
    it "Is a valid Interview" do

    end
  end

  RSpec.describe Location, type: :model do
    it "Is a valid Location" do
      loc = Location.create(name: 'Pazo de Sober', address:'', province: 'Ourense', coords: 'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d11773.328252979665!2d-7.5782942!3d42.4632258!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xef2b2a08af49abd1!2sEurostars%20Pazo%20de%20Sober!5e0!3m2!1ses!2ses!4v1633541381275!5m2!1ses!2ses')
      expect(loc.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Location: #{loc.name}"
    end
  end

  RSpec.describe MainService, type: :model do
    it "Is a valid MainService" do
      ms = MainService.create(name: 'Cabinas', description: 'Nuestras cabinas') 
      expect(ms.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> MainService: #{ms.name}"
    end
  end

  RSpec.describe Message, type: :model do
    it "Is a valid Message" do
      message = Message.create(body: 'Hola', conversation_id: 1, user_id: 1)
      expect(message.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Message: #{message.content}"
    end
  end

  RSpec.describe Service, type: :model do
    it "Is a valid Service" do
      service = Service.create(name: 'Gramola', price: 550.00, hour_price: 90.00, main_service_id: 1)
      expect(service.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Service: #{service.name}"
    end
  end

  RSpec.describe Tag, type: :model do
    it "Is a valid Tag" do
      tag = Tag.create(name: "Ruby")
      expect(tag.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> Tag: #{tag.name}"
    end
  end

  RSpec.describe User, type: :model do
    it "Is a valid user" do
      user = User.create(name: 'cisco', username: 'admin', email: 'creadix@creadix.com',phone: '+34625650792', password: 'test123', role: 'superadmin')
      expect(user.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> user: #{user.name}"
    end
  end

  RSpec.describe WebModule, type: :model do
    it "Is a valid WebModule" do

    end
  end
end
