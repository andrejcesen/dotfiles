#!/usr/bin/env bb

(ns merge-edn-map
  (:require [rewrite-clj.zip :as z]
            [clojure.edn :as edn]
            [clojure.java.io :as io]))

(defn merge-edn-map-and-write [target-path source-path]
  (let [values-map (-> (slurp source-path) edn/read-string)
        edn-zip (z/of-file target-path)]
    (->> (reduce (fn [zip [key value]]
                   (-> zip (z/assoc key value)))
                 edn-zip
                 values-map)
         z/root-string
         (spit target-path))))

(comment (merge-edn-and-write "./codescene-app/me-400-drop-analysis-id-column-from-time-series-db-table/onprem/resources/config.edn"
                              "./config/onprem-config.edn"))

(let [[target-path source-path] *command-line-args*]
  (when (or (empty? target-path) (empty? source-path))
    (println "Usage: <target-path> <values-path>")
    (System/exit 1))
  (merge-edn-map-and-write target-path source-path))
