/*

Cleaning Data in SQL Queries

*/


Select *
from PortfolioProject..NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select SaleDate, Convert(Date, SaleDate)
from PortfolioProject..NashvilleHousing

Update NashvilleHousing
Set SaleDate = Convert(Date, SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date

Update NashvilleHousing
Set SaleDateConverted = Convert(Date, SaleDate)

Select SaleDateConverted, Convert(Date, SaleDate)
from PortfolioProject..NashvilleHousing


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


Select t1.ParcelID, t1.PropertyAddress, t2.ParcelID, t2.PropertyAddress, ISNULL(t1.PropertyAddress, t2.PropertyAddress)
from PortfolioProject..NashvilleHousing t1
JOIN PortfolioProject..NashvilleHousing t2
	ON t1.ParcelID= t2.ParcelID
	AND t1.[UniqueID ] <> t2.[UniqueID ]
Where t1.PropertyAddress is null


Update t1
SET PropertyAddress = ISNULL(t1.PropertyAddress, t2.PropertyAddress)
from PortfolioProject..NashvilleHousing t1
JOIN PortfolioProject..NashvilleHousing t2
	ON t1.ParcelID= t2.ParcelID
	AND t1.[UniqueID ] <> t2.[UniqueID ]
Where t1.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

-- PropertyAddress

Select PropertyAddress
From PortfolioProject.dbo.NashvilleHousing

Select PropertyAddress,
SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255), PropertySplitCity Nvarchar(255)

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1),
PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))



Select *
From PortfolioProject.dbo.NashvilleHousing


-- OwnerAddress

Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing
											
											
Select OwnerAddress,						
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
From PortfolioProject.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255), OwnerSplitCity Nvarchar(255), OwnerSplitState Nvarchar(255)

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)


Select *
From PortfolioProject.dbo.NashvilleHousing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field



Select Distinct(SoldAsVacant),COUNT(SoldAsVacant)
From PortfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2



Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
End
From PortfolioProject.dbo.NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
						When SoldAsVacant = 'N' Then 'No'
						Else SoldAsVacant
					End			





-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Finding Duplicates


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 ORDER BY 
					UniqueID) row_num
From PortfolioProject.dbo.NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1


-- Remove Duplicates


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 ORDER BY 
					UniqueID) row_num
From PortfolioProject.dbo.NashvilleHousing
)
Delete
From RowNumCTE
Where row_num > 1


Select *
From PortfolioProject.dbo.NashvilleHousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
DROP COlUMN OwnerAddress, PropertyAddress, TaxDistrict, SaleDate




-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------