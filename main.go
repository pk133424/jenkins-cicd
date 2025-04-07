package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	// Initialize router
	router := gin.Default()

	// Create HTTP server
	srv := &http.Server{
		Addr:    ":" + "9001",
		Handler: router,
	}

	router.GET("health", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{"status": "okk"})
	})

	log.Printf("Server running on port %s\n", "9001")
	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatalf("Failed to start server: %v", err)
	}

}
