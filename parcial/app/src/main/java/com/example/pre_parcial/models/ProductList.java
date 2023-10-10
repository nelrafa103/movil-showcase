package com.example.pre_parcial.models;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;

public class ProductList {

    @SerializedName("products")
    private ArrayList<Product> products;


    @SerializedName("total")
    private int total;


    @SerializedName("skip")
    private int skip;

    @SerializedName("limit")
    private int limit;


    public int getLimit() {
        return limit;
    }

    public int getSkip() {
        return skip;
    }

    public int getTotal() {
        return total;
    }

    public ArrayList<Product> getProducts() {
        return products;
    }
}
