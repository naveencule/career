# Generated by Django 3.2.20 on 2024-02-04 12:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Capp', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='resume',
            name='resume',
            field=models.FileField(upload_to=''),
        ),
    ]
