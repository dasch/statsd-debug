module Network.Statsd where

import Data.List (intercalate)
import qualified Data.Map as Map

type Name = String
type Value = Double
type Tags = Map.Map String String

data MetricType = Gauge | Counter | Timer | Histogram deriving (Show, Eq)
data Metric = Metric MetricType Name Value Tags deriving Eq

instance Show Metric where
    show (Metric metricType metricName metricValue metricTags) =
        intercalate " " [formatType metricType, formatName metricName, formatValue metricValue, formatTags metricTags]

formatType = show
formatName name = "`" ++ name ++ "'"
formatValue = show

formatTags tags =
    let
        formatTag (name, value) = name ++ ":" ++ value
        formattedTags = map formatTag $ Map.toList tags
    in
        intercalate ", " formattedTags
