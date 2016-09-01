require 'spec_helper'
require 'rspec'

describe "create a new todo and read it" do 
	
	it "create a new todo with empty title" do
	

	#create a todo post
	r = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query: {title: "aint having it!", due: "2016-9-1"})
		
	id = r["id"]

	#read a todo that was created
	d = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{id}")

	expect(id).to eq d["id"]

	#create a todo post with empty title; negative
	e_post = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query: {title: "", due: "2016-9-1"})

	#read a todo with wrong title
	e_id = e_post["id"]

	de = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{e_id}")

	expect(e_id).to eq de["id"]

	
	# update the title to the post that was created earlier
	p = HTTParty.patch("http://lacedeamon.spartaglobal.com/todos/7739", query: {title: "bags and boxes 2", due: "2016-9-1"})

	any_p = p["id"]

	pp = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{any_p}")

	expect(any_p).to eq pp["id"]  

	#update with incorrect id
	np = HTTParty.patch("http://lacedeamon.spartaglobal.com/todos/", query: {title: "negative patch test", due: "2016-9-1"})

	neg_p = np["id"]

	any_p_neg = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{neg_p}")

	expect(neg_p).to eq any_p_neg["id"]

	#Delete post
	delete_post = HTTParty.delete ("http://lacedeamon.spartaglobal.com/todos/7739")

	delete_post = delete_post["id"]

	#delete post; negative test with incorrect id
	del_neg_post = HTTPary.delete ("http://lacedeamon.spartaglobal.com/todos/100000")

	del_neg_id = del_neg_post["id"]

	end

end 
	