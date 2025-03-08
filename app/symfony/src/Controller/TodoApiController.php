<?php

namespace App\Controller;

use App\Repository\TodoRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

final class TodoApiController extends AbstractController
{
    #[Route('/api/todos', name: 'api_todos')]
    public function index(TodoRepository $todoRepository): JsonResponse
    {
        $todos = $todoRepository->findAll();
        return $this->json($todos);
    }
}
