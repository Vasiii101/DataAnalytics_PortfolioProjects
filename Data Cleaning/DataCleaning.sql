select * from NashVill

--- Standardize date format ---
Select SaleDateConverted, CONVERT(Date,SaleDate)
From Portfolio.dbo.NashVill

Update NashVill
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE NashVill
Add SaleDateConverted Date;

Update NashVill
SET SaleDateConverted = Convert(Date,SaleDate)

-----------------------------------------------------------------------
-- Populate Property Address data

Select *
From Portfolio.dbo.NashVill
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From Portfolio.dbo.NashVill a
JOIN Portfolio.dbo.NashVill b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Portfolio.dbo.NashVill a
JOIN Portfolio.dbo.NashVill b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-----------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From Portfolio.dbo.NashVill

Select 
SUBSTRING(PropertyAddress, 1,  CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as Address
From Portfolio.dbo.NashVill

ALTER TABLE NashVill
Add PropertySplitAddress Nvarchar(255);

Update NashVill
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashVill
Add PropertySplitCity Nvarchar(255);

Update NashVill
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

select * From Portfolio.dbo.NashVill

select OwnerAddress 
From Portfolio.dbo.NashVill

Select
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From Portfolio.dbo.NashVill

ALTER TABLE NashVill
Add OwnerSplitAddress Nvarchar(255);

ALTER TABLE NashVill
Add OwnerSplitCity Nvarchar(255);

ALTER TABLE NashVill
Add OwnerSplitState Nvarchar(255);

Update NashVill
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

Update NashVill
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

Update NashVill
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)


select * From Portfolio.dbo.NashVill
-----------------------------------------CHange Y to Yes and N to No in the table------------------------------------
Select Distinct(SoldAsVacant), count(SoldAsVacant)
From Portfolio.dbo.NashVill
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
 CASE When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No' 
		ELSE SoldAsVacant
		END
From Portfolio.dbo.NashVill

Update NashVill
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
						When SoldAsVacant = 'N' Then 'No' 
						ELSE SoldAsVacant
						END

---------------------------------------------REMOVE DUPLICATES----------------------------------
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() over (
	PARTITION BY	ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					ORDER By
						UniqueID
						) row_num

From Portfolio.dbo.NashVill
--order by ParcelID
)
Select *
----DELETE duplicates-----
--DELETE 
From RowNumCTE
Where row_num>1
--Order by PropertyAddress

-------------------------------------DELETE UNUSED COLUMNS---------------------------------------------------------------

select * From Portfolio.dbo.NashVill

ALTER TABLE Portfolio.dbo.NashVill
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE Portfolio.dbo.NashVill
DROP COLUMN SaleDate