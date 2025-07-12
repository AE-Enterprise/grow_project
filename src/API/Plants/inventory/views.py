from django.shortcuts import render
from django.http import JsonResponse
from .models import Plant

# Create your views here.

def get_all_plants(request):
    plants = Plant.objects.all().values()
    return JsonResponse(list(plants), safe=False)