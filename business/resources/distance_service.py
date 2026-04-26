import logging

import httpx

logger = logging.getLogger(__name__)

# External provider URLs
NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"
STADIA_VALHALLA_URL = "https://api.stadiamaps.com/route/v1"
STADIA_API_KEY = "367f4ddc-e815-4801-a157-fe591482a3b4"


class DistanceServiceError(Exception):
    pass


async def get_coordinates_from_zip(zipcode: str, country: str = "US") -> dict:
    """
    Given a ZIP code, queries the remote Nominatim API to get location coordinates.
    Returns: {"lat": float, "lon": float}
    """
    headers = {"User-Agent": "TransportDeluxeApp/1.0"}
    params = {"postalcode": zipcode, "country": country, "countrycodes": country.lower(), "format": "json", "limit": 1}

    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(NOMINATIM_URL, params=params, headers=headers, timeout=10.0)
            response.raise_for_status()
            data = response.json()

            if not data:
                raise DistanceServiceError(f"Coordinates not found for ZIP {zipcode}")

            return {"lat": float(data[0]["lat"]), "lon": float(data[0]["lon"])}
        except httpx.HTTPError as e:
            logger.error(f"Nominatim Geocoding Error: {e}")
            raise DistanceServiceError(f"Geocoding service unavailable: {e}")


async def calculate_truck_route_distance(pickup_coords: dict, drop_coords: dict) -> float:
    """
    Given pickup and drop coordinates, queries Stadia Maps Valhalla API.
    Returns: Distance in kilometers
    """
    params = {"api_key": STADIA_API_KEY}
    payload = {"locations": [pickup_coords, drop_coords], "costing": "truck", "units": "kilometers"}

    async with httpx.AsyncClient() as client:
        try:
            response = await client.post(
                STADIA_VALHALLA_URL,
                params=params,
                json=payload,
                headers={"Content-Type": "application/json"},
                timeout=10.0,
            )
            response.raise_for_status()
            data = response.json()

            if "trip" in data and "summary" in data["trip"]:
                return float(data["trip"]["summary"]["length"])
            else:
                raise DistanceServiceError(f"Unexpected routing response format: {data}")

        except httpx.HTTPError as e:
            logger.error(f"Valhalla Routing Error: {e}")
            raise DistanceServiceError(f"Routing service unavailable: {e}")


async def get_distance_by_zipcodes(pickup_zip: str, drop_zip: str) -> float:
    """
    Orchestrates Geocoding + Routing in one step.
    1. Geocodes both ZIPs via Nominatim
    2. Calculates the truck route via Stadia Maps Valhalla
    """
    pickup_coords = await get_coordinates_from_zip(pickup_zip)
    drop_coords = await get_coordinates_from_zip(drop_zip)

    distance_km = await calculate_truck_route_distance(pickup_coords, drop_coords)
    return distance_km
