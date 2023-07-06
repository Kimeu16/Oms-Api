
puts "Seeding..."

admin1 = Admin.create(first_name: "Gideon", last_name: "Langat", email: "langat@gmail.com", password: "password", isadmin: true)

manager1 = Manager.create(first_name: "Anthony", last_name: "Kimeu", title: "CEO")

staff1 = Staff.create(staff_name: "Kimeu", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideon98@gmail.com", password: "password", tech_stack: "React & Rails", isStaff: true, admin_id: admin1, manager_id: manager1.id)

leave_form1 = Form.create(date_from: Date.today, date_to: Date.tomorrow, reason_for_leave: "On Leave period", leave_type: "Special", staff_id: staff1)

leave_type1 = LeaveType.create(your_name: "Anthony Kimeu", days_allowed: 25, staff_id: staff1)

client1 = Client.create(client_name: "Maxxy", description: "Fully functional")

project1 = Project.create(project_name: "Anthony", description: "Full Stack Project", client_details: "bla bla bla")

task1 = Task.create(task_name: "Office System", assigned_to: "Anthony", managed_by: "Project Manager", project_id: project1)

timesheet1 = Timesheet.create(date: Date.today, start_time: Time.now, end_time: Time.now + 5.hours, progress_details: "In Progress", task_id: task1)

puts "Done seeding!"
