from django.contrib import admin

# Register your models here.
from . import models

models_to_register = [
    models.Plant,
]

admin.site.register(models_to_register)
admin.site.site_header = "Plant Inventory Admin"
admin.site.site_title = "Plant Inventory Admin Portal"
admin.site.index_title = "Welcome to the Plant Inventory Management Portal"