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

// FONTE: https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-box-intersection.html (não é uma cópia completa)
bool isVectorIntersectingBox(const bbox& bbox, const glm::vec4& vector_origin, const glm::vec4& vector_direction) {
    // Calcular os parâmetros de interseção ao longo do eixo x, y e z
    float t_xmin = (bbox.bbox_min.x - vector_origin.x) / vector_direction.x;
    float t_xmax = (bbox.bbox_max.x - vector_origin.x) / vector_direction.x;
    float t_ymin = (bbox.bbox_min.y - vector_origin.y) / vector_direction.y;
    float t_ymax = (bbox.bbox_max.y - vector_origin.y) / vector_direction.y;
    float t_zmin = (bbox.bbox_min.z - vector_origin.z) / vector_direction.z;
    float t_zmax = (bbox.bbox_max.z - vector_origin.z) / vector_direction.z;

    // Encontrar os valores mínimos e máximos para os parâmetros de interseção
    float tmin = std::max(std::max(std::min(t_xmin, t_xmax), std::min(t_ymin, t_ymax)), std::min(t_zmin, t_zmax));
    float tmax = std::min(std::min(std::max(t_xmin, t_xmax), std::max(t_ymin, t_ymax)), std::max(t_zmin, t_zmax));

    // Verificar se há interseção em algum dos eixos
    bool intersect = (tmin <= tmax && tmax >= 0.0f);

    return intersect;
}

