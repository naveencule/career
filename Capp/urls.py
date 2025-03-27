from django.urls import path
from Capp import views
urlpatterns = [

    path('',views.main ),
    path('login_post',views.login_post ),
    path('admin_home',views.admin_home ),
    path('add_company',views.add_company ),
    path('add_staff', views.add_staff),
    path('add_staff_action', views.add_staff_action),
    path('job_details_view', views.job_details_view),
    path('search_jdview', views.search_jdview),
    path('jobs_view', views.jobs_view),
    path('manage_company', views.manage_company),
    path('search_company', views.search_company),
    path('delete_company/<int:id>', views.delete_company),
    path('add_company_action', views.add_company_action),
    path('edit_company/<int:id>', views.edit_company),
    path('edit_company_action', views.edit_company_action),
    path('manage_staff', views.manage_staff),
    path('delete_staff/<int:id>', views.delete_staff),
    path('search_staff', views.search_staff),
    path('send_reply/<int:id>', views.send_reply),
    path('edit_staff/<int:id>', views.edit_staff),
    path('add_reply', views.add_reply),
    path('edit_staff_action', views.edit_staff_action),
    path('add_college', views.add_college),
    path('edit_college/<int:id>', views.edit_college),
    path('edit_college_action', views.edit_college_action),
    path('add_college_action', views.add_college_action),
    path('delete_college/<int:id>', views.delete_college),

    path('view_college', views.view_college),
    path('view_complaint', views.view_complaint),
    path('search_complaint', views.search_complaint),
    path('view_courses/<int:id>', views.view_courses),
    path('view_feedback', views.view_feedback),
    path('search_feedback', views.search_feedback),
    path('view_rating', views.view_rating),
    path('search_ratingst', views.search_ratingst ),
    path('view_vaccancy', views.view_vaccancy),
    path('logout', views.logout),


    # ///////////////////////////////admin///////////////////////////////////
    path('vacancy_add', views.vacancy_add),
    path('vacancy_add_action', views.vacancy_add_action),
    path('company_home', views.company_home),
    path('manage_job', views.manage_job),
    path('add_job', views.add_job),
    path('add_job_action', views.add_job_action),
    path('edit_job_action', views.edit_job_action),
    path('delete_job/<int:id>', views.delete_job),
    path('manage_vaccancy/<int:id>', views.manage_vaccancy),
    path('delete_vacancy/<int:id>', views.delete_vacancy),
    path('view_application', views.view_application),
    path('accept_application/<int:id>', views.accept_application),
    path('reject_application/<int:id>', views.reject_application),
    path('edit_job/<int:id>', views.edit_job),



    #//////////////////////////////////company//////////////////////////////


    path('add_college', views.add_college),
    path('add_college_action', views.add_college_action),
    path('add_course', views.add_course),
    path('add_course_action', views.add_course_action),
    path('edit_course/<int:id>', views.edit_course),
    path('delete_course/<int:id>', views.delete_course),
    path('edit_course_action', views.edit_course_action),
    path('enreply', views.enreply),
    path('add_notification', views.add_notification),
    path('add_notification_action', views.add_notification_action),
    path('college_management', views.college_management),
    path('search_college', views.search_college),
    path('course_management', views.course_management),
    path('search_course', views.search_course),
    path('enquiry', views.enquiry),
    path('search_enquiry', views.search_enquiry),
    path('send_replys/<int:id>', views.send_replys),
    path('staff_home', views.staff_home),
    path('staff_view_feedback', views.staff_view_feedback),
    path('staff_view_rating', views.staff_view_rating),
    path('search_rating', views.search_rating),
    path('admin_search_feedback', views.admin_search_feedback),





    path('logincode', views.logincode,name='logincode'),
    path('registration', views.registration,name='registration'),
    path('viewcollege', views.viewcollege,name='viewcollege'),
    path('viewcourses', views.viewcourses,name='viewcourses'),
    path('viewcompany', views.viewcompany,name='viewcompany'),
    path('viewjobs', views.viewjobs,name='viewjobs'),
    path('viewvaccancies', views.viewvaccancies,name='viewvaccancies'),
    path('viewenqreply', views.viewenqreply,name='viewenqreply'),
    path('stafflist', views.stafflist,name='stafflist'),
    path('enqadd', views.enqadd,name='enqadd'),
    path('andrating', views.andrating,name='andrating'),
    path('viewreply', views.viewreply,name='viewreply'),
    path('complaintadd', views.complaintadd,name='complaintadd'),
    path('uploadresume', views.uploadresume,name='uploadresume'),
    path('viewreccourses', views.viewreccourses,name='viewreccourses'),
    path('viewreccollege', views.viewreccollege,name='viewreccollege'),
    path('upldcv', views.upldcv,name='upldcv'),
    path('viewenoti', views.viewenoti,name='viewenoti'),
    path('profile', views.profile,name='profile'),
    path('appsts', views.appsts,name='appsts'),
    path('jobcheck', views.jobcheck,name='jobcheck'),
    path('forgot_password', views.forgot_password,name='forgot_password'),






]
    #//////////////////////////////////staff//////////////////////////////
