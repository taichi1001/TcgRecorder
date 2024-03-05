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

interface Tag {
    tag_id: number
    tag: string
    game_id: number
}

interface Tags {
    index: number
    tags: Tag[]
}

export interface UserRecord {
    record_id: number
    date: Date
    winLoss: number
    gameid: number
    useDeckid: number
    opponentDeckid: number
    tagid?: number
    bo?: number
    firstMatchFirstSecond?: number
    secondMatchFirstSecond?: number
    thirdMatchFirestSecond?: number
}

interface UserRecords {
    index: number
    records: UserRecord[]
}