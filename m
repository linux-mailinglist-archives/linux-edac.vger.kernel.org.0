Return-Path: <linux-edac+bounces-4279-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED1AECEB8
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E2189386C
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B22327A3;
	Sun, 29 Jun 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh3yHB2Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24857128819;
	Sun, 29 Jun 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215194; cv=none; b=gastfXIhP0dUEROYrt7Hq/aJgGkvxlhv8HMwlo/4LqxIaw8pJvtZ6iZ1aO4ou60D9PEtyh0dXZ9dgzHlsExVTteBYUcCcl2+X4O2rbNtpnBZ+NKIbrJIQTcZyDzvKtcEC9eKDqg984O2lP4U16lGhPf3vwFsc+p+BXZeWj2D060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215194; c=relaxed/simple;
	bh=na+f677Q93r9B/vGlL7JQDCW2VUeqEdRW0DvEgwiEnc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b17NMfEO3+cCLs+TSr48fpvUC6baqe0S/tMZRZ5xzlcb3+zKEvG9HZHnQekZgvsB6zWNRbON23TcYuoShFe9ljicxpxibeujoN/HpJrVIQ5iYls82JCVb6ODBcytCX/JNHLVX8y5frdaz+Y1h0zXXRorRXz9bzmW6DShTFrFnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh3yHB2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0528BC4CEEB;
	Sun, 29 Jun 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215194;
	bh=na+f677Q93r9B/vGlL7JQDCW2VUeqEdRW0DvEgwiEnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gh3yHB2Qtxml/AHYpKCPaIOGdcSuAM1v04peky/nPTdrU8sZzZ5TgID7d7Aml4AnV
	 wuB/F/R26YpdoRYNvN0ZGPS+4j/6OCt7l95MO9e+NFybsveYDf5RLiGRhQtcRwCJdl
	 kysAUWtck3+ai9MLm2qW9fuLQnF4uVI+kxT5NZ+NyNRdTDgw3JjG7/JFnubHbtQuN4
	 rFWmRu0EZjhJimbfpggq/ozGrBiktlGJvS+8Vz8Qsu7rHaM8wRxU9qnuIlkeGJEde2
	 A60ekSFccyWzF/57yn+tZqzslSvO7M1rBUOAhK4wg9yM0qif2vIBEYt9TzmN0sSJJn
	 5plKQ2RXG9oJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6438111CE;
	Sun, 29 Jun 2025 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250629083502.GAaGD6tqBFp2YhK3Dr@fat_crate.local>
References: <20250629083502.GAaGD6tqBFp2YhK3Dr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250629083502.GAaGD6tqBFp2YhK3Dr@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc4
X-PR-Tracked-Commit-Id: a3f3040657417aeadb9622c629d4a0c2693a0f93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b1890e4b250c95cf93a0a772433c3a2300e7c8f
Message-Id: <175121521936.2432237.8001285522719133143.pr-tracker-bot@kernel.org>
Date: Sun, 29 Jun 2025 16:40:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Jun 2025 10:35:02 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b1890e4b250c95cf93a0a772433c3a2300e7c8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

