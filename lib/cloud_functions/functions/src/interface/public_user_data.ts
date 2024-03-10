export interface PublicUserData {
    games: Games[]
    decks: Decks[]
    tags: Tags[]
    records: UserRecords[]
}

export interface Game {
    game_id: number
    game: string
}

interface Games {
    index: number
    games: Game[]
}

export interface Deck {
    deck_id: number
    deck: string
    game_id: number
}

interface Decks {
    index: number
    decks: Deck[]
}

export interface Tag {
    tag_id: number
    tag: string
    game_id: number
}

interface Tags {
    index: number
    tags: Tag[]
}

export interface UserRecord {
    author?: string
    bo: number
    date: Date
    first_match_first_second?: number
    first_match_win_loss?: number
    first_second: number
    game_id: number
    image_path?: string
    memo?: string
    opponent_deck_id: number
    record_id: number
    second_match_first_second?: number
    second_match_win_loss?: number
    tag_id?: string | null
    third_match_first_second?: number
    third_match_win_loss?: number
    use_deck_id: number
    win_loss: number
}

interface UserRecords {
    index: number
    records: UserRecord[]
}