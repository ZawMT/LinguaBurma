import json
import logging

from django.contrib.auth import get_user_model
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from google.oauth2 import id_token
from google.auth.transport import requests as google_requests

User = get_user_model()
logger = logging.getLogger('lblogs') 

@csrf_exempt
def google_login(request):
    try:
        logger.debug("google_login")
        if request.method == "POST":
            try:
                data = json.loads(request.body)
                access_token = data.get("access_token")

                if not access_token:
                    logger.debug("google_login: Missing access_token")
                    return JsonResponse({"error": "Missing access_token"}, status=400)

                # Verify the Google ID Token
                idinfo = id_token.verify_oauth2_token(
                    access_token, google_requests.Request(), "435659788182-a71jli1unj6rh6li9r85mjl9fifp9qe3.apps.googleusercontent.com"
                )

                logger.debug("google_login: Checking Google token")
                if "sub" not in idinfo:
                    logger.debug("google_login: Invalid Google token")
                    return JsonResponse({"error": "Invalid Google token"}, status=400)

                logger.debug("google_login: Google token is valid")

                # Extract user info from token
                google_id = idinfo["sub"]
                email = idinfo.get("email", "")
                name = idinfo.get("name", "")

                # Check if user exists, if not, create one
                user, created = User.objects.get_or_create(
                    username=google_id,
                    defaults={"email": email, "first_name": name.split(" ")[0]},
                )

                return JsonResponse({
                    "message": "Login successful",
                    "user_id": user.id,
                    "email": user.email,
                })

            except ValueError:
                return JsonResponse({"error": "Invalid token"}, status=400)
    except Exception as e:
        logger.error(f"google_login: {e}")

    return JsonResponse({"error": "Invalid request"}, status=400)
