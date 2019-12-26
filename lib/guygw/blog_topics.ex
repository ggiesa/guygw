
    defmodule BlogConfig do
      @blog_topics %{"dsa" => %{"algorithms" => ["bubble_sort", "depth_first_search"], "data_structures" => ["deques", "stacks", "directed_graph", "binary_search_tree", "binary_heap", "arrays", "linked_lists", "queues"]}}

      def blog_topics do
        @blog_topics
      end
    end
    