import uuid
from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.request import Request
from rest_framework.response import Response
from django.http import JsonResponse
from .models import Plant
from .serializers import PlantSerializer


class PlantListView(generics.ListAPIView[Plant]):
    """API to list all plants"""

    queryset = Plant.objects.all()
    serializer_class = PlantSerializer


@api_view(["GET"])
def get_all_plants(_: Request) -> Response:
    """
    Retrieve all plants in the database.
    """
    plants = Plant.objects.all()
    serializer = PlantSerializer(plants, many=True)
    return Response(serializer.data)


@api_view(["GET"])
def get_plant_by_id(_: Request, pk: uuid.UUID) -> JsonResponse:
    """
    Retrieve a plant by its ID.
    """

    plant = get_object_or_404(Plant, id=pk)
    serializer = PlantSerializer(plant)
    return JsonResponse(serializer.data)


@api_view(["PUT"])
def put_plant(request: Request) -> JsonResponse:
    """
    Create a new plant.
    """
    serializer = PlantSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)
