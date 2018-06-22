#!/usr/bin/env /usr/local/bin/node
const bitbar = require('bitbar');
const _ = require('lodash');
const request = require('request-json').createClient('https://api.github.com/');
const dotenv = require('dotenv');
const path = require('path');

dotenv.config({
  path: path.join(__dirname, '.env'),
});

const GITHUB_TOKEN = process.env.GITHUB_TOKEN;

const reasonToEmoji = (reason) => {
	switch(reason) {
		case 'mention':
			return ':memo:';
			break;
		case 'review_requested':
			return ':vertical_traffic_light:';
			break;
	}
}

request.get(`notifications?access_token=${GITHUB_TOKEN}`, (err, res, body) => {
	const groupedByReason = _.chain(body)
	.filter(x => x.reason === 'mention' || x.reason === 'review_requested')
	.filter(x => x.unread)
	.map(x => ({
		title: x.subject.title,
		url: x.subject.url.replace('api.', '').replace('repos/', '').replace('pulls', 'pull'),
		repository: x.repository.name,
		reason: x.reason
	}))
	.groupBy('reason')
	.value();

	const keys = _.keys(groupedByReason);
	const bitbarResult = keys.map(k => {
		return {
			text: reasonToEmoji(k.reason)
		}
	});

	const mentionsString = `${_.get(groupedByReason, 'mention.length', 0)}${reasonToEmoji('mention')}`;
	const reviewsString = `${_.get(groupedByReason, 'review_requested.length', 0)}${reasonToEmoji('review_requested')}`;

	const mentions = _.chain(_.get(groupedByReason, 'mention', []))
		.groupBy('repository')
		.map((v, k) => ({
			text: k,
			submenu: v.map(x => ({
				text: x.title,
				href: x.url
			}))
		}))
		.value();

	const reviews = _.chain(_.get(groupedByReason, 'review_requested', []))
		.groupBy('repository')
		.map((v, k) => ({
			text: k,
			submenu: v.map(x => ({
				text: x.title,
				href: x.url
			}))
		}))
		.value();

	bitbar([
		{
			text: `${reviewsString}${mentionsString}`
		},
		bitbar.sep,
		{
			text: mentionsString,
			submenu: mentions
		},
		{
			text: reviewsString,
			submenu: reviews
		}
	]);
});
