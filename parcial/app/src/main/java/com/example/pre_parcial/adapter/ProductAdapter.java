package com.example.pre_parcial.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.pre_parcial.R;
import com.example.pre_parcial.models.Product;

import java.util.ArrayList;

public class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {

    private final ArrayList<Product> products;

    public ProductAdapter(ArrayList<Product> products) {
        this.products = products;
    }

    @NonNull
    @Override
    public ProductViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.activity_main2, parent, false);

        return new ProductAdapter.ProductViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ProductViewHolder holder, int position) {
     /*   Product current = getItem(position);
        holder.bind(current.getContent()); */

        Product product = products.get(position);

        System.out.println(product.getTitle());
        holder.Title.setText(product.getTitle());
        holder.Description.setText(product.getDescription());
        holder.Id.setText(Float.toString(product.getId()));
    }

    @Override
    public int getItemCount() {
        return products.size();
    }



    public static class ProductViewHolder extends RecyclerView.ViewHolder {

        private final TextView Title;

        private final TextView Id;
        private final TextView Description;

        public ProductViewHolder(@NonNull View itemView) {
            super(itemView);
            Title = itemView.findViewById(R.id.title);
            Id = itemView.findViewById(R.id.id);
            Description = itemView.findViewById(R.id.description);
        }
     /*   public void bind(String title, String description) {
            Title.setText(title);
            Description.setText(description);
        } */


     /*   static  ProductViewHolder create(ViewGroup parent) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.activity_main2, parent, false);
            return new ProductViewHolder(view);
        }
 */
    }
}