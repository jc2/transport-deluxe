import argparse
import json
import sys

import httpx

API_KEY = "367f4ddc-e815-4801-a157-fe591482a3b4"


def test_valhalla(lat1, lon1, lat2, lon2):
    url = "https://api.stadiamaps.com/route/v1"
    params = {"api_key": API_KEY}

    payload = {
        "locations": [{"lat": lat1, "lon": lon1}, {"lat": lat2, "lon": lon2}],
        "costing": "truck",
        "units": "kilometers",
    }

    print("Testing Stadia Maps (Valhalla) Routing in km")
    print(f"From (Lat/Lon): {lat1}, {lon1}")
    print(f"To (Lat/Lon):   {lat2}, {lon2}")
    print(f"Calling: {url}")

    try:
        response = httpx.post(
            url, params=params, json=payload, headers={"Content-Type": "application/json"}, timeout=10.0
        )
        response.raise_for_status()

        data = response.json()

        if "trip" in data and "summary" in data["trip"]:
            distance_km = data["trip"]["summary"]["length"]
            time_sec = data["trip"]["summary"]["time"]

            print("  ✅ Success!")
            print(f"  🛣️  Distance: {distance_km} km")
            print(f"  ⏱️  Est. Time: {time_sec / 3600:.2f} hours")
        else:
            print("  ❌ Unexpected Valhalla response format.")
            print(json.dumps(data, indent=2))
            sys.exit(1)

    except httpx.HTTPError as e:
        print(f"  ❌ Error calling Valhalla: {e}")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test local Valhalla Routing service")
    # Default uses Beverly Hills -> Empire State Building coordinates
    parser.add_argument("--lat1", type=float, default=34.0901)
    parser.add_argument("--lon1", type=float, default=-118.4065)
    parser.add_argument("--lat2", type=float, default=40.7488)
    parser.add_argument("--lon2", type=float, default=-73.9857)

    args = parser.parse_args()
    test_valhalla(args.lat1, args.lon1, args.lat2, args.lon2)
