module Network.Statsd where

type Name = String
type Value = Int

data MetricType = Gauge | Counter | Timer deriving Show
data Metric = Metric MetricType Name Value deriving Show
