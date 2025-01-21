Return-Path: <linux-edac+bounces-2933-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D0A1836B
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AA816973C
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451521F709E;
	Tue, 21 Jan 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUivF2ei"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BF1F5439;
	Tue, 21 Jan 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482156; cv=none; b=j8vzc9kYnIz1HTeS7GCJMZvzHR5RdFHL/7HgzNjNxC+YaRGZ5Z20exHfZ1bK300VQBps9LcyT+Nnp4pRdJT9uB4nASn3+uXdOxQ4YkYilGGvXmKVfpiwqlsbcZUf7hIQBeEI1x93vLfzK1CtCwCDIIdh7FIsbtVNQoaUNub2KKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482156; c=relaxed/simple;
	bh=ZFMEt+O3xKN83s1e1kJkxCEaCYfTt5DjGGhLfJSfm+Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MBZ6McuH8H0OPixIzgMfldYJCRpxuVxMi68nCrV0kmKBgU7e8cMgvy6suoOIYxXd7e7wetnRA9nTBGQVwffr0VE0T3pc+Wsev9DZg+rdHGtqcbbJVtgys8IjrOG9OkLyiFF4A2gPYvllwGBYXKdo8u2p/L5Pvk5T35qqJeGbbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUivF2ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F203AC4CEDF;
	Tue, 21 Jan 2025 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737482156;
	bh=ZFMEt+O3xKN83s1e1kJkxCEaCYfTt5DjGGhLfJSfm+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jUivF2eiyi7RwiC2+Mu4LCP1y+U8ZQaR8UlGi5Pvh1inFPkEllGz5c0z6Yi5f8vw8
	 UJa4+dfn4f3SXgiCkZ+HECjpUM++5QRIC+mwoc7n8svei3rVb8xlA7L4EUTuHlKsop
	 McNMC3NQds+rUSAbujZGEWD3q4jo+syoTYvHedzNv2/iRJYeN084RG3nY5fkCE5eYb
	 3GXUpAJV2Iiqz+kxR6dNIkHVefronUZo2fp4O7G9QJHVlNG1nZihTytnMWF4uJM1Ho
	 g+f9P0jAN3/Gf3Xtzm+iQxY8u8f3+FQLoxYrva4K1iCjZR+HS+uBgoniQXQ8At977/
	 QTRoRB09MUc9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716F9380AA75;
	Tue, 21 Jan 2025 17:56:21 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118110917.GAZ4uL3XJE4ICoZfx8@fat_crate.local>
References: <20250118110917.GAZ4uL3XJE4ICoZfx8@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118110917.GAZ4uL3XJE4ICoZfx8@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.14
X-PR-Tracked-Commit-Id: 368736db4d1c317ad065a1c827b09cfac942e05a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0763dd892855aca05c4b45bc3a5da439d5f009ae
Message-Id: <173748217999.75120.4841596750887431242.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 17:56:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 12:09:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0763dd892855aca05c4b45bc3a5da439d5f009ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

