from django.http import JsonResponse
from .models import Definition

def get_definition(request):
    word = request.GET.get('word', None)
    if not word:
        return JsonResponse({"error": "Please provide a word"}, status=400)

    try:
        definition = Definition.objects.get(Word=word)
        return JsonResponse({"word": definition.Word, "definition": definition.Definition}, status=200)
    except Definition.DoesNotExist:
        return JsonResponse({"error": "Word not found"}, status=404)
