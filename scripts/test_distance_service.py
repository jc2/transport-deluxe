import argparse
import sys

import httpx

# Cloud endpoints
NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"
VALHALLA_URL = "https://api.stadiamaps.com/route/v1"
STADIA_API_KEY = ""


def geocode_zipcode(zipcode):
    print(f"Geocoding ZIP: {zipcode}")
    headers = {"User-Agent": "TransportDeluxeApp/1.0"}
    # Nominatim handles US Zipcodes specifically
    params = {"postalcode": zipcode, "country": "US", "countrycodes": "us", "format": "json", "limit": 1}
    try:
        response = httpx.get(NOMINATIM_URL, params=params, headers=headers, timeout=10.0)
        response.raise_for_status()
        data = response.json()
        if not data:
            print(f"  ❌ Could not find coordinates for ZIP {zipcode}")
            return None

        lat = float(data[0]["lat"])
        lon = float(data[0]["lon"])
        print(f"  ✅ Found coordinates: Lat {lat}, Lon {lon}")
        return {"lat": lat, "lon": lon}

    except httpx.HTTPError as e:
        print(f"  ❌ Error calling Nominatim: {e}")
        return None


def calculate_route_distance(pickup_coords, drop_coords):
    print(f"Routing from {pickup_coords} to {drop_coords}...")

    params = {"api_key": STADIA_API_KEY}
    payload = {"locations": [pickup_coords, drop_coords], "costing": "truck", "units": "kilometers"}

    try:
        # Note: Depending on valhalla version we must pass the param correctly.
        response = httpx.post(
            VALHALLA_URL, params=params, json=payload, headers={"Content-Type": "application/json"}, timeout=10.0
        )
        response.raise_for_status()
        data = response.json()

        # Typically trips summary has distance length
        if "trip" in data and "summary" in data["trip"]:
            distance_km = data["trip"]["summary"]["length"]
            time_seconds = data["trip"]["summary"]["time"]
            print("  ✅ Route successful!")
            print(f"  🛣️  Distance: {distance_km} km")
            print(f"  ⏱️  Est. Time: {time_seconds / 3600:.2f} hours")
            return distance_km
        else:
            print("  ❌ Unexpected Valhalla response format.")
            print(data)
            return None

    except httpx.HTTPError as e:
        print(f"  ❌ Error calling Valhalla: {e}")
        return None


def run_example():
    parser = argparse.ArgumentParser(description="Test local distance service (Nominatim + Valhalla).")
    parser.add_argument("pickup_zip", type=str, help="Pickup Zipcode (e.g. 90210)")
    parser.add_argument("drop_zip", type=str, help="Drop Zipcode (e.g. 10001)")

    args = parser.parse_args()

    # Step 1: Geocode
    pickup_coords = geocode_zipcode(args.pickup_zip)
    if not pickup_coords:
        sys.exit(1)

    drop_coords_res = geocode_zipcode(args.drop_zip)
    if not drop_coords_res:
        sys.exit(1)

    # Step 2: Routing
    dist = calculate_route_distance(pickup_coords, drop_coords_res)
    if dist is None:
        sys.exit(1)


if __name__ == "__main__":
    run_example()
