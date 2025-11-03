Return-Path: <linux-edac+bounces-5303-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2055C2E60C
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBA654E4339
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B82FD1C2;
	Mon,  3 Nov 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqtkZ31A"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0642EFDA5;
	Mon,  3 Nov 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211249; cv=none; b=juBLIT9EYf81OtYlUB3bBAXOjChqH0zCi+mQXOVvV/ZkjjLR2HzrH87IPS4myl0Bv4qJlvxijv1PWR2sXO7Om5bXicoJdhcvq/ItJjCDNFnvotltQHpEIpEObmlvUVB8QyxlkQfqfh65HEfmKmXOosy7AM8fwHJ1Z4dgv6qSSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211249; c=relaxed/simple;
	bh=OMVS4a5vTHm5CQ4is8lSPAja+uMe69qUq5lJcXWmYB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FJHgq1Txs11Q2FNefYcaUrUmBCpAY7pjFST5CTzd+2RTx0Ea0osNySA332BDKaQdAAy6EexKtszoCI9ynZEgh6MEVOymqctwOIjh8x8tsAz1BuNRoU7jhM1pMB2TRTZc6CcOUDNzGNtAceKOOS1gIAhT5baRJEiMfgEpwgpauWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqtkZ31A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73780C4CEE7;
	Mon,  3 Nov 2025 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762211248;
	bh=OMVS4a5vTHm5CQ4is8lSPAja+uMe69qUq5lJcXWmYB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WqtkZ31AxTGsOx54hTC6u5yISP2pPTQsi9fFFns6uKm6wOdMdGnlREhUSNgzhNWA+
	 Vknodrnh4+eafOEg5rSZKw8OdRUXhUk3IwFiOxx9fYrhfJSPgZqrcn5cgOP3TziR/r
	 WotwH4sEITqKpE2D9t9tOJJwOC0jKnp4l03lnzpB9KturTkyMQDYj4gnKCoZ3pF0G1
	 dhDyKnicFuBqNwQ1g0DZ51OnVMRF6NeIRe8mRzRlH1v3QPmObB4qESLX0fTi4K7bV3
	 6jV8wpyCQksGeX29ml0svrtEAs8JPN2Ef8NiVz1I5KM4bp/U9ReY09OadW84mxOK+G
	 KTOd4pj7xEn7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB45C3809A88;
	Mon,  3 Nov 2025 23:07:03 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251103114438.GAaQiVpgXgECnocHvE@fat_crate.local>
References: <20251103114438.GAaQiVpgXgECnocHvE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251103114438.GAaQiVpgXgECnocHvE@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc5
X-PR-Tracked-Commit-Id: 79c0a2b7abc906c7cf3c793256c6b638d7dc477f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb886cb8f3a2811430ddb7d9838e245c57e7f7c
Message-Id: <176221122260.2247133.18130206432088503298.pr-tracker-bot@kernel.org>
Date: Mon, 03 Nov 2025 23:07:02 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Nov 2025 12:44:38 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb886cb8f3a2811430ddb7d9838e245c57e7f7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

