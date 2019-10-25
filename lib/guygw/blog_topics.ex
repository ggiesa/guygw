
    defmodule BlogConfig do
      @blog_topics %{"dsa" => %{"algorithms" => ["bubble_sort"], "data_structures" => ["deques", "stacks", "binary_search_tree", "binary_heap", "arrays", "linked_lists", "queues"]}}

      def blog_topics do
        @blog_topics
      end
    end
    