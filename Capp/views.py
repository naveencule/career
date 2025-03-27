import smtplib
from datetime import datetime

import math
from email.mime.text import MIMEText

from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

from Capp.knn import predict
# from .knn import predict

from .sampleee import pdf_reader
# Create your views here.
from Capp.models import *


def main(request):
    return render(request,"index.html")

def logout(request):
    auth.logout(request)
    return render(request,'index.html')

def login_post(request):
    username = request.POST['textfield']
    password = request.POST['textfield2']
    try:
        login_obj = Login.objects.get(Username=username, Password=password)
        if login_obj.Type == "admin":
            ob=auth.authenticate(username="admin",password="12345")
            if ob is not None:
                auth.login(request,ob)

            return HttpResponse('''<script> alert("welcome"); window.location="admin_home"</script>''')
        elif login_obj.Type =="company":
            request.session['lid']=login_obj.id
            ob = auth.authenticate(username="admin", password="12345")
            if ob is not None:
                auth.login(request, ob)
            return HttpResponse('''<script> alert("welcome"); window.location="company_home"</script>''')
        elif login_obj.Type =="staff":
            request.session['lid'] = login_obj.id
            ob = auth.authenticate(username="admin", password="12345")
            if ob is not None:
                auth.login(request, ob)
            return HttpResponse('''<script> alert("welcome"); window.location="staff_home"</script>''')
        else:
            return HttpResponse('''<script> alert("Invalid username or password"); window.location="/"</script>''')


    except:
        return HttpResponse('''<script> alert("Invalid username or password"); window.location="/"</script>''')


# ///////////////////////////////////////////admin/////////////////////////

#@login_required(login_url='/')
def admin_home(request):
    return render(request, "adminindex.html")
#@login_required(login_url='/')

def add_company(request):
    return render(request,"admin/add company.html")
#@login_required(login_url='/')

def edit_company(request,id):
    request.session['lid']=id
    ob=Company.objects.get(id=id)
    return render(request,"admin/edit company.html",{"v":ob})
#@login_required(login_url='/')

def add_staff(request):
    return render(request,"admin/add staff.html")
#@login_required(login_url='/')

def edit_staff(request,id):
    request.session['sid']=id
    ob=Staff.objects.get(id=id)
    return render(request,"admin/edit staff.html",{"v":ob})
#@login_required(login_url='/')

def add_staff_action(request):
    first_name = request.POST['textfield10']
    last_name = request.POST['textfield9']
    place =request.POST['textfield8']
    post =request.POST['textfield7']
    pin =request.POST['textfield6']
    phone =request.POST['textfield5']
    Email =request.POST['textfield4']
    photo =request.FILES['file']
    fss = FileSystemStorage()
    photo_file = fss.save(photo.name, photo)
    username =request.POST['textfield2']
    password =request.POST['textfield']

    login_obj = Login()
    login_obj.Username = username
    login_obj.Password = password
    login_obj.Type = "staff"
    login_obj.save()

    staff_obj = Staff()
    staff_obj.fname =first_name
    staff_obj.lname =last_name
    staff_obj.place =place
    staff_obj.post =post
    staff_obj.pin =pin
    staff_obj.phone =phone
    staff_obj.image =photo_file
    staff_obj.email =Email
    staff_obj.LOGIN = login_obj
    staff_obj.save()
    return HttpResponse('''<script> alert("Added staff succesfully"); window.location="/manage_staff#about"</script>''')
#@login_required(login_url='/')

def edit_staff_action(request):
    first_name = request.POST['textfield10']
    last_name = request.POST['textfield9']
    place =request.POST['textfield8']
    post =request.POST['textfield7']
    pin =request.POST['textfield6']
    phone =request.POST['textfield5']
    Email =request.POST['textfield4']


    staff_obj = Staff.objects.get(id=request.session['sid'])
    staff_obj.fname =first_name
    staff_obj.lname =last_name
    staff_obj.place =place
    staff_obj.post =post
    staff_obj.pin =pin
    staff_obj.phone =phone
    try:
        photo = request.FILES['file']
        fss = FileSystemStorage()
        photo_file = fss.save(photo.name, photo)
        staff_obj.image =photo_file
    except:
        pass

    staff_obj.email =Email

    staff_obj.save()
    return HttpResponse('''<script> alert("Updated staff succesfully"); window.location="/manage_staff#about"</script>''')
#@login_required(login_url='/')

def job_details_view (request):
    job_obj=Job_and_vacancy.objects.all()
    return render(request,"admin/job details view.html",{'val':job_obj})
#@login_required(login_url='/')
def search_jdview(request):
    name = request.POST['textfield']
    job_obj = Job_and_vacancy.objects.filter(name__icontains=name)
    return render(request, "admin/job details view.html", {'val': job_obj,'nm':name})
#@login_required(login_url='/')

def jobs_view(request):
    return render(request,"admin/jobs view.html")
#@login_required(login_url='/')
def manage_company(request):
    com_obj =Company.objects.all()
    return render(request, "admin/manage company.html",{'val':com_obj})
#@login_required(login_url='/')
def delete_company(request,id):
    ob= Login.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("Succesfully Deleted"); window.location="/manage_company#about"</script>''')

#@login_required(login_url='/')

def search_company(request):
    name = request.POST['textfield']
    com_obj = Company.objects.filter(cname__icontains=name)
    return render(request, "admin/manage company.html",{'val':com_obj,"nm":name})


#@login_required(login_url='/')
def add_company_action(request):
    name =request.POST['textfield']
    place =request.POST['textfield2']
    post =request.POST['textfield4']
    pin =request.POST['textfield5']
    phone =request.POST['textfield6']
    email =request.POST['textfield7']
    photo = request.FILES['file']
    fsc = FileSystemStorage()
    photo_file = fsc.save(photo.name, photo)
    username =request.POST['textfield8']
    password = request.POST['textfield9']

    login_obj = Login()
    login_obj.Username = username
    login_obj.Password = password
    login_obj.Type = "company"
    login_obj.save()

    company_obj = Company()
    company_obj.cname = name
    company_obj.place = place
    company_obj.post = post
    company_obj.pin = pin
    company_obj.phone = phone
    company_obj.image = photo_file
    company_obj.email = email
    company_obj.LOGIN = login_obj
    company_obj.save()
    return HttpResponse('''<script> alert("Succesfully Added"); window.location="manage_company#about"</script>''')
#@login_required(login_url='/')

def edit_company_action(request):
    name =request.POST['textfield']
    place =request.POST['textfield2']
    post =request.POST['textfield4']
    pin =request.POST['textfield5']
    phone =request.POST['textfield6']
    email =request.POST['textfield7']

    company_obj = Company.objects.get(id=request.session['lid'])
    company_obj.cname = name
    company_obj.place = place
    company_obj.post = post
    company_obj.pin = pin
    company_obj.phone = phone
    company_obj.email = email
    try:
        photo = request.FILES['file']
        fsc = FileSystemStorage()
        photo_file = fsc.save(photo.name, photo)
        company_obj.image = photo_file
    except:
        pass

    company_obj.save()
    return HttpResponse('''<script> alert("Updated"); window.location="manage_company#about"</script>''')
#@login_required(login_url='/')

def manage_staff(request):
    staff_obj = Staff.objects.all()
    return render(request,"admin/manage staff.html", {'staff_obj': staff_obj})
#@login_required(login_url='/')
def delete_staff(request,id):
    ob=Login.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("Deleted staff succesfully"); window.location="/manage_staff#about"</script>''')
#@login_required(login_url='/')
def search_staff(request):
    name = request.POST['a']
    staff_obj = Staff.objects.filter(fname__icontains=name)
    return render(request,"admin/manage staff.html", {'staff_obj': staff_obj,'nm':name})


#@login_required(login_url='/')

def send_reply(request,id):
    request.session['cid']=id
    return render(request,"admin/send reply.html")
#@login_required(login_url='/')
def add_reply(request):
    rply=request.POST['textfield']
    ob=Complaint.objects.get(id=request.session['cid'])
    ob.reply=rply
    ob.save()
    return HttpResponse('''<script> alert("Replied"); window.location="view_complaint#about"</script>''')


#@login_required(login_url='/')

def view_college(request):
    view_obj = College.objects.all()
    return render(request,"admin/view college.html",{'col':view_obj})
#@login_required(login_url='/')
def view_complaint(request):
    view_comp =Complaint.objects.all()
    return render(request,"admin/view complaint.html",{'comp':view_comp})
#@login_required(login_url='/')
def search_complaint(request):
    date=request.POST['textfield']
    view_comp=Complaint.objects.filter(date=date)
    return render(request, "admin/view complaint.html", {'comp': view_comp,'dt':str(date)})


#@login_required(login_url='/')
def view_courses(request,id):
    view_course= Course.objects.filter(COLLEGE__id=id)
    return render(request,"admin/view courses.html",{'val':view_course})
#@login_required(login_url='/')
def view_feedback(request):
    feed_obj=Feedback_and_rating.objects.all()
    return render(request,"admin/view feedback.html",{'val3':feed_obj})
#@login_required(login_url='/')
def admin_search_feedback(request):
    date=request.POST['textfield']
    feed_obj = Feedback_and_rating.objects.filter(date=date)
    return render(request, "admin/view feedback.html", {'val3': feed_obj,"dt":str(date)})
#@login_required(login_url='/')
def view_rating(request):
    rating_obj=Feedback_and_rating.objects.all()
    return render(request, "admin/view rating.html",{'val2':rating_obj})
#@login_required(login_url='/')

def search_rating(request):
    date = request.POST['textfield']
    rating_obj = Feedback_and_rating.objects.filter(date=date)
    return render(request, "admin/view rating.html", {'val2': rating_obj,'dt':str(date)})
#@login_required(login_url='/')


def view_vaccancy(request):
    return render(request, "admin/view vaccancy.html")




# ///////////////////////////////////////////company/////////////////////////

#@login_required(login_url='/')
def vacancy_add(request):
    return render(request, "Company/add.html")

#@login_required(login_url='/')
def  vacancy_add_action(request):
     name = request.POST['textfield']
     details = request.POST['textfield2']
     no_of_vaccancy= request.POST['textfield4']
     last_date= request.POST['textfield5']

     vac_obj=Job_and_vacancy()
     vac_obj.name=name
     vac_obj.details=details
     vac_obj.no_of_vaccancy=no_of_vaccancy
     vac_obj.date=last_date
     return HttpResponse('''<script> alert("added vaccancy succesfully"); window.location="manage_vaccancy#about"</script>''')

#@login_required(login_url='/')
def view_vacancy(request):
    view_obj = Job_and_vacancy.objects.all()
    return render(request, "admin/view vaccancy.html",{'val':view_obj})

#@login_required(login_url='/')
def company_home(request):
    return render(request, "companyindex.html")
#@login_required(login_url='/')
def manage_job(request):
    obj=Job_and_vacancy.objects.filter(COMPANY__LOGIN__id=request.session['lid'])
    return render(request, "Company/manage job.html",{'val':obj})

#@login_required(login_url='/')

def add_job(request):
    return render(request, "Company/addjobandvc.html")
#@login_required(login_url='/')
def edit_job(request,id):
    ob=Job_and_vacancy.objects.get(id=id)
    request.session['sid']=ob.id
    return render(request,"Company/editjobandvc.html",{"val":ob,"date":str(ob.last_date)})

#@login_required(login_url='/')
def add_job_action(request):
    name =request.POST['textfield']
    details =request.POST['textfield2']
    qualification =request.POST['textfield4']
    last_date=request.POST['textfield5']
    no_of_vaccancy = request.POST['textfield6']

    job_obj = Job_and_vacancy()
    job_obj.name = name
    job_obj.details = details
    job_obj.qualification = qualification
    job_obj.last_date = last_date
    job_obj.no_of_vaccancy = no_of_vaccancy

    job_obj.COMPANY=Company.objects.get(LOGIN__id=request.session['lid'])
    job_obj.save()
    return HttpResponse('''<script> alert("Succesfully Added"); window.location="manage_job#about"</script>''')
#@login_required(login_url='/')




def edit_job_action(request):
    name =request.POST['textfield']
    details =request.POST['textfield2']
    qualification =request.POST['textfield4']
    last_date=request.POST['textfield5']
    no_of_vaccancy = request.POST['textfield6']

    job_obj = Job_and_vacancy.objects.get(id=request.session['sid'])
    job_obj.name = name
    job_obj.details = details
    job_obj.qualification = qualification
    job_obj.last_date = last_date
    job_obj.no_of_vaccancy = no_of_vaccancy

    job_obj.COMPANY=Company.objects.get(LOGIN__id=request.session['lid'])
    job_obj.save()
    return HttpResponse('''<script> alert("Edited"); window.location="manage_job#about"</script>''')


#@login_required(login_url='/')

def delete_job(request,id):
    ob=Job_and_vacancy.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("Deleted"); window.location="/manage_job#about"</script>''')



#@login_required(login_url='/')
def manage_vaccancy(request,id):
    ob=Job_and_vacancy.objects.filter(COMPANY__LOGIN__id=request.session['lid'])
    return render(request, "Company/vaccancy add.html",{'val':ob})
#@login_required(login_url='/')

def delete_vacancy(request,id):
    ob=Job_and_vacancy.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("deleted vacancy succesfully"); window.location="/manage_vaccancy#about"</script>''')
#@login_required(login_url='/')


def view_application(request):
    view_obj = Resume.objects.filter(APPLICATION__VACCANCY__COMPANY__LOGIN__id=request.session['lid']).order_by('score')
    for i in view_obj:
        i.score=str(i.score).split('.')[0]
    return render(request, "Company/view application.html",{'val':view_obj})

#@login_required(login_url='/')
def accept_application(request,id):
    view_obj = Application.objects.get(id=id)
    view_obj.status='accepted'
    view_obj.save()
    return HttpResponse( '''<script> alert("Accepted"); window.location="/view_application#about"</script>''')

#@login_required(login_url='/')
def reject_application(request,id):
    view_obj = Application.objects.get(id=id)
    view_obj.status='rejected'
    view_obj.save()
    return HttpResponse( '''<script> alert("Rejected"); window.location="/view_application#about"</script>''')


#///////////////////////////////////////staff///////////////////////


#@login_required(login_url='/')
def add_college(request):
    return render(request, "staff/add college.html")
#@login_required(login_url='/')

def edit_college(request,id):
    ob=College.objects.get(id=id)
    request.session['coid'] = id
    return render(request,"staff/edit college.html", {"v":ob})

#@login_required(login_url='/')
def add_college_action(request):
    name = request.POST['textfield']
    image1 = request.FILES['image']
    fss = FileSystemStorage()
    image_file = fss.save(image1.name, image1)
    place = request.POST['textfield4']
    post = request.POST['textfield5']
    pin = request.POST['textfield6']
    phone = request.POST['textfield7']
    email = request.POST['textfield10']
    clg_obj = College()
    clg_obj.name = name
    clg_obj.image = image_file
    clg_obj.place = place
    clg_obj.STAFF=Staff.objects.get(LOGIN__id=request.session['lid'])
    clg_obj.post= post
    clg_obj.pin=pin
    clg_obj.phone=phone
    clg_obj.email=email
    clg_obj.save()
    return HttpResponse('''<script> alert("College Added Succesfully"); window.location="college_management#about"</script>''')
#@login_required(login_url='/')

def edit_college_action(request):
    name = request.POST['textfield']

    place = request.POST['textfield4']
    post = request.POST['textfield5']
    pin = request.POST['textfield6']
    phone = request.POST['textfield7']
    email = request.POST['textfield10']
    clg_obj = College.objects.get(id=request.session['coid'])
    clg_obj.name = name

    clg_obj.place = place
    clg_obj.post= post
    clg_obj.pin=pin
    clg_obj.phone=phone
    clg_obj.email=email
    try:
        image1 = request.FILES['image']

        fss = FileSystemStorage()
        image_file = fss.save(image1.name, image1)
        clg_obj.image = image_file
    except:
        pass
    clg_obj.save()
    return HttpResponse('''<script> alert("Updated"); window.location="college_management#about"</script>''')
#@login_required(login_url='/')

def delete_college(request,id):
    ob= College.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("Deleted"); window.location="/college_management#about"</script>''')
#@login_required(login_url='/')


def add_course(request):
    object=College.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    return render(request, "staff/add course.html",{'val':object})
#@login_required(login_url='/')
def add_course_action(request):
    name = request.POST['select']
    courses = request.POST['textfield2']
    details = request.POST['textfield3']
    area=request.POST['select1']

    cou_obj=Course()
    cou_obj.name=courses
    cou_obj.date=datetime.today()
    cou_obj.details=details
    cou_obj.COLLEGE=College.objects.get(id=name)
    cou_obj.area=area
    cou_obj.save()
    return HttpResponse('''<script> alert("Added"); window.location="course_management#about"</script>''')

#@login_required(login_url='/')
def edit_course(request,id):
    ob=Course.objects.get(id=id)
    object = College.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    request.session['ld'] = ob.id
    return render(request,"staff/edit course.html", {"v":ob ,'val':object,'ids':int(ob.COLLEGE.id),'area':str(ob.area)})

#@login_required(login_url='/')
def edit_course_action(request):
    name = request.POST['select']
    courses = request.POST['textfield2']
    details = request.POST['textfield23']
    area = request.POST['select1']
    cou_obj = Course.objects.get(id=request.session['ld'])
    cou_obj.COLLEGE=College.objects.get(id=name)
    cou_obj.name=courses
    cou_obj.date=datetime.today()
    cou_obj.details=details
    cou_obj.area=area
    cou_obj.save()
    return HttpResponse('''<script> alert("updated course succesfully"); window.location="course_management#about"</script>''')
#@login_required(login_url='/')

def delete_course(request,id):
    ob= Course.objects.get(id=id)
    ob.delete()
    return HttpResponse('''<script> alert("Deleted"); window.location="/course_management#about"</script>''')



#@login_required(login_url='/')

def add_notification(request):
    return render(request, "staff/add notification.html")

#@login_required(login_url='/')
def add_notification_action(request):
    notification = request.POST['textfield']

    cou_obj = Notification()
    cou_obj.notification=notification
    cou_obj.date = datetime.today()
    cou_obj.STAFF=Staff.objects.get(LOGIN__id=request.session['lid'])
    cou_obj.save()

    return HttpResponse('''<script> alert("Notification Added"); window.location="/staff_home#about"</script>''')



#@login_required(login_url='/')

def college_management(request):
    object=College.objects.filter(STAFF__LOGIN__id=request.session['lid'])

    return render(request, "staff/college management.html",{'val':object})

#@login_required(login_url='/')
def search_college(request):
     name=request.POST['textfield']
     object = College.objects.filter(STAFF__LOGIN__id=request.session['lid'],name__icontains=name)
     return render(request, "staff/college management.html", {'val': object,"nm":name})

#@login_required(login_url='/')



def course_management(request):
    object = Course.objects.filter(COLLEGE__STAFF__LOGIN__id=request.session['lid'])
    return render(request, "staff/course management.html",{"val":object})


#@login_required(login_url='/')

def search_course(request):
    name = request.POST['textfield']
    object = Course.objects.filter(COLLEGE__STAFF__LOGIN__id=request.session['lid'],COLLEGE__name__istartswith=name)
    return render(request, "staff/course management.html", {"val": object,'nm':name})
#@login_required(login_url='/')
def enquiry(request):
    object = Enquiry.objects.all().order_by('-id')
    return render(request, "staff/enquiry.html",{"val":object})
#@login_required(login_url='/')

def search_enquiry(request):
    date=request.POST['textfield']
    object = Enquiry.objects.filter(date=date)
    return render(request, "staff/enquiry.html", {"val": object,'dt':str(date)})
#@login_required(login_url='/')

def send_replys(request,id):
    request.session['eid']=id
    return render(request, "staff/send reply.html")
#@login_required(login_url='/')
def enreply(request):
    rep=request.POST['textfield']
    ob=Enquiry.objects.get(id=request.session['eid'])
    ob.reply=rep
    ob.save()
    return HttpResponse('''<script> alert("Replied"); window.location="enquiry#about"</script>''')




#@login_required(login_url='/')

def staff_home(request):
    return render(request, "staffindex.html")
#@login_required(login_url='/')
def staff_view_feedback(request):
    object = Feedback_and_rating.objects.all()
    return render(request, "staff/view feedback.html",{"val":object})

#@login_required(login_url='/')
def staff_view_rating(request):
    ob= Feedback_and_rating.objects.all()
    return render(request, "staff/view rating.html",{'val':ob})
#@login_required(login_url='/')
def search_ratingst(request):
    date=request.POST['textfield']
    ob = Feedback_and_rating.objects.filter(date=date)
    return render(request, "staff/view rating.html", {'val': ob,'dt':str(date)})

#@login_required(login_url='/')

    # view_ob=Enquiry.objects.filter(date=date)
    # return render(request, "staff/view rating.html", {'val': view_ob})


def search_feedback(request):
    date=request.POST['textfield']
    object = Feedback_and_rating.objects.filter(date=date)
    return render(request, "staff/view feedback.html", {"val": object,'dt':str(date)})

    # view_ob=Enquiry.objects.filter(date=date)
    # return render(request, "staff/view feedback.html", {'val': view_ob,'dt':str(date)})







"??????????????????????????????????WEBSERVICE????????????????????????????????????????????????????"


from django.core import serializers
import json
from django.http import JsonResponse

def logincode(request):
     print(request.POST)
     un=request.POST['username']
     pwd=request.POST['password']
     print(un,pwd,"=======")
     try:
         users = Login.objects.get(Username=un,Password=pwd,Type='student')
         print("jjjjjjjj")
         return JsonResponse({'task':'ok',"lid":users.id})
     except:
         print("kkkkkkk")
         return JsonResponse({"task": "invalid"})



def registration(request):
    print(request.POST)
    Fname=request.POST['fname']
    Lname=request.POST['lname']
    image=request.POST['file']

    import base64

    timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
    print(timestr)
    a = base64.b64decode(image)
    # fh = open( r"C:/Users/anton/Desktop/PROJECT FINAL/Career_Guidance_project\media\\" + timestr + ".jpg", "wb")
    fh = open( r"D:\Career_Guidance_project\media\\" + timestr + ".jpg", "wb")

    path = timestr + ".jpg"
    fh.write(a)
    fh.close()

    place= request.POST['place']
    post_office = request.POST['post']
    pin_code = request.POST['pin']
    phone = request.POST['phone']
    email_id = request.POST['email']
    uname = request.POST['username']
    passwd = request.POST['password']
    lob = Login()
    lob.Username = uname
    lob.Password = passwd
    lob.Type = 'student'
    lob.save()
    userob = Student()
    userob.fname = Fname
    userob.lname = Lname
    userob.place = place
    userob.post = post_office
    userob.pin = pin_code
    userob.phone = phone
    userob.email = email_id
    userob.image = path
    userob.LOGIN=lob
    userob.save()
    return JsonResponse({'task': 'ok'})


def viewcollege(request):
    ob=College.objects.all().order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'name':i.name,'place':i.place,'post':i.post,'pin':i.pin,'phone':i.phone,'email':i.email,'image':i.image.url[1:],'id':i.id}
        mdata.append(data)
        print(mdata)

    return JsonResponse({"status":"ok","data":mdata})


def viewcourses(request):
    cid=request.POST['cid']
    ob=Course.objects.filter(COLLEGE__id=cid).order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'name':i.name,'details':i.details,'date':i.date,'id':i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status":"ok","data":mdata})


def viewcompany(request):
    ob=Company.objects.all().order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'name':i.cname,'place':i.place,'post':i.post,'pin':i.pin,'phone':i.phone,'email':i.email,'image':i.image.url[1:],'id':i.id}
        mdata.append(data)
        print(mdata)

    return JsonResponse({"status":"ok","data":mdata})


def viewjobs(request):
    cid=request.POST['cid']
    ob=Job_and_vacancy.objects.filter(COMPANY__id=cid).order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'name':i.name,'details':i.details,'date':i.last_date,'qualification':i.qualification,'no':i.no_of_vaccancy,'id':i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status":"ok","data":mdata})


def viewvaccancies(request):
    cid=request.POST['cid']
    ob=Job_and_vacancy.objects.filter(JOB__id=cid).order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'name':i.type,'details':i.details,'date':i.date,'id':i.id,'noofvaccancy':i.no_of_vaccancy}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status":"ok","data":mdata})


def viewenqreply(request):
    cid=request.POST['lid']
    ob=Enquiry.objects.filter(STUDENT__LOGIN__id=cid).order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'enquiry':i.enquiries,'reply':i.reply,'date':i.date,'id':i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status":"ok","data":mdata})

def stafflist(request):
    ob = Staff.objects.all()
    print(ob, "HHHHHHHHHHHHHHH")
    mdata = []
    for i in ob:
        data = {'name': i.fname+" "+i.lname,'id': i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status": "ok", "data": mdata})


def enqadd(request):
    try:
        enq=request.POST['enquiry']
        lid=request.POST['lid']
        lob=Enquiry()
        lob.enquiries = enq
        lob.reply = 'pending'
        lob.date=datetime.now().date()
        lob.STUDENT=Student.objects.get(LOGIN__id=lid)
        lob.save()
        return JsonResponse({'task': 'ok'})
    except Exception as e:
        print(e)
        return JsonResponse({"task": "invalid"})


def andrating(request):
    try:
        feed=request.POST['review']
        rate=request.POST['rating']
        lid=request.POST['lid']

        lob=Feedback_and_rating()
        lob.rate = rate
        lob.feedback = feed
        lob.date=datetime.now().date()
        lob.STUDENT=Student.objects.get(LOGIN__id=lid)
        lob.save()
        return JsonResponse({'task': 'ok'})
    except Exception as e:
         print(e)
         return JsonResponse({"task": "invalid"})


def viewreply(request):
    cid=request.POST['lid']
    ob=Complaint.objects.filter(STUDENT__LOGIN__id=cid).order_by('-id')
    print(ob,"HHHHHHHHHHHHHHH")
    mdata=[]
    for i in ob:
        data={'complaint':i.complaint,'reply':i.reply,'date':i.date,'id':i.id}
        mdata.append(data)
        print(mdata)
    return JsonResponse({"status":"ok","data":mdata})


def complaintadd(request):
    try:
        complaints=request.POST['complaint']
        lid=request.POST['lid']
        lob=Complaint()
        lob.complaint = complaints
        lob.reply = 'pending'
        lob.date=datetime.now().date()
        lob.STUDENT=Student.objects.get(LOGIN__id=lid)
        lob.save()
        return JsonResponse({'task': 'ok'})
    except:
         return JsonResponse({"task": "invalid"})



def viewreccourses(request):
    course=request.POST['course']
    if course == "Social":
        ob=Course.objects.filter(area="Social Science, Law")
        print(ob,"HHHHHHHHHHHHHHH")
        mdata=[]
        for i in ob:
            data={'name':i.name,'details':i.details,'college':i.COLLEGE.name,'id':i.COLLEGE.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status":"ok","data":mdata})
    elif course == "Computer":
        ob=Course.objects.filter(area="Science & Technology")
        print(ob,"HHHHHHHHHHHHHHH")
        mdata=[]
        for i in ob:
            data={'name':i.name,'details':i.details,'college':i.COLLEGE.name,'id':i.COLLEGE.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status":"ok","data":mdata})
    elif course == "Medicine":
        ob=Course.objects.filter(area="Medical Science")
        print(ob,"HHHHHHHHHHHHHHH")
        mdata=[]
        for i in ob:
            data={'name':i.name,'details':i.details,'college':i.COLLEGE.name,'id':i.COLLEGE.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status":"ok","data":mdata})
    elif course == "Commerce":
        ob=Course.objects.filter(area="Commerce")
        print(ob,"HHHHHHHHHHHHHHH")
        mdata=[]
        for i in ob:
            data={'name':i.name,'details':i.details,'college':i.COLLEGE.name,'id':i.COLLEGE.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status":"ok","data":mdata})
    elif course == "Literature":
        ob=Course.objects.filter(area="Literature")
        print(ob,"HHHHHHHHHHHHHHH")
        mdata=[]
        for i in ob:
            data={'name':i.name,'details':i.details,'college':i.COLLEGE.name,'id':i.COLLEGE.id}
            mdata.append(data)
            print(mdata)
        return JsonResponse({"status":"ok","data":mdata})
    else:
        return JsonResponse({"status":"invalid"})



def viewreccollege(request):
    cid=request.POST['clgid']
    ob=College.objects.get(id=cid)
    data={'name':ob.name,'place':ob.place,'post':ob.post,'pin':ob.pin,'phone':ob.phone,'email':ob.email,'image':ob.image.url[1:],'id':ob.id}
    print(data)
    return JsonResponse({"status":"ok","data":data})

"???????????????????????????????????Score Generation??????????????????????????????????"

import re
WORD = re.compile(r'\w+')
from collections import Counter
def text_to_vector(text):
    words = WORD.findall(text)
    return Counter(words)

def get_cosine(vec1, vec2):
    intersection = set(vec1.keys()) & set(vec2.keys())
    numerator = sum([vec1[x] * vec2[x] for x in intersection])
    sum1 = sum([vec1[x] ** 2 for x in vec1.keys()])
    sum2 = sum([vec2[x] ** 2 for x in vec2.keys()])
    denominator = math.sqrt(sum1) * math.sqrt(sum2)
    if not denominator:
        return 0.0
    else:
        return float(numerator) / denominator

def uploadresume(request):
    from Capp.sampleee import pdf_reader
    lid = request.POST['lid']
    vid = request.POST['vid']
    resu = request.POST['file']
    ob = Application()
    ob.STUDENT = Student.objects.get(LOGIN__id=lid)
    ob.VACCANCY = Job_and_vacancy.objects.get(id=vid)
    ob.date = datetime.today()
    ob.status = "pending"
    ob.save()
    import base64
    timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
    print(timestr)
    a = base64.b64decode(resu)
    # fh = open(r"C:/Users/anton/Desktop/PROJECT FINAL/Career_Guidance_project\media\\" + timestr + ".pdf", "wb")
    fh = open(r"D:\Career_Guidance_project\media\\" + timestr + ".pdf", "wb")

    path =timestr + ".pdf"
    fh.write(a)
    fh.close()
    # text=pdf_reader(r"C:/Users/anton/Desktop/PROJECT FINAL/Career_Guidance_project\media\\" + timestr + ".pdf")
    text=pdf_reader(r"D:\Career_Guidance_project\media\\" + timestr + ".pdf")
    vec1=text_to_vector(text)
    vec2=text_to_vector(ob.VACCANCY.qualification)
    print("+++++++++++++++++++++++++++")
    print(vec2)
    print("+++++++++++++++++++++++++++")

    sim=get_cosine(vec1,vec2)
    oj=Resume()
    oj.APPLICATION=ob
    oj.score=sim*100
    oj.date=datetime.today()
    oj.resume=path
    oj.save()
    return JsonResponse({"task": "ok"})

# "?????????????????????????????????????????????????????????????????????????????????????"

def read_pdf(file_path):
    import PyPDF2
    with open(file_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        num_pages = len(reader.pages)
        txt=""
        for page_number in range(num_pages):
            page = reader.pages[page_number]
            text = page.extract_text()
            txt=txt+text+" "
        return txt

def upldcv(request):
    cv=request.POST['file']
    import base64
    timestr = datetime.now().strftime("%Y%m%d-%H%M%S")
    print(timestr)
    a = base64.b64decode(cv)
    # fh = open(r"C:/Users/anton/Desktop/PROJECT FINAL/Career_Guidance_project\media\\" + timestr + ".pdf", "wb")
    fh = open(r"D:\Career_Guidance_project\media\\" + timestr + ".pdf", "wb")
    path = timestr + ".pdf"
    fh.write(a)
    fh.close()
    # fn=FileSystemStorage()
    # fs=fn.save(cv.name,cv)
    save_image_path = './media/' + path
    resume_text = read_pdf(save_image_path).lower()
    print(resume_text)
    res = predict(resume_text)
    print(res,"=================================================")

    data = {"task": "ok","res":res}
    r = json.dumps(data)
    return HttpResponse(r)

def viewenoti(request):
    list=[]
    ob=Notification.objects.all().order_by('-id')
    for i in ob:
        row={'noti':i.notification,'staff':i.STAFF.fname+" "+i.STAFF.lname,'date':str(i.date)}
        list.append(row)
    return JsonResponse({'data':list})


def profile(request):
    lid=request.POST['lid']
    ob=Student.objects.get(LOGIN__id=lid)
    data={"name":ob.fname+" "+ob.lname,'phone':str(ob.phone),'email':ob.email,'address':ob.place+" "+ob.post+" "+str(ob.pin),'photo':ob.image.url}
    print(data)
    return JsonResponse(data)


def appsts(request):
    lid=request.POST['lid']
    ob=Application.objects.filter(STUDENT__LOGIN__id=lid).order_by('id')
    list=[]
    for i in ob:
        row={'company':i.VACCANCY.COMPANY.cname,'position':i.VACCANCY.name,'date':str(i.date),'status':i.status}
        list.append(row)
    print(list)
    return JsonResponse({'data':list})

def jobcheck(request):
    lid=request.POST['lid']
    jid=request.POST['jid']
    ob=Application.objects.filter(STUDENT__LOGIN__id=lid,VACCANCY__id=jid)
    if len(ob)!=0:
        return JsonResponse({"task":"issue"})
    else:
        return JsonResponse({"task":"ok"})



from django.core.mail import send_mail
import random
def forgot_password(request):
    try:
        print(request.POST)
        uname = request.POST['uname']
        email = request.POST['email']
        g=Login.objects.get(Username=uname)
        if g is not None:
            ob=Student.objects.get(LOGIN__id=g.id)
            if ob.email==email:
                # a=random.randint(0000,9999)
                pwd=str(g.Password)

                try:
                    gmail = smtplib.SMTP('smtp.gmail.com', 587)
                    gmail.ehlo()
                    gmail.starttls()
                    gmail.login('hibakader5288@gmail.com', 'fdcnvsgbtmigrmqy')
                    print("login=======")
                except Exception as e:
                    print("Couldn't setup email!!" + str(e))
                msg = MIMEText("Your  password is : " + str(pwd))
                print(msg)
                msg['Subject'] = 'Career Guidance'
                msg['To'] = email
                msg['From'] = 'hibakader5288@gmail.com'

                print("ok====")

                try:
                    gmail.send_message(msg)
                except Exception as e:
                    print(e,"--------------")
                    return JsonResponse({"task": "invalid"})
                return JsonResponse({"task": "ok"})

                # send_mail('Career Guidance', "YOUR PASSWORD IS  -" +str(pwd), 'careerguidance198@gmail.com',[email], fail_silently=False)
                # # messages.info(request,"Password sent to your registered email address !!!")
                # print("okkkkk")
                # return JsonResponse({'task':"ok"})
        else:
            print('ppppp')
            return JsonResponse({'task': "invalid"})
    except Exception as e:
        print(e,"--------------------")
        return JsonResponse({'task': "invalid"})
