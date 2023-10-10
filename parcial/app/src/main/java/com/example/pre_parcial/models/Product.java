package com.example.pre_parcial.models;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;

public class Product {

    @SerializedName("id")
    private float id;

    @SerializedName("title")

    private String title;
    @SerializedName("description")
    private String description;

    @SerializedName("price")

    private float price;

    @SerializedName("discountPercentage")

    private float discountPercentage;

    @SerializedName("rating")

    private float rating;

    @SerializedName("stock")

    private float stock;

    @SerializedName("brand")

    private String brand;

    @SerializedName("category")

    private String category;

    @SerializedName("thumbnail")

    private String thumbnail;

    @SerializedName("images")

    ArrayList< Object > images = new ArrayList < Object > ();


    // Getter Methods

    public float getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public float getPrice() {
        return price;
    }

    public float getDiscountPercentage() {
        return discountPercentage;
    }

    public float getRating() {
        return rating;
    }

    public float getStock() {
        return stock;
    }

    public String getBrand() {
        return brand;
    }

    public String getCategory() {
        return category;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    // Setter Methods

    public void setId(float id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setDiscountPercentage(float discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public void setStock(float stock) {
        this.stock = stock;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
}
