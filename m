Return-Path: <linux-edac+bounces-5654-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E5D3AAE5
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jan 2026 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE3EB3002D03
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jan 2026 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755436CE0C;
	Mon, 19 Jan 2026 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7C4jOsd"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA635CBD5;
	Mon, 19 Jan 2026 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831052; cv=none; b=sdPxN1O/W2nFPCwBuF78Waf2MqSdhmQLwYbxHLC4RepUgKGcSEIiHySr42CVJTROqwmzewubjlyWZavVaZz3Xxq43/cWdNDUj6wy+vID4tCniYAGTAB6h3CnnRCdXDDthVz0oQfb5UJO8f8WcwMf4neOi7WjfUKMHthG/Ae7X1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831052; c=relaxed/simple;
	bh=uqkyNz6ONyriAq3J5FxrPAtnLmRFgjLlOnlwfhuqFF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hOxncsgOoQIgIJFIwJHHXZ3Z32CjvSbcFADU1WgJu4NskPN6DaK+r3dyc/VNBCxkgb2y+w0x4QryzWm7PDgPElHqMOcQXpLgca4La358VfaTutHvpI+kkAb6iif1++aWTUzV0xgsGwmkeYQ8brvZCAX2X68orbXb9Qrq8+jvobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7C4jOsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C39C116C6;
	Mon, 19 Jan 2026 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831052;
	bh=uqkyNz6ONyriAq3J5FxrPAtnLmRFgjLlOnlwfhuqFF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y7C4jOsdEJ7vMqw822VaBtAp6A5lHAqs7/L+hnjxCrKlQ9g+TdmJPpwqbtJenGtfM
	 N2j8KAC82LdUaSMwXgmd0FG5w6O4HENhxb+DFI9uIFQSwIipatgRqf8+ZoKdhEDNDi
	 YKNUkk3vHvIhyXMT9adtjEiLK4nIKZPkkHUoHXSOKTXXhHL0dUTxlUTQsEC1ABf/XZ
	 cqva2SO0sQ2MsewpIEwdOLSU7HUKd+oqQL2HP2WeLNNbvGSdxFKaj6fjijX8dZspY2
	 N1WMeiTPlK+lBhECyyBQkqCYIlztonPIWiWo1ByBqi+rqYelB7K6vXYZ5pP+0Vljx4
	 TQiUC7uDCN6YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C8E3A54A38;
	Mon, 19 Jan 2026 13:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fixes for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260118111227.GAaWzAG_7QzhlSTeKe@fat_crate.local>
References: <20260118111227.GAaWzAG_7QzhlSTeKe@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260118111227.GAaWzAG_7QzhlSTeKe@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.19_rc6
X-PR-Tracked-Commit-Id: 0ff7c44106b4715fc27a2e455d9f57f1dfcfd54f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93fc4e044a0bd3840f781009f9e51b32e8e5faf9
Message-Id: <176883084146.1423140.6318984636821477363.pr-tracker-bot@kernel.org>
Date: Mon, 19 Jan 2026 13:54:01 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Jan 2026 12:12:27 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.19_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93fc4e044a0bd3840f781009f9e51b32e8e5faf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

