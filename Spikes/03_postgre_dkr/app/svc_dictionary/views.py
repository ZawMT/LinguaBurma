from django.http import JsonResponse
from .models import Definition
import requests
from rest_framework.decorators import api_view
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.models import User

GOOGLE_VALIDATION_URL = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token="

def get_definition(request):
    word = request.GET.get('word', None)
    if not word:
        return JsonResponse({"error": "Please provide a word"}, status=400)

    try:
        definition = Definition.objects.get(Word=word)
        return JsonResponse({"word": definition.Word, "definition": definition.Definition}, status=200)
    except Definition.DoesNotExist:
        return JsonResponse({"error": "Word not found"}, status=404)

@api_view(['POST'])
def google_login(request):
    token = request.data.get("token")
    if not token:
        return JsonResponse({"error": "Token is required"}, status=400)

    google_response = requests.get(f"{GOOGLE_VALIDATION_URL}{token}")
    if google_response.status_code != 200:
        return JsonResponse({"error": "Invalid Google token"}, status=400)

    google_data = google_response.json()
    email = google_data.get("email")
    name = google_data.get("name")

    user, _ = User.objects.get_or_create(username=email, defaults={"first_name": name})
    refresh = RefreshToken.for_user(user)

    return JsonResponse({
        "user": {
            "id": user.id,
            "email": user.email,
            "name": user.first_name,
        },
        "token": str(refresh.access_token),
    })
