{-# LANGUAGE OverloadedStrings #-}
module Handler.Locks where

import Data.Map
import Lostation
import Model.Lock
import Model.Pool
import Settings as S
import Yesod.Core

getLocksR :: MonadHandler m => m Value
getLocksR = do
  groupedLocks <- liftIO $ getAllLocks S.locksPath
  returnJson groupedLocks

postClaimLockR :: Pool -> String -> Handler Value
postClaimLockR = doLockAction claim

postUnclaimLockR :: Pool -> String -> Handler Value
postUnclaimLockR = doLockAction unclaim

postRecycleLockR :: Pool -> String -> Handler Value
postRecycleLockR = doLockAction recycle

-- TODO: Handle absence of username better
doLockAction :: MonadHandler m => LockAction -> Pool -> String -> m Value
doLockAction action pool lock = do
  maybeUsername <- lookupSession "username"
  case maybeUsername of
    (Just username) -> do
      _ <- liftIO $ action S.locksPath username pool lock
      returnJson ([] :: [String])
    _ -> returnJson (["Error!!"] :: [String])
