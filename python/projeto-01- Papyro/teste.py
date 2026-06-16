# Dicionário vazio.
frutas = {}

# Adiciona elementos ao dicionário.
frutas["Banana"] = 3
frutas["Laranja"] = 5

# Adiciona vários elementos de uma vez.
frutas.update({
    "Maçã": 4,
    "Carambola": 2,
    "Tomate": 7
})

print(frutas)
print(type(frutas))