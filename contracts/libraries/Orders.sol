// SPDX-License-Identifier: MIT

pragma solidity =0.8.3;

library Orders {
    // keccak256("Ask(address signer,address nft,uint256 tokenId,uint256 amount,address strategy,address currency,address recipient,uint256 deadline,bytes params)")
    bytes32 internal constant ASK_TYPEHASH = 0x6f0a39f54a8e8bd221957768170633e60ee1230db20af6d68daa918793ce7eb3;
    // keccak256("Bid(bytes32 askHash,address signer,uint256 amount,uint256 price,address recipient,address referrer)")
    bytes32 internal constant BID_TYPEHASH = 0xb98e1dc48988064e6dfb813618609d7da80a8841e5f277039788ac4b50d497b2;

    struct Ask {
        address signer;
        address nft;
        uint256 tokenId;
        uint256 amount;
        address strategy;
        address currency;
        address recipient;
        uint256 deadline;
        bytes params;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    struct Bid {
        bytes32 askHash;
        address signer;
        uint256 amount;
        uint256 price;
        address recipient;
        address referrer;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    function hash(Ask memory ask) internal pure returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    ASK_TYPEHASH,
                    ask.signer,
                    ask.nft,
                    ask.tokenId,
                    ask.amount,
                    ask.strategy,
                    ask.currency,
                    ask.recipient,
                    ask.deadline,
                    keccak256(ask.params)
                )
            );
    }

    function hash(Bid memory bid) internal pure returns (bytes32) {
        return
            keccak256(
                abi.encode(BID_TYPEHASH, bid.askHash, bid.signer, bid.amount, bid.price, bid.recipient, bid.referrer)
            );
    }
}
