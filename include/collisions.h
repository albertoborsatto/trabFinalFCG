#include <cstdio>
#include <cstdlib>
#include <vector>

#include <glm/mat4x4.hpp>
#include <glm/vec4.hpp>
#include <glm/gtc/matrix_transform.hpp>

struct BoundingSphere {
    glm::vec3 center;
    float radius;
};

struct bbox
{
    glm::vec4    bbox_min;
    glm::vec4    bbox_max;
    bool         alive;
};

bool detectColision(glm::vec4 position, glm::vec4 hitbox_min, glm::vec4 hitbox_max);
bool isVectorIntersectingBox(const bbox& bbox, const glm::vec4& vector_origin, const glm::vec4& vector_direction);
bool isPointInsideSphere(const glm::vec3& point, const BoundingSphere& sphere);