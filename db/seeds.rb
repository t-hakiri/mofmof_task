Group.create!(name: "mofmof")

test_members = ["neko", "inu", "usagi"]
test_members.each do |member| 
  Member.create!(name: "#{member}")  
end
