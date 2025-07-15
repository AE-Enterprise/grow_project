"""
Serializers for the Plants API.
"""

from typing import List, Dict, Any
from rest_framework import serializers
from .models import Plant


class PlantSerializer(serializers.ModelSerializer):
    """Serializer for Plant model."""

    class Meta:
        """Data to be serialized."""

        model = Plant
        fields = ["id", "name", "species", "date_planted", "location", "notes"]

    def validate_location(self, value: str) -> str:
        """Validate the location field."""
        if not value:
            return "Unknown"
        return value
