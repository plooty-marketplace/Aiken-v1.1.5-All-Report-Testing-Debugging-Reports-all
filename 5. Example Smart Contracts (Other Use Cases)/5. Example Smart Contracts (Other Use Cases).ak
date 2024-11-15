module ERC20Token where

type Token = { name: String, symbol: String, totalSupply: Int }
type Account = Map.Map String Int  // Account balance map

let token = { name = "MyToken", symbol = "MTK", totalSupply = 1000000 }

let mint (account : Account) (amount : Int) (address : String) : Account = 
  let newBalance = Map.lookup address account |> Option.getOrElse 0 + amount
  Map.insert address newBalance account

