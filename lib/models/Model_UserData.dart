class ModelUserData {
  String state;
  String statusCode;
  List<StoresWithCategoriesAndProducts> storesWithCategoriesAndProducts;
  List<AaishaniStores> aaishaniStores;

  ModelUserData(
      {this.state, this.storesWithCategoriesAndProducts, this.aaishaniStores});

  ModelUserData.fromJson(Map<String, dynamic> json,status_Code) {
    state = json['state'];
    statusCode=status_Code;
    if (json['stores_with_categories_and_products'] != null) {
      storesWithCategoriesAndProducts =
      new List<StoresWithCategoriesAndProducts>();
      json['stores_with_categories_and_products'].forEach((v) {
        storesWithCategoriesAndProducts
            .add(new StoresWithCategoriesAndProducts.fromJson(v));
      });
    }
    if (json['aaishani_stores'] != null) {
      aaishaniStores = new List<AaishaniStores>();
      json['aaishani_stores'].forEach((v) {
        aaishaniStores.add(new AaishaniStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.storesWithCategoriesAndProducts != null) {
      data['stores_with_categories_and_products'] =
          this.storesWithCategoriesAndProducts.map((v) => v.toJson()).toList();
    }
    if (this.aaishaniStores != null) {
      data['aaishani_stores'] =
          this.aaishaniStores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoresWithCategoriesAndProducts {
  String sId;
  String deliveryType;
  List<Categories> categories;
  String name;
  String contact;
  String address;
  String ownerName;
  String openTime;
  String storeCategory;
  String closeTime;
  String thumbnail;
  String locality;
  int minimumOrder;
  int iV;

  StoresWithCategoriesAndProducts(
      {this.sId,
        this.deliveryType,
        this.categories,
        this.name,
        this.contact,
        this.address,
        this.ownerName,
        this.openTime,
        this.storeCategory,
        this.closeTime,
        this.thumbnail,
        this.locality,
        this.minimumOrder,
        this.iV});

  StoresWithCategoriesAndProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    deliveryType = json['delivery_type'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    ownerName = json['owner_name'];
    openTime = json['open_time'];
    storeCategory = json['store_category'];
    closeTime = json['close_time'];
    thumbnail = json['thumbnail'];
    locality = json['locality'];
    minimumOrder = json['minimum_order'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['delivery_type'] = this.deliveryType;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['owner_name'] = this.ownerName;
    data['open_time'] = this.openTime;
    data['store_category'] = this.storeCategory;
    data['close_time'] = this.closeTime;
    data['thumbnail'] = this.thumbnail;
    data['locality'] = this.locality;
    data['minimum_order'] = this.minimumOrder;
    data['__v'] = this.iV;
    return data;
  }
}

class AaishaniStores {
  String aId;
  String deliveryType;
  List<Categories> categories;
  String name;
  String contact;
  String address;
  String ownerName;
  String openTime;
  String storeCategory;
  String closeTime;
  String thumbnail;
  String locality;
  int minimumOrder;
  int iV;

  AaishaniStores(
      {this.aId,
        this.deliveryType,
        this.categories,
        this.name,
        this.contact,
        this.address,
        this.ownerName,
        this.openTime,
        this.storeCategory,
        this.closeTime,
        this.thumbnail,
        this.locality,
        this.minimumOrder,
        this.iV});

  AaishaniStores.fromJson(Map<String, dynamic> json) {
    aId = json['_id'];
    deliveryType = json['delivery_type'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    ownerName = json['owner_name'];
    openTime = json['open_time'];
    storeCategory = json['store_category'];
    closeTime = json['close_time'];
    thumbnail = json['thumbnail'];
    locality = json['locality'];
    minimumOrder = json['minimum_order'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.aId;
    data['delivery_type'] = this.deliveryType;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['owner_name'] = this.ownerName;
    data['open_time'] = this.openTime;
    data['store_category'] = this.storeCategory;
    data['close_time'] = this.closeTime;
    data['thumbnail'] = this.thumbnail;
    data['locality'] = this.locality;
    data['minimum_order'] = this.minimumOrder;
    data['__v'] = this.iV;
    return data;
  }
}

class Categories {
  String sId;
  List<Products> products;
  String name;
  String description;
  String imgUrl;
  String store;
  int iV;

  Categories(
      {this.sId,
        this.products,
        this.name,
        this.description,
        this.imgUrl,
        this.store,
        this.iV});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    name = json['name'];
    description = json['description'];
    imgUrl = json['img_url'];
    store = json['store'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['img_url'] = this.imgUrl;
    data['store'] = this.store;
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  String sId;
  String status;
  List<String> images;
  int rating;
  List<Variants> variants;
  String name;
  String store;
  String slabAmt;
  int iV;

  Products(
      {this.sId,
        this.status,
        this.images,
        this.rating,
        this.variants,
        this.name,
        this.store,
        this.slabAmt,
        this.iV});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    images = json['images'].cast<String>();
    rating = json['rating'];
    if (json['variants'] != null) {
      variants = new List<Variants>();
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    name = json['name'];
    store = json['store'];
    slabAmt = json['slab_amt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['rating'] = this.rating;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['store'] = this.store;
    data['slab_amt'] = this.slabAmt;
    data['__v'] = this.iV;
    return data;
  }
}

class Variants {
  String status;
  String sId;
  String name;
  int mrp;
  int discountedPrice;
  double weight;
  int threshold;
  String description;

  Variants(
      {this.status,
        this.sId,
        this.name,
        this.mrp,
        this.discountedPrice,
        this.weight,
        this.threshold,
        this.description});

  Variants.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    mrp = json['mrp'];
    discountedPrice = json['discounted_price'];
    weight = json['weight'];
    threshold = json['threshold'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mrp'] = this.mrp;
    data['discounted_price'] = this.discountedPrice;
    data['weight'] = this.weight;
    data['threshold'] = this.threshold;
    data['description'] = this.description;
    return data;
  }
}
