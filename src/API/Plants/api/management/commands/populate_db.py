# mypy: disable-error-code=import-not-found
import random
import uuid
from datetime import timedelta

from api.models import Plant
from django.core.management.base import BaseCommand
from django.utils import timezone


class Command(BaseCommand):
    """Populate DB with random plants."""

    help = ""

    def handle(self, *args: object, **options: object) -> None:
        """Handl the command and create all of the plant objects in the DB."""
        plant_names = [
            "Aloe Vera",
            "Snake Plant",
            "Spider Plant",
            "Peace Lily",
            "Fiddle Leaf Fig",
            "Pothos",
            "Monstera",
            "Rubber Plant",
            "ZZ Plant",
            "Jade Plant",
        ]
        descriptions = [
            "Easy to care for and great for beginners.",
            "Thrives in low light and purifies air.",
            "Fast-growing and resilient.",
            "Beautiful white flowers and lush leaves.",
            "Large, dramatic leaves for a statement.",
            "Tolerates neglect and low light.",
            "Unique split leaves, loves humidity.",
            "Glossy leaves, low maintenance.",
            "Tough plant, survives with little water.",
            "Succulent, stores water in leaves.",
        ]

        # Added nosec comments to avoid security issues - as we are not using random to generate sensitive data
        for i in range(20):
            name = random.choice(plant_names)  # nosec B311
            species = f"{name} Species"
            notes = random.choice(descriptions)  # nosec B311
            date_planted = timezone.now().date() - timedelta(
                days=random.randint(0, 365)  # nosec B311
            )
            location = random.choice(  # nosec B311
                ["Indoor", "Outdoor", "Greenhouse", "Balcony"]
            )

            Plant.objects.create(
                id=uuid.uuid4(),
                name=f"{name} #{i+1}",
                species=species,
                notes=notes,
                date_planted=date_planted,
                location=location,
            )
        self.stdout.write(
            self.style.SUCCESS(
                "Successfully populated the database with random plants."
            )
        )
