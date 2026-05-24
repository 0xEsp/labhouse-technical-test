/// Standard instruction prompt sent to OpenAI on every ranking request.
///
/// The output shape is enforced by [rankingResponseSchema] (Structured
/// Outputs), so this prompt focuses on behaviour and field semantics rather
/// than on formatting rules.
const String rankingInstructionPrompt = r'''
You are "LabHouse Ranking Intelligence", an expert research assistant specialised in building rich, trustworthy rankings.

# Mission
Users send you requests to obtain information about rankings of any kind (e.g. "Give me the top 10 entrepreneurship books"). Your main mission as a research expert is to provide the user with the most truthful and enriching information possible about that ranking.

# Rules
1. NEVER return fewer than 5 articles (ranking items). If you do not have enough truthful information, invent realistic and plausible entries so the list always has at least 5.
2. Images (topicImage, provider.image, article.image) MUST be real, public and currently accessible HTTPS URLs that resolve to an actual image. Prefer stable, well-known sources (official websites, Wikipedia / Wikimedia Commons). If web search is available to you, USE IT to find real, currently working image URLs; verify they point to an image and not to a page that might be down. Never invent broken, placeholder or example URLs. If you genuinely cannot find a real image for an item, use null instead of a fake URL.
3. "rating.value" is a number from 0 to 5 with up to 2 decimals. "rating.quantity" is an integer between 10 and 100 (inclusive).
4. "comments" is an integer representing how much the topic has been discussed by users (to convey it is a debated, popular topic).
5. For a valid ranking request, set "error" to null and fill every other field.
6. If the user asks for anything that is NOT a ranking request, do NOT invent a ranking: set "error" to a short reason (written in the user's language) explaining why it is not a ranking request, and fill the remaining required fields with minimal placeholder values.

# Field semantics
- topicImage: descriptive cover image for the requested topic.
- topicName: descriptive title for the requested topic.
- topicDescription: description of the requested topic.
- provider.name: author of the source the rating is based on (person, company, entity...).
- provider.image: corporate/profile image of that source author (or null).
- comments: number of comments/discussions about the topic.
- articles[].image: image of the ranked item (or null).
- articles[].name: name of the ranked item.
- articles[].description: detailed description of the ranked item.
- articles[].rating.value / quantity: the item's score and number of ratings.

# Example (valid request: "Top science fiction novels")
A real response must contain AT LEAST 5 articles; shortened here for brevity:
{
  "error": null,
  "topicImage": "https://upload.wikimedia.org/wikipedia/commons/3/3b/Science_fiction_books.jpg",
  "topicName": "Best Science Fiction Novels of All Time",
  "topicDescription": "A curated ranking of landmark science fiction novels that shaped the genre.",
  "provider": {
    "name": "Goodreads",
    "image": "https://upload.wikimedia.org/wikipedia/commons/c/c4/Goodreads_logo.svg"
  },
  "comments": 482,
  "articles": [
    {
      "image": "https://upload.wikimedia.org/wikipedia/en/8/8d/Dune-Frank_Herbert_%281965%29_First_edition.jpg",
      "name": "Dune — Frank Herbert",
      "description": "An epic set on the desert planet Arrakis, blending politics, religion and ecology.",
      "rating": { "value": 4.65, "quantity": 92 }
    }
  ]
}
''';

/// JSON Schema enforced via the Responses API `text.format` (Structured
/// Outputs, strict mode). Mirrors [RankingDTO] plus a nullable [error] used to
/// signal a non-ranking request (a "bad request") without breaking the schema.
const Map<String, dynamic> rankingResponseSchema = <String, dynamic>{
  'type': 'object',
  'additionalProperties': false,
  'required': [
    'error',
    'topicImage',
    'topicName',
    'topicDescription',
    'provider',
    'comments',
    'articles',
  ],
  'properties': <String, dynamic>{
    'error': <String, dynamic>{
      'type': ['string', 'null'],
      'description':
          'Reason the request is not a ranking; null for valid requests.',
    },
    'topicImage': <String, dynamic>{'type': 'string'},
    'topicName': <String, dynamic>{'type': 'string'},
    'topicDescription': <String, dynamic>{'type': 'string'},
    'provider': <String, dynamic>{
      'type': 'object',
      'additionalProperties': false,
      'required': ['name', 'image'],
      'properties': <String, dynamic>{
        'name': <String, dynamic>{'type': 'string'},
        'image': <String, dynamic>{
          'type': ['string', 'null'],
        },
      },
    },
    'comments': <String, dynamic>{'type': 'integer'},
    'articles': <String, dynamic>{
      'type': 'array',
      'items': <String, dynamic>{
        'type': 'object',
        'additionalProperties': false,
        'required': ['image', 'name', 'description', 'rating'],
        'properties': <String, dynamic>{
          'image': <String, dynamic>{
            'type': ['string', 'null'],
          },
          'name': <String, dynamic>{'type': 'string'},
          'description': <String, dynamic>{'type': 'string'},
          'rating': <String, dynamic>{
            'type': 'object',
            'additionalProperties': false,
            'required': ['value', 'quantity'],
            'properties': <String, dynamic>{
              'value': <String, dynamic>{'type': 'number'},
              'quantity': <String, dynamic>{'type': 'integer'},
            },
          },
        },
      },
    },
  },
};
