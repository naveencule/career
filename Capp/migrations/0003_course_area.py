# Generated by Django 3.2.20 on 2024-02-06 03:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Capp', '0002_alter_resume_resume'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='area',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]
