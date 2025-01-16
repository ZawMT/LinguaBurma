from django.db import models

class Definition(models.Model):
    Word = models.TextField(db_column="word", unique=True) 
    Definition = models.TextField(db_column="definition")   

    class Meta:
        db_table = "tbldef"  

    def __str__(self):
        return self.Word
