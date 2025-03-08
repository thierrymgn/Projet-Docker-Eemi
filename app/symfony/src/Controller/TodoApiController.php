<?php

namespace App\Controller;

use App\Entity\Todo;
use App\Repository\TodoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api', name: 'api_')]
class TodoApiController extends AbstractController
{
    #[Route('/todos', name: 'todos_index', methods: ['GET'])]
    public function index(TodoRepository $todoRepository): JsonResponse
    {
        $todos = $todoRepository->findBy([], ['id' => 'DESC']);

        $data = [];
        foreach ($todos as $todo) {
            $data[] = [
                'id' => $todo->getId(),
                'title' => $todo->getTitle(),
                'done' => $todo->isDone()
            ];
        }

        return $this->json($data);
    }

    #[Route('/todos', name: 'todos_create', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (empty($data['title'])) {
            return $this->json(['error' => 'Title is required'], Response::HTTP_BAD_REQUEST);
        }

        $todo = new Todo();
        $todo->setTitle($data['title']);
        $todo->setDone(false);

        $entityManager->persist($todo);
        $entityManager->flush();

        return $this->json([
            'id' => $todo->getId(),
            'title' => $todo->getTitle(),
            'done' => $todo->isDone()
        ], Response::HTTP_CREATED);
    }

    #[Route('/todos/{id}/toggle', name: 'todos_toggle', methods: ['PATCH'])]
    public function toggle(int $id, TodoRepository $todoRepository, EntityManagerInterface $entityManager): JsonResponse
    {
        $todo = $todoRepository->find($id);

        if (!$todo) {
            return $this->json(['error' => 'Todo not found'], Response::HTTP_NOT_FOUND);
        }

        $todo->setDone(!$todo->isDone());
        $entityManager->flush();

        return $this->json([
            'id' => $todo->getId(),
            'title' => $todo->getTitle(),
            'done' => $todo->isDone()
        ]);
    }

    #[Route('/todos/{id}', name: 'todos_delete', methods: ['DELETE'])]
    public function delete(int $id, TodoRepository $todoRepository, EntityManagerInterface $entityManager): JsonResponse
    {
        $todo = $todoRepository->find($id);

        if (!$todo) {
            return $this->json(['error' => 'Todo not found'], Response::HTTP_NOT_FOUND);
        }

        $entityManager->remove($todo);
        $entityManager->flush();

        return $this->json(null, Response::HTTP_NO_CONTENT);
    }

    #[Route('/', name: 'home')]
    public function home(): Response
    {
        return $this->render('todo/index.html.twig');
    }
}
