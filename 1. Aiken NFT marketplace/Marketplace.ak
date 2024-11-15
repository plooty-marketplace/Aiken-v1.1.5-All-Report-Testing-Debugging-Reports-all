contract NFTMarketplace {

    record NFT {
        id: Int,
        owner: Address,
        price: Int,
        isListed: Bool
    }

    record State {
        nfts: Map<Int, NFT>,
        nextId: Int
    }

    public function init() -> State {
        State {
            nfts: Map.empty(),
            nextId: 1
        }
    }

    public function mint(state: State, price: Int) -> (State, Int) {
        let nftId = state.nextId
        let nft = NFT {
            id: nftId,
            owner: caller,
            price: price,
            isListed: false
        }
        let updatedNfts = Map.insert(nftId, nft, state.nfts)
        (State { nfts: updatedNfts, nextId: nftId + 1 }, nftId)
    }

    public function listNFT(state: State, nftId: Int, price: Int) -> State {
        let nft = Map.lookup(nftId, state.nfts)
        match nft {
            Some(n) if n.owner == caller && !n.isListed => {
                let updatedNft = NFT { n with price = price, isListed = true }
                let updatedNfts = Map.insert(nftId, updatedNft, state.nfts)
                State { nfts: updatedNfts, nextId: state.nextId }
            }
            _ => state // No change if NFT is not found or already listed
        }
    }

    public function buyNFT(state: State, nftId: Int) -> State {
        let nft = Map.lookup(nftId, state.nfts)
        match nft {
            Some(n) if n.isListed && caller != n.owner && caller.balance >= n.price => {
                let updatedNft = NFT { n with owner = caller, isListed = false }
                let updatedNfts = Map.insert(nftId, updatedNft, state.nfts)
                // Transfer funds (not implemented here)
                State { nfts: updatedNfts, nextId: state.nextId }
            }
            _ => state // No change if NFT is not listed or caller can't afford it
        }
    }
}
