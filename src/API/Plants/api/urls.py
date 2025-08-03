"""URL routing for the API app."""

from . import views
from django.urls import path

urlpatterns = [
    path("all/", views.get_all, name="get_all_plants"),
    path("all/detailed/", views.get_all_detailed, name="view_all_detailed_plants"),
    path("plant/<uuid:pk>", views.get_plant_by_id, name="get_plant_by_id"),
    path("put/", views.put_plant, name="create_plant"),
]
