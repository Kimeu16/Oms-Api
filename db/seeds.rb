puts "seeding"
client1 = Client.create(name: "Maxxy", description: "Fully functional")
staff1 = Staff.create(name: "Kimeu", joining_date: Date.tomorrow, reporting_to: "CEO", tech_stack: "React $ Rails")
leave_form1 = LeaveForm.create(staff_id: staff1.id, date_from: Date.today, date_to: Date.tomorrow, reason_for_leave: "On Leave period", leave_type: "special")
leave_type1 = LeaveType.create(name: "Anthony Kimeu", days_allowed: "25")
project1 = Project.create(name: "Anthony", client_name: "Gideon", description: "Full Stack Project", action: "Not Paid")
task1 = Task.create(project_id: project1.id, name: "Office System", assigned_to: "Anthony", managed_by: "Project Manager")
timesheet1 = Timesheet.create(date: Date.today, start_time: Time.now, end_time: Time.now + 5.hours, task_id: task1.id, progress_details: "In Progress", action: "Pending")
puts "Done seeding!"
