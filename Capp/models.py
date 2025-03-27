from django.db import models

# Create your models here.


class Login(models.Model):
    Username = models.CharField(max_length=100)
    Password = models.CharField(max_length=100)
    Type = models.CharField(max_length=100)

# staff


class Staff(models.Model):
    fname = models.CharField(max_length=100)
    lname = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.IntegerField()
    phone = models.BigIntegerField()
    email =  models.CharField(max_length=100)
    image = models.FileField()
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)


# student


class Student(models.Model):
    fname = models.CharField(max_length=100)
    lname = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.IntegerField()
    phone = models.BigIntegerField()
    email = models.CharField(max_length=100)
    image = models.FileField()
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)


# company


class Company(models.Model):
    cname = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.IntegerField()
    phone = models.BigIntegerField()
    email = models.CharField(max_length=100)
    image = models.FileField()
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)


# College


class College(models.Model):
    name = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.IntegerField()
    phone = models.BigIntegerField()
    email = models.CharField(max_length=100)
    image = models.FileField()
    STAFF = models.ForeignKey(Staff, on_delete=models.CASCADE)


# Feedback


class Feedback_and_rating(models.Model):
    feedback = models.CharField(max_length=100)
    date = models.DateField()
    rate = models.CharField(max_length=100)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)


#Notfication


class Notification(models.Model):
    notification = models.CharField(max_length=100)
    date = models.DateField()
    STAFF = models.ForeignKey(Staff, on_delete=models.CASCADE)

# Complaint


class Complaint(models.Model):
    complaint = models.CharField(max_length=100)
    reply = models.CharField(max_length=100)
    date = models.DateField()
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)





# Enquiry



class Enquiry(models.Model):
    enquiries = models.CharField(max_length=100)
    reply = models.CharField(max_length=100)
    date = models.DateField()
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)


# Course


class Course(models.Model):
    name = models.CharField(max_length=100)
    details = models.CharField(max_length=100)
    date = models.DateField()
    COLLEGE = models.ForeignKey(College, on_delete=models.CASCADE)
    area=models.CharField(max_length=50)


# job and vacancy



class Job_and_vacancy(models.Model):
    name = models.CharField(max_length=100)
    details = models.CharField(max_length=100)
    qualification = models.CharField(max_length=100)
    last_date = models.DateField()
    no_of_vaccancy = models.IntegerField()
    COMPANY = models.ForeignKey(Company, on_delete=models.CASCADE)









# Application



class Application(models.Model):
    status = models.CharField(max_length=100)
    date = models.DateField()
    VACCANCY = models.ForeignKey(Job_and_vacancy, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)


# Resume


class Resume(models.Model):
    score = models.CharField(max_length=100)
    date = models.DateField()
    resume = models.FileField()
    APPLICATION = models.ForeignKey(Application, on_delete=models.CASCADE)











