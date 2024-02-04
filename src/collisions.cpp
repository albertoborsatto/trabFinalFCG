#include "collisions.h"

bool detectColision(glm::vec4 position, glm::vec4 hitbox_min, glm::vec4 hitbox_max)
{
    if (position.x < hitbox_min.x || position.x > hitbox_max.x)
        return false; // Testa colisões no eixo X

    if (position.y < hitbox_min.y || position.y > hitbox_max.y)
        return false; // Testa colisões no eixo Y

    if (position.z < hitbox_min.z || position.z > hitbox_max.z)
        return false; // Testa colisões no eixo Z

    return true;
}

bool isPointInsideSphere(const glm::vec3& point, const BoundingSphere& sphere) {
    // Calcula a distância entre o ponto e o centro da esfera
    float distance = glm::length(point - sphere.center);

    // Compara a distância com o raio da esfera
    return distance <= sphere.radius + 0.3f;
}

bool isVectorIntersectingBox(const bbox& bbox, const glm::vec4& vector_origin, const glm::vec4& vector_direction) {
    // Calcular os parâmetros de interseção ao longo do eixo x e y
    float t_xmin = (bbox.bbox_min.x - vector_origin.x) / vector_direction.x;
    float t_xmax = (bbox.bbox_max.x - vector_origin.x) / vector_direction.x;
    float t_ymin = (bbox.bbox_min.y - vector_origin.y) / vector_direction.y;
    float t_ymax = (bbox.bbox_max.y - vector_origin.y) / vector_direction.y;

    // Verificar se há interseção nos eixos x e y
    bool intersectX = (t_xmin <= 1.0f && t_xmax >= 0.0f);
    bool intersectY = (t_ymin <= 1.0f && t_ymax >= 0.0f);

    // Se houver interseção nos dois eixos, considerar como uma interseção
    return intersectX && intersectY;
}
