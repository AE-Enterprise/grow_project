from django.contrib import admin

# Register your models here.
from . import models

admin.site.register(models.Plant)
admin.site.site_header = "Plant API Admin"
admin.site.site_title = "Plant API Admin Portal"
admin.site.index_title = "Welcome to the Plant API Management Portal"
