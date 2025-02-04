from django.db import models

class FlashCard(models.Model):
    Word = models.TextField(db_column="word", unique=True) 
    Definition = models.TextField(db_column="definition") 
    Hine = models.TextField(db_column="hint")
    SampleSentence = models.TextField(db_column="sample_sentence")  

    class Meta:
        db_table = "flash_cards"  

    def __str__(self):
        return self.Word
