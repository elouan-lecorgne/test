#!/bin/bash

echo "🚀 Démarrage du projet DoD Manager..."

# Vérifier qu'on est dans le bon dossier
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Erreur: Exécute ce script depuis la racine du projet (dod-project/)"
    exit 1
fi

# 1. Démarrer PostgreSQL
echo "📊 Démarrage de PostgreSQL..."
docker-compose up -d
if [ $? -ne 0 ]; then
    echo "❌ Erreur lors du démarrage de PostgreSQL"
    exit 1
fi

# 2. Attendre que PostgreSQL soit prêt
echo "⏳ Attente de PostgreSQL..."
sleep 15

# Vérifier que PostgreSQL est accessible
echo "🔍 Vérification de PostgreSQL..."
docker-compose exec -T postgres pg_isready -U dod_user
if [ $? -ne 0 ]; then
    echo "❌ PostgreSQL n'est pas accessible"
    exit 1
fi

echo "✅ PostgreSQL est prêt!"

# 3. Instructions pour démarrer backend et frontend
echo ""
echo "🎯 Maintenant, ouvre 2 terminaux et exécute :"
echo ""
echo "Terminal 1 (Backend):"
echo "cd backend && go run main.go"
echo ""
echo "Terminal 2 (Frontend):"
echo "cd frontend && npm start"
echo ""
echo "📱 URLs d'accès :"
echo "- Frontend: http://localhost:3000"
echo "- Backend API: http://localhost:8080"
echo "- Health check: http://localhost:8080/health"
echo ""
echo "👤 Comptes de test :"
echo "- alice@example.com / password123"
echo "- bob@example.com / password123"
echo "- charlie@example.com / password123"