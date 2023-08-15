--select * 
--from  [Data Cleaning Portfolio Project].[dbo].[family_details]


------ Standardize Date Format

----Select f5, CONVERT(Date,F5) as date
----from  [Data Cleaning Portfolio Project].[dbo].[family_details]

----update [Data Cleaning Portfolio Project].[dbo].[family_details]
----SET f5 = CONVERT(Date,f5)

---- If it doesn't Update properly

--ALTER TABLE [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add SaleDateConverted Date;

--Update [Data Cleaning Portfolio Project].[dbo].[family_details]
--SET f5 = CONVERT(Date,F5)

---- Populate Property Address data

--Select *
--From [Data Cleaning Portfolio Project].[dbo].[family_details]


----Where PropertyAddress is null
--order by F2



--Select a.f2, a.f4, b.f2, b.f4, ISNULL(a.f4,b.f4)
--From [Data Cleaning Portfolio Project].[dbo].[family_details]
-- a
--JOIN [Data Cleaning Portfolio Project].[dbo].[family_details]
-- b
--	on a.F2 = b.F2
--	AND a.[f1] <> b.[f1 ]
--Where a.F4 is null


--Update a
--SET f4 = ISNULL(a.f4,b.f4)
--From [Data Cleaning Portfolio Project].[dbo].[family_details]
-- a
--JOIN [Data Cleaning Portfolio Project].[dbo].[family_details]
-- b
--	on a.f2 = b.f2
--	AND a.[f1] <> b.[f1 ]
--Where a.F4 is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


--Select f4
--From [Data Cleaning Portfolio Project].[dbo].[family_details]
----Where PropertyAddress is null
----order by ParcelID

--SELECT 
--SUBSTRING(f4, 1, CHARINDEX(',', f4) -1 ) as Address
--, SUBSTRING(f4, CHARINDEX(',', f4) + 1 , LEN(f4)) as Address

--From [Data Cleaning Portfolio Project].[dbo].[family_details]


--ALTER TABLE [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add PropertySplitAddress Nvarchar(255);

--Update [Data Cleaning Portfolio Project].[dbo].[family_details]
--SET PropertySplitAddress = SUBSTRING(f4, 1, CHARINDEX(',', f4) -1 )


--ALTER TABLE [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add PropertySplitCity1 Nvarchar(255);

--Update [Data Cleaning Portfolio Project].[dbo].[family_details]
--SET PropertySplitCity1 = SUBSTRING(f4, CHARINDEX(',', f4) + 1 , LEN(f4))




--Select *
--From  [Data Cleaning Portfolio Project].[dbo].[family_details]





--Select f10
--From  [Data Cleaning Portfolio Project].[dbo].[family_details]



--Select
--PARSENAME(REPLACE(f10, ',', '.') , 3)
--,PARSENAME(REPLACE(f10, ',', '.') , 2)
--,PARSENAME(REPLACE(f10, ',', '.') , 1)
--From  [Data Cleaning Portfolio Project].[dbo].[family_details]



--ALTER TABLE  [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add OwnerSplitAddress Nvarchar(255);

--Update  [Data Cleaning Portfolio Project].[dbo].[family_details]
--SET OwnerSplitAddress = PARSENAME(REPLACE(f10, ',', '.') , 3)


--ALTER TABLE [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add OwnerSplitCity Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitCity = PARSENAME(REPLACE(f10, ',', '.') , 2)



--ALTER TABLE [Data Cleaning Portfolio Project].[dbo].[family_details]
--Add OwnerSplitState Nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitState = PARSENAME(REPLACE(f10, ',', '.') , 1)



--Select *
--From [Data Cleaning Portfolio Project].[dbo].[family_details]


-- Change Y and N to Yes and No in "Sold as Vacant" field


--Select Distinct(f8), Count(f8)
--From [Data Cleaning Portfolio Project].[dbo].[family_details]
--Group by f8
--order by 2




--Select f8
--, CASE When f8 = 'Y' THEN 'Yes'
--	   When f8 = 'N' THEN 'No'
--	   ELSE f8
--	   END
--From [Data Cleaning Portfolio Project].[dbo].[family_details]


--Update [Data Cleaning Portfolio Project].[dbo].[family_details]
--SET f8 = CASE When f8 = 'Y' THEN 'Yes'
--	   When f8 = 'N' THEN 'No'
--	   ELSE f8
--	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY f1,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [Data Cleaning Portfolio Project].[dbo].[family_details]
order by f1
)
Select *
From RowNumCTE
Where row_num > 1
Order by f4



Select *
From [Data Cleaning Portfolio Project].[dbo].[family_details]
