module Network.Statsd where

type Name = String
type Value = Double
type Tag = (String, String)

data MetricType = Gauge | Counter | Timer deriving Show
data Metric = Metric MetricType Name Value [Tag] deriving Show
