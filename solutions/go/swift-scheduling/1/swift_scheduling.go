package swiftscheduling

import (
	"strconv"
	"strings"
	"time"
)

func DeliveryDate(start, delivery string) string {
	const layout = "2006-01-02T15:04:05"
	t, err := time.Parse(layout, start)
	if err != nil {
		return "unknown"
	}

	isWorkday := func(d time.Time) bool {
		wd := d.Weekday()
		return wd != time.Saturday && wd != time.Sunday
	}
	firstWorkdayOfMonth := func(year int, month time.Month, loc *time.Location) time.Time {
		d := time.Date(year, month, 1, 0, 0, 0, 0, loc)
		for !isWorkday(d) {
			d = d.AddDate(0, 0, 1)
		}
		return d
	}
	lastWorkdayOfQuarter := func(year, q int, loc *time.Location) time.Time {
		month := time.Month(q * 3)
		nextMonth := month + 1
		nextYear := year
		if month == 12 {
			nextMonth = 1
			nextYear = year + 1
		}
		d := time.Date(nextYear, nextMonth, 1, 0, 0, 0, 0, loc).AddDate(0, 0, -1)
		for !isWorkday(d) {
			d = d.AddDate(0, 0, -1)
		}
		return d
	}

	switch delivery {
	case "NOW":
		return t.Add(2 * time.Hour).Format(layout)
	case "ASAP":
		if t.Hour() < 13 {
			res := time.Date(t.Year(), t.Month(), t.Day(), 17, 0, 0, 0, t.Location())
			return res.Format(layout)
		}
		nd := t.AddDate(0, 0, 1)
		res := time.Date(nd.Year(), nd.Month(), nd.Day(), 13, 0, 0, 0, t.Location())
		return res.Format(layout)
	case "EOW":
		wd := t.Weekday()
		if wd >= time.Monday && wd <= time.Wednesday {
			daysUntilFriday := (int(time.Friday) - int(wd) + 7) % 7
			target := t.AddDate(0, 0, daysUntilFriday)
			res := time.Date(target.Year(), target.Month(), target.Day(), 17, 0, 0, 0, t.Location())
			return res.Format(layout)
		}
		daysUntilSunday := (int(time.Sunday) - int(wd) + 7) % 7
		target := t.AddDate(0, 0, daysUntilSunday)
		res := time.Date(target.Year(), target.Month(), target.Day(), 20, 0, 0, 0, t.Location())
		return res.Format(layout)
	default:
		// handle "nM" (month) pattern
		if base, ok := strings.CutSuffix(delivery, "M"); ok {
			n, err := strconv.Atoi(base)
			if err == nil && n >= 1 && n <= 12 {
				year := t.Year()
				candidate := firstWorkdayOfMonth(year, time.Month(n), t.Location())
				if !candidate.After(t) {
					candidate = firstWorkdayOfMonth(year+1, time.Month(n), t.Location())
				}
				res := time.Date(candidate.Year(), candidate.Month(), candidate.Day(), 8, 0, 0, 0, t.Location())
				return res.Format(layout)
			}
		}
		// handle "Qn" (quarter) pattern
		if base, ok := strings.CutPrefix(delivery, "Q"); ok {
			qn, err := strconv.Atoi(base)
			if err == nil && qn >= 1 && qn <= 4 {
				year := t.Year()
				target := lastWorkdayOfQuarter(year, qn, t.Location())
				if !target.After(t) {
					target = lastWorkdayOfQuarter(year+1, qn, t.Location())
				}
				res := time.Date(target.Year(), target.Month(), target.Day(), 8, 0, 0, 0, t.Location())
				return res.Format(layout)
			}
		}
	}

	return "unknown"
}
