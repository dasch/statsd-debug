module Network.Statsd where

import Data.Map (Map)

type Name = String
type Value = Double
type Tags = Map String String

data MetricType = Gauge | Counter | Timer deriving Show
data Metric = Metric MetricType Name Value Tags deriving Show
