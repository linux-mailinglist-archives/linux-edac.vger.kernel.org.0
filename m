Return-Path: <linux-edac+bounces-4946-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D4BAE94E
	for <lists+linux-edac@lfdr.de>; Tue, 30 Sep 2025 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FDB2A0DC5
	for <lists+linux-edac@lfdr.de>; Tue, 30 Sep 2025 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238D2951B3;
	Tue, 30 Sep 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYbbGBfx"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57714D283;
	Tue, 30 Sep 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266179; cv=none; b=Z2lhG20PHGOuiuEE7HoC9TSFwe6X2mVSc1qZ4aN+zPRqHyhzeEzAwA47iGMCi2XFfYxq/f8P7LWgXtT6dgYDvs3o6tXD1iDrWypFJLzMWJDhI0LdmiYy8z8ubTbXyweEChORWmBEv1CApSvsTL6qH8kS9FoYy9AkgUIEGoRO9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266179; c=relaxed/simple;
	bh=zdKXHupSwHD2QniYvZ8Ev0ZUTzUJl6021DtNsajZWQo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hlTjIy1NS5/s4UZvjCVZ9BForXdZSkvInnSeO6OBTH89ddM3n6KjMRogtsu6SM3LvrFAy4FFrkmzQSaIQq8bkyGWvfvfIQcuKVlt7X8Vvm6qEjmRtHJANI6O3o1/gkyVlfhpQQND3tpVPXwefIPN6ezFQxTqFZMYEtKt+soqv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYbbGBfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A2DC4CEF0;
	Tue, 30 Sep 2025 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266179;
	bh=zdKXHupSwHD2QniYvZ8Ev0ZUTzUJl6021DtNsajZWQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lYbbGBfxmLXmbBejiFgvo1WjBFtUqu4Le4KmSn73DD04oF8HwihhycvySbv2PghjN
	 8VKH9BF3Yl3hIexgw8e02fqX8rYm73tE8JinB/2CYhLNo+asfGkaULkjaCKq84IJx8
	 FRa+0AoY0yM5TSzYaH3ipFSnGEVA+Q2+Zdhf+Y9dOo4aWr7CJ7ovgDors7IlGcHoEP
	 WPzYRFRc808wfBVAFqgw7EDw47PBOVyYpP3c1hC1FmY44mVnOvNPcVZ60t3e+SBHpy
	 cSI/FZqOxfSMtVG01H8t//PdK44KiT7NRGqF0GEdvrac9FvaNHCmqIXxJzQJpkVMan
	 bMlmqTh/r0YKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D5839D0C1A;
	Tue, 30 Sep 2025 21:02:53 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926094948.GAaNZhvEm0mULL_iSp@fat_crate.local>
References: <20250926094948.GAaNZhvEm0mULL_iSp@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926094948.GAaNZhvEm0mULL_iSp@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.18
X-PR-Tracked-Commit-Id: 69ed025aeb4c8faa3019e5997b850a554b47498c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03f76ddff5b04a808ae16c06418460151e2fdd4b
Message-Id: <175926617211.2146267.362347759705201624.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:02:52 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 11:49:48 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03f76ddff5b04a808ae16c06418460151e2fdd4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

