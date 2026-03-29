/** Raw Ticketmaster Discovery API v2 response types. */

export interface TmImage {
  url: string;
  ratio: '16_9' | '3_2' | '4_3' | string;
  width: number;
  height: number;
  fallback: boolean;
}

export interface TmDateStart {
  localDate: string;
  localTime?: string;
  dateTime?: string;
  dateTBD: boolean;
  dateTBA: boolean;
  timeTBA: boolean;
  noSpecificTime: boolean;
}

export interface TmDateStatus {
  code: 'onsale' | 'offsale' | 'canceled' | 'postponed' | 'rescheduled';
}

export interface TmPriceRange {
  type: string;
  currency: string;
  min: number;
  max: number;
}

export interface TmClassification {
  primary: boolean;
  segment: { id: string; name: string };
  genre: { id: string; name: string };
  subGenre?: { id: string; name: string };
}

export interface TmVenue {
  id: string;
  name: string;
  type: string;
  url?: string;
  timezone?: string;
  address?: { line1: string };
  city?: { name: string };
  state?: { name: string; stateCode: string };
  country?: { name: string; countryCode: string };
  location?: { longitude: string; latitude: string };
  images?: TmImage[];
}

export interface TmAttraction {
  id: string;
  name: string;
  images?: TmImage[];
}

export interface TmEvent {
  id: string;
  name: string;
  type: string;
  url: string;
  locale: string;
  images: TmImage[];
  dates: {
    start: TmDateStart;
    end?: { localDate?: string };
    timezone?: string;
    status: TmDateStatus;
  };
  sales?: {
    public?: { startDateTime?: string; endDateTime?: string };
  };
  priceRanges?: TmPriceRange[];
  classifications?: TmClassification[];
  promoter?: { id: string; name: string };
  info?: string;
  pleaseNote?: string;
  _embedded?: {
    venues?: TmVenue[];
    attractions?: TmAttraction[];
  };
}

/** GOTCHA: _embedded is MISSING (not null/empty) when zero results */
export interface TmSearchResponse {
  _embedded?: { events: TmEvent[] };
  page: {
    size: number;
    totalElements: number;
    totalPages: number;
    number: number;
  };
}
