SELECT id, PrimeiroNome, value as dados FROM cadastros
CROSS APPLY OPENJSON(outros_dados)


SELECT id, PrimeiroNome, JSON_VALUE(outros_dados, '$.p[0].FirstName') as nomeFilhos
FROM cadastros

SELECT [key], value
FROM cadastros OPENJSON(outros_dados);

UPDATE cadastros set outros_dados = 
'
   { 
      "BirthDate":"1971-08-01",
      "NationalIDNumber":"245797967",
      "LoginID":"adventure-works\\terri0",
      "p":[
         {
            "FirstName":"Terri",
            "MiddleName":"Lee",
            "LastName":"Duffy"
         }
      ]
   },
'


DECLARE @json NVARCHAR(4000)
SET @json = 
'
   { 
      "BirthDate":"1971-08-01",
      "NationalIDNumber":"245797967",
      "LoginID":"adventure-works\\terri0",
      "p":[         
            { "FirstName":"Terri",
            "MiddleName":"Lee",
            "LastName":"Duffy" }
      ]
   },
'

SELECT JSON_VALUE(@json, '$.p[0].FirstName') as type
  JSON_VALUE(@json, '$.info.address.town') as town,
  JSON_QUERY(@json, '$.info.tags') as tags