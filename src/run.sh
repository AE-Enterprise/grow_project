#!/bin/bash

# Activate the virtual environment if it exists
if [ -f venv/bin/activate ]; then
    source venv/bin/activate
    echo "Virtual environment activated"
else
    echo "No virtual environment found at venv/bin/activate"
fi

# Initialize port counter
port=8000

# Find all manage.py files under the current directory
find . -name "manage.py" | while read -r managepy; do
    dir=$(dirname "$managepy")
    echo "Running $managepy on port $port"
    (cd "$dir" && python3 manage.py runserver 0.0.0.0:$port &)
    ((port++))
done

echo "All servers started."
