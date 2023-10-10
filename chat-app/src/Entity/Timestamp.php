<?php

namespace App\Entity;
use Doctrine\ORM\Mapping as ORM;

trait Timestamp
{
    #[ORM\Column(type: 'datetime')]
    private ? \DateTimeImmutable $createdAt;

    /**
     * @return mixed
     */
    public function getCreatedAt()
    {
        return $this->createdAt;
    }

    #[ORM\PrePersist]
    public function prePersist(){
        $this->createdAt = new \DateTimeImmutable();
    }
}