"""URL routing for the API app."""

from . import views
from django.urls import path

urlpatterns = [
    path("", views.PlantListView.as_view(), name="view_all_plants"),
    path("all/", views.get_all_plants, name="get_all_plants"),
    path("plant/<uuid:pk>", views.get_plant_by_id, name="get_all_plants"),
    path("put/", views.put_plant, name="create_plant"),
]
