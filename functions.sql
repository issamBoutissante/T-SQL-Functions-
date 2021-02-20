use GestionCom
-- Exemple
create function tableDetailCmd()
returns @detailCmd table (numCmd int,numArt int)
  as 
begin
  insert into @detailCmd(numCmd,numArt)
  select numCom,numArt
  from LigneCommande
  return
end

select * from tableDetailCmd()

-- Exer1:
-- Créer une fonction qui retourne le factoriel d’
-- un nombre
create function calFactoriel(@nombre int)
returns int
as
begin
  declare @factoriel int =1
  while (@nombre>1)
   begin
      set @factoriel=@factoriel*@nombre
	  set @nombre=@nombre-1
   end
  return @factoriel
end

print dbo.calFactoriel(4)

--Exer2:
-- Créer une fonction qui convertis une chaine en majusculecreate function EnMajuscule(@chaine varchar(100))returns varchar(100)asbegin    return upper(@chaine)endprint dbo.EnMajuscule('issam')-- Exer3:
-- Créer une fonction qui retourne le nombre de fois que se
-- répète un caractère dans une chaine
create function nombreFois(@chaine varchar(100),@character char(1))
returns int
as
begin
   declare @nombre int=0;
   declare @i int=1;
   while(@i<=len(@chaine))
      begin
	     if(SUBSTRING(@chaine,@i,1)=@character)
	       set @nombre=@nombre+1;
	     set @i=@i+1;
	  end
    return @nombre;
end

print dbo.nombreFois('boutissante','s')

-- Exer4:
--Créer une fonction qui retourne le montant global d’une commande
create function calMontant(@numCom int)
returns decimal
as
begin
   declare @montant decimal;
   select @montant=sum(qteCommandee*puart) from LigneCommande join Article
   on LigneCommande.numArt=Article.numArt
   group by numCom
   having numCom=@numCom
   return @montant;
end

print dbo.calMontant(3)