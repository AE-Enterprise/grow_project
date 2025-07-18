# mypy: disable-error-code=var-annotated
"""Plant API Models"""

from django.db import models

# Create your models here.
class Plant(models.Model):
    """Model representing a plant in the API."""

    id = models.UUIDField(primary_key=True, editable=False)
    name = models.CharField(max_length=100)
    species = models.CharField(max_length=100)
    date_planted = models.DateField()
    location = models.CharField(max_length=100, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.name} ({self.species})"
