package thuc.ute.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor

@NamedQuery(
        name = "Product.findAll",
        query = "SELECT p FROM Product p"
)
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductId")
    private int productId;

    @Column(
            name = "ProductName",
            columnDefinition = "NVARCHAR(255)",
            nullable = false
    )
    private String productName;

    @Column(name = "Price", nullable = false)
    private double price;

    @Column(name = "Quantity")
    private Integer quantity = 0;

    @Column(
            name = "Description",
            columnDefinition = "NVARCHAR(1000)"
    )
    private String description;

    @Column(
            name = "Image",
            columnDefinition = "NVARCHAR(500)"
    )
    private String image;

    @Column(name = "Status")
    private int status;

    @Column(name = "CreatedDate")
    private LocalDateTime createdDate;

    @ManyToOne
    @JoinColumn(
            name = "CategoryId",
            nullable = false
    )
    private Category category;
}
