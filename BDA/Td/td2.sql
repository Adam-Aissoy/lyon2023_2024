/* Td 2 : ( 28/09/2023 ) 
Exercice 1  */

/* 3  */
select pnom from Commandes where cnom = Jean ; 
/* 6 */ 
/* 11 */ 
/* je voulais faire ça mais je sais pas j'ai fais l'inverse*/ 
select pnom,fnom from Produits where (
    select fnom from Fournisseurs 
)
/* or 
i thinks it is similaire (phone 28/09/2023 )
False mais je vais la garder 
*/ 
select fnom from Fournisseurs Except select pnom,fnom from Produits 


