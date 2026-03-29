import { TmEvent, TmVenue } from './ticketmaster.types';

/** Clean event summary for list views. */
export interface EventSummaryDto {
  id: string;
  name: string;
  date: string;
  time: string | null;
  dateTime: string | null;
  image: string;
  city: string;
  state: string;
  venueName: string;
  category: string;
  genre: string;
  priceMin: number | null;
  priceMax: number | null;
  currency: string;
  status: string;
  url: string;
}

/** Full event detail for single event page. */
export interface EventDetailDto extends EventSummaryDto {
  dateTBD: boolean;
  images: string[];
  description: string;
  note: string;
  salesStart: string | null;
  salesEnd: string | null;
  attractions: { id: string; name: string }[];
  venue: VenueDto | null;
}

/** Clean venue object. */
export interface VenueDto {
  id: string;
  name: string;
  address: string;
  city: string;
  state: string;
  country: string;
  latitude: number | null;
  longitude: number | null;
  timezone: string;
  imageUrl: string;
}

/** Pick the best image: 16_9 non-fallback → 16_9 any → first image → empty */
function pickImage(images: { url: string; ratio: string; fallback: boolean }[]): string {
  if (!images?.length) return '';
  const best = images.find((i) => i.ratio === '16_9' && !i.fallback);
  if (best) return best.url;
  const any16 = images.find((i) => i.ratio === '16_9');
  if (any16) return any16.url;
  return images[0].url;
}

/** Get all 16_9 images, deduped. Falls back to all images if none match. */
function pickAllImages(images: { url: string; ratio: string }[]): string[] {
  if (!images?.length) return [];
  const wide = images.filter((i) => i.ratio === '16_9').map((i) => i.url);
  if (wide.length) return [...new Set(wide)];
  return [...new Set(images.map((i) => i.url))];
}

export function transformVenue(venue?: TmVenue): VenueDto | null {
  if (!venue) return null;
  return {
    id: venue.id,
    name: venue.name,
    address: venue.address?.line1 ?? '',
    city: venue.city?.name ?? '',
    state: venue.state?.stateCode ?? '',
    country: venue.country?.countryCode ?? '',
    latitude: venue.location?.latitude
      ? parseFloat(venue.location.latitude)
      : null,
    longitude: venue.location?.longitude
      ? parseFloat(venue.location.longitude)
      : null,
    timezone: venue.timezone ?? '',
    imageUrl: venue.images ? pickImage(venue.images as any) : '',
  };
}

export function transformToEventSummary(event: TmEvent): EventSummaryDto {
  const venue = event._embedded?.venues?.[0];
  const classification = event.classifications?.find((c) => c.primary) ??
    event.classifications?.[0];

  return {
    id: event.id,
    name: event.name,
    date: event.dates.start.localDate,
    time: event.dates.start.localTime ?? null,
    dateTime: event.dates.start.dateTime ?? null,
    image: pickImage(event.images),
    city: venue?.city?.name ?? '',
    state: venue?.state?.stateCode ?? '',
    venueName: venue?.name ?? '',
    category: classification?.segment?.name ?? 'Other',
    genre: classification?.genre?.name ?? '',
    priceMin: event.priceRanges?.[0]?.min ?? null,
    priceMax: event.priceRanges?.[0]?.max ?? null,
    currency: event.priceRanges?.[0]?.currency ?? 'USD',
    status: event.dates.status.code,
    url: event.url,
  };
}

export function transformToEventDetail(event: TmEvent): EventDetailDto {
  const summary = transformToEventSummary(event);
  return {
    ...summary,
    dateTBD: event.dates.start.dateTBD,
    images: pickAllImages(event.images),
    description: event.info ?? event.pleaseNote ?? '',
    note: event.pleaseNote ?? '',
    salesStart: event.sales?.public?.startDateTime ?? null,
    salesEnd: event.sales?.public?.endDateTime ?? null,
    attractions:
      event._embedded?.attractions?.map((a) => ({
        id: a.id,
        name: a.name,
      })) ?? [],
    venue: transformVenue(event._embedded?.venues?.[0]),
  };
}
