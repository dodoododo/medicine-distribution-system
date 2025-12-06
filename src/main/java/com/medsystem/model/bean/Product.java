package com.medsystem.model.bean;

import java.sql.Date;

public class Product {
    private int id;
    private int categoryId;
    private String name;
    private String description;
    private int price;
    private int stockQuantity;
    private Category category; // thêm trường Category
    private String imageUrl;
    private String manufacturer;
    private Date expiryDate;
    private boolean isActive;

    public Product() {}

    public Product(int id, int categoryId, String name, String description, int price, int stockQuantity,
            String imageUrl, String manufacturer, Date expiryDate, boolean isActive) {
	 this.id = id;
	 this.categoryId = categoryId;
	 this.name = name;
	 this.description = description;
	 this.price = price;
	 this.stockQuantity = stockQuantity;
	 this.imageUrl = imageUrl;
	 this.manufacturer = manufacturer;
	 this.expiryDate = expiryDate;
	 this.isActive = isActive;
	 this.category = null; // category sẽ gán sau bằng setCategory()
	}


    // --- Getter / Setter ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    public String getCategoryName() { 
        return category != null ? category.getName() : ""; 
    }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
