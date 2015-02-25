import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import qualified Data.Map
import Network.Statsd
import Network.Statsd.Parser

parse input = case parseMetrics input of
    Left _ -> error $ "failed to parse " ++ input
    Right [metric] -> metric

main :: IO ()
main = hspec $ do
    describe "Network.Statsd.Parser" $ do
        it "parses simple metrics" $ do
            parse "gas:0.5|g" `shouldBe` (Metric Gauge "gas" 0.5 Data.Map.empty)
            parse "miles:1|c" `shouldBe` (Metric Counter "miles" 1 Data.Map.empty)
            parse "shift:500|ms" `shouldBe` (Metric Timer "shift" 500 Data.Map.empty)
