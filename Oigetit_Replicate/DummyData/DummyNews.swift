//
//  DummyNews.swift
//  Oigetit_Replicate
//
//  Created by M Zaidaan Nugroho on 28/02/26.
//


let dummyNews = """
{
  "status": "ok",
  "articles": [
    {
      "id": "A1B2C3D4-E5F6-7890-1234-56789ABCDEF0",
      "title": "Tech Giant Announces Revolutionary New Silicon Chip for Mobile",
      "thumbnail": "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=400&auto=format&fit=crop",
      "categories": ["Technology", "Breaking"],
      "publishedAt": "2026-02-28T09:30:00Z",
      "publisher": "Tech Insider",
      "score": {
          "reliability": 80,
          "sentiment": "positive"
        }
    },
    {
      "id": "B2C3D4E5-F6A7-8901-2345-6789ABCDEF01",
      "title": "Global Markets Rally as New Inflation Data Shows Cooling Trends",
      "thumbnail": "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?q=80&w=400&auto=format&fit=crop",
      "categories": ["Conservative", "Breaking"],
      "publishedAt": "2026-02-28T06:15:00Z",
      "publisher": "Market Watch",
      "score": {
          "reliability": 68,
          "sentiment": "neutral"
        }
    },
    {
      "id": "C3D4E5F6-A7B8-9012-3456-789ABCDEF012",
      "title": "Exploring the Hidden Gems of the Mediterranean Coastline",
      "thumbnail": "https://images.unsplash.com/photo-1499856871958-5b9627545d1a?q=80&w=400&auto=format&fit=crop",
      "categories": ["Entertainment", "Breaking"],
      "publishedAt": "2026-02-27T14:20:00Z",
      "publisher": "Wanderlust Mag",
      "score": {
          "reliability": 63,
          "sentiment": "neutral"
        }
    },
    {
      "id": "D4E5F6A7-B8C9-0123-4567-89ABCDEF0123",
      "title": "Championship Finals: Underdog Team Secures Historic Victory",
      "thumbnail": "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=400&auto=format&fit=crop",
      "categories": ["Sports", "Breaking"],
      "publishedAt": "2026-02-26T20:45:00Z",
      "publisher": "Sports Daily",
      "score": {
          "reliability": 28,
          "sentiment": "positive"
        }
    },
    {
      "id": "E5F6A7B8-C9D0-1234-5678-9ABCDEF01234",
      "title": "New Study Reveals the Surprising Health Benefits of Morning Coffee",
      "thumbnail": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=400&auto=format&fit=crop",
      "categories": ["Liberal", "Breaking"],
      "publishedAt": "2026-02-25T11:00:00Z",
      "publisher": "MedJournal",
      "score": {
          "reliability": 90,
          "sentiment": "neutral"
        }
    },
    {
      "id": "F6A7B8C9-D0E1-2345-6789-ABCDEF012345",
      "title": "Space Agency Releases Stunning New Images of Distant Galaxy",
      "thumbnail": "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?q=80&w=400&auto=format&fit=crop",
      "categories": ["Breaking"],
      "publishedAt": "2026-02-28T10:05:00Z",
      "publisher": "AstroWeekly",
      "score": {
          "reliability": 100,
          "sentiment": "negative"
        }
    },
    {
      "id": "1A2B3C4D-5E6F-7A8B-9C0D-1E2F3A4B5C6D",
      "title": "Next-Gen Electric Vehicles Promise 1,000-Mile Range on Single Charge",
      "thumbnail": "https://images.unsplash.com/photo-1593941707882-a5bba14938c7?q=80&w=400&auto=format&fit=crop",
      "categories": ["Technology"],
      "publishedAt": "2026-02-28T08:20:00Z",
      "publisher": "AutoTech Today",
      "score": {
          "reliability": 68,
          "sentiment": "negative"
        }
    },
    {
      "id": "7E8F9A0B-1C2D-3E4F-5A6B-7C8D9E0F1A2B",
      "title": "Critically Acclaimed Indie Film Sweeps Major Award Categories",
      "thumbnail": "https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=400&auto=format&fit=crop",
      "categories": ["Entertainment", "Breaking"],
      "publishedAt": "2026-02-27T22:15:00Z",
      "publisher": "Cinema Scene",
      "score": {
          "reliability": 48,
          "sentiment": "neutral"
        }
    },
    {
      "id": "3C4D5E6F-7A8B-9C0D-1E2F-3A4B5C6D7E8F",
      "title": "Major Retail Giants Announce Shocking $50 Billion Merger",
      "thumbnail": "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=400&auto=format&fit=crop",
      "categories": ["Liberal"],
      "publishedAt": "2026-02-27T16:45:00Z",
      "publisher": "Financial Times",
      "score": {
          "reliability": 76,
          "sentiment": "negative"
        }
    },
    {
      "id": "9C0D1E2F-3A4B-5C6D-7E8F-9A0B1C2D3E4F",
      "title": "Breakthrough in Renewable Energy: Solar Panels Now 40% More Efficient",
      "thumbnail": "https://images.unsplash.com/photo-1509391366360-2e959784a276?q=80&w=400&auto=format&fit=crop",
      "categories": ["Conservative"],
      "publishedAt": "2026-02-27T09:00:00Z",
      "publisher": "EcoWorld",
      "score": {
          "reliability": 24,
          "sentiment": "positive"
        }
    },
    {
      "id": "5A6B7C8D-9E0F-1A2B-3C4D-5E6F7A8B9C0D",
      "title": "World's Top Chefs Gather for Annual Culinary Innovation Summit",
      "thumbnail": "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=400&auto=format&fit=crop",
      "categories": ["Video"],
      "publishedAt": "2026-02-26T18:30:00Z",
      "publisher": "Gourmet Gazette",
      "score": {
          "reliability": 83,
          "sentiment": "negative"
        }
    },
    {
      "id": "1E2F3A4B-5C6D-7E8F-9A0B-1C2D3E4F5A6B",
      "title": "Highly Anticipated Virtual Reality Headset Finally Hits Store Shelves",
      "thumbnail": "https://images.unsplash.com/photo-1622979135225-d2ba269cf1ac?q=80&w=400&auto=format&fit=crop",
      "categories": ["Entertainment"],
      "publishedAt": "2026-02-26T14:10:00Z",
      "publisher": "Tech Play",
      "score": {
          "reliability": 59,
          "sentiment": "positive"
        }
    },
    {
      "id": "7C8D9E0F-1A2B-3C4D-5E6F-7A8B9C0D1E2F",
      "title": "Architects Unveil Plans for First Fully Sustainable Floating City",
      "thumbnail": "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=400&auto=format&fit=crop",
      "categories": ["Video"],
      "publishedAt": "2026-02-25T13:45:00Z",
      "publisher": "Design Daily",
      "score": {
          "reliability": 76,
          "sentiment": "neutral"
        }
    },
    {
      "id": "D0E12345-6789-ABCDEF-0123-456789ABCDEF",
      "title": "How Artificial Intelligence is Reshaping Modern Classrooms",
      "thumbnail": "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=400&auto=format&fit=crop",
      "categories": ["AI"],
      "publishedAt": "2026-02-25T08:50:00Z",
      "publisher": "EdTech Review",
      "score": {
          "reliability": 32,
          "sentiment": "negative"
        }
    },
    {
      "id": "A1B2C3D4-E5F6-7890-ABCD-EF1234567890",
      "title": "Spring Fashion Week Debuts Bold Colors and Retro Silhouettes",
      "thumbnail": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=400&auto=format&fit=crop",
      "categories": ["Liberal"],
      "publishedAt": "2026-02-24T20:00:00Z",
      "publisher": "Style Maven",
      "score": {
          "reliability": 40,
          "sentiment": "positive"
        }
    }
  ]
}
"""
