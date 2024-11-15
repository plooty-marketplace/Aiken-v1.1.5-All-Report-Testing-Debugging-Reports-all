module StakingContract where

type Stake = { user: String, amount: Int }
type StakedUsers = Map.Map String Int

let stake (amount : Int) (user : String) (stakedUsers : StakedUsers) : StakedUsers =
  let newAmount = Map.lookup user stakedUsers |> Option.getOrElse 0 + amount
  Map.insert user newAmount stakedUsers

let withdrawStake (user : String) (amount : Int) (stakedUsers : StakedUsers) : StakedUsers =
  let currentStake = Map.lookup user stakedUsers |> Option.getOrElse 0
  if currentStake >= amount then
    let newStake = currentStake - amount
    Map.insert user newStake stakedUsers
  else
    stakedUsers  // No action if not enough funds

