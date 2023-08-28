puts "Seeding..."

admin1 = Admin.create(first_name: "Tonnie", last_name: "Kimeu", email: "tkymeu@gmail.com", password: "12345678", isadmin: true)

manager1 = Manager.create(first_name: "Kimani", last_name: "Kim", title: "CEO")

staff1 = Staff.create(staff_name: "Kimeu", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideon98@gmail.com", password: "password", designation: "React & Rails", isStaff: true, admin_id: admin1.id, manager_id: manager1.id)

leave_form1 = Form.create(your_name: "Ogidy", date_from: Date.today, date_to: Date.tomorrow, days_applied: 10, leaving_type: "Special", reason_for_leave: "On Leave period", status: "pending", staff_id: staff1.id)

leave_type1 = LeaveType.create(leave_reason: "Anthony Kimeu", days_allowed: 25, staff_id: staff1.id)

leave_calculation1 = LeaveCalculation.create(staff_details: "Anthony Kimeu", type_of_leave: "sick", total_days: 20, used_days: 10, available_days: 10, leave_type_id: leave_type1.id, staff_id: staff1.id)

client1 = Client.create(client_name: "Maxxy", description: "Fully functional")

article1 = CompanyArticle.create(title: "ISO CERTIFIED", date: Date.today, content: "We are now ISO certified", staff_id: staff1.id)

project1 = Project.create(project_name: "Anthony", description: "Full Stack Project", client_details: "bla bla bla")

task1 = Task.create(task_name: "Office System", assigned_to: "Anthony", managed_by: "Project Manager", project_name: "Oms", task_deadline:"Three Weeks", avatar_image: "", completed_files: "", project_id: project1.id, staff_id: staff1.id)

timesheet1 = Timesheet.create(date: Date.today, start_time: Time.now, end_time: Time.now, task_id: task1.id, task_detail: "Oms", progress_details: "Completed task", time_limit: " Three Weeks", staff_id: staff1.id)

profile1 = Profile.create(bio: "Software Engineer # FullStack Engineer", avatar: "", about:"", location:"", bio_name: "", my_email: "", tech: "", staff_id: staff1.id)

check_in1 = staff1.check_ins.create(check_in_at: 2.hours.ago, check_out_at: 1.hour.ago)
puts "Done seeding!"
