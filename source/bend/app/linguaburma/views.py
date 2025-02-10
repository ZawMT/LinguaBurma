from django.http import JsonResponse
from .models import FlashCard

def fc_play(request):
    word = request.GET.get('word', None)
    if not word:
        return JsonResponse({"error": "Please provide a word"}, status=400)

    try:
        fc = FlashCard.objects.get(Word=word)
        return JsonResponse({"word": fc.Word, "definition": fc.Definition}, status=200)
    except Definition.DoesNotExist:
        return JsonResponse({"error": "Word not found"}, status=404)