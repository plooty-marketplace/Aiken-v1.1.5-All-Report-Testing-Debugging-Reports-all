
// NFT Marketplace Smart Contract in Aiken v1.1.5

module NFTMarketplace where

import Data.Map as Map
import Data.String (String)
import Data.Bool (Bool)

type NFT = { id: Int, name: String, owner: String, price: Int }
type Marketplace = Map.Map Int NFT

// Storage
let marketplace : Marketplace = Map.empty

// Function to mint new NFTs
let mintNFT (id : Int) (name : String) (price : Int) (owner : String) : NFT = 
  { id = id, name = name, price = price, owner = owner }

// Add NFT to the marketplace
let addNFTToMarketplace (nft : NFT) : Marketplace -> Marketplace = 
  \marketplace -> Map.insert nft.id nft marketplace

// Buy NFT from the marketplace
let buyNFT (id : Int) (buyer : String) (marketplace : Marketplace) : Marketplace = 
  case Map.lookup id marketplace of
    Some nft -> 
      if nft.price == 0 then
        marketplace
      else 
        let newNFT = { nft with owner = buyer }
        Map.insert id newNFT marketplace
    None -> marketplace
