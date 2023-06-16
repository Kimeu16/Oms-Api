puts "Seeding..."

admin1 = Admin.create(first_name: "Gideon", last_name: "Langat", email: "langat@gmail.com", password_digest: "", isadmin: true)

client1 = Client.create(name: "Maxxy", description: "Fully functional")

staff1 = Staff.create(name: "Kimeu", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideon98@gmail.com", password_digest: "", tech_stack: "React & Rails", isadmin: false, admin_id: admin1.id)

leave_form1 = LeaveForm.create(date_from: Date.today, date_to: Date.tomorrow, reason_for_leave: "On Leave period", leave_type: "special", staff_id: staff1.id)

project1 = Project.create(name: "Anthony", client_name: "Gideon", description: "Full Stack Project", action: "Not Paid")

task1 = Task.create(name: "Office System", assigned_to: "Anthony", managed_by: "Project Manager", project_id: project1.id)

timesheet1 = Timesheet.create(date: Date.today, start_time: Time.now, end_time: Time.now + 5.hours, progress_details: "In Progress", action: "Pending", task_id: task1.id)

leave_type1 = LeaveType.create(name: "Anthony Kimeu", days_allowed: "25")

puts "Done seeding!"
