import argparse
import json
import sys

import httpx


def test_nominatim(zipcode):
    url = "https://nominatim.openstreetmap.org/search"
    headers = {"User-Agent": "TransportDeluxeApp/1.0"}
    params = {"postalcode": zipcode, "country": "US", "countrycodes": "us", "format": "json", "limit": 1}

    print(f"Testing Nominatim Geocoding for ZIP: {zipcode}")
    print(f"Calling: {url}")

    try:
        response = httpx.get(url, params=params, headers=headers, timeout=10.0)
        response.raise_for_status()
        data = response.json()

        if not data:
            print(f"  ❌ Could not find coordinates for ZIP {zipcode}.")
            sys.exit(1)

        lat = float(data[0]["lat"])
        lon = float(data[0]["lon"])
        print(f"  ✅ Success! Coordinates: Lat {lat}, Lon {lon}")
        print(json.dumps(data[0], indent=2))

    except httpx.HTTPError as e:
        print(f"  ❌ Error calling Nominatim: {e}")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test local Nominatim Geocoding service")
    parser.add_argument("zipcode", nargs="?", default="90210", help="ZIP code to look up")
    args = parser.parse_args()
    test_nominatim(args.zipcode)
