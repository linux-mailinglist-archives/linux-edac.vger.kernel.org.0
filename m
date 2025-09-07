Return-Path: <linux-edac+bounces-4734-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFEB48038
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B38189A6C4
	for <lists+linux-edac@lfdr.de>; Sun,  7 Sep 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BB27AC54;
	Sun,  7 Sep 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNtWuQXv"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B61E379B;
	Sun,  7 Sep 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757280196; cv=none; b=cseIzOjeI/foamnk1P/fOjromVm2q1+JVHzlYRG74N+edzYCqsgccVV1YagWi2+ExyztVE3q/8HjaSqOjhHKDVkKBSjpdyL/rnSu7HQ8N9bns02/L6fOeJ8AnDt9VK3ZydpzK4PxIrdm7r5mLBYt8o8WE9T+YBMrrkP9aQcTHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757280196; c=relaxed/simple;
	bh=I0s1pPH+mtabRNC+vz53i5kd4s/KZv/wifxZaOtGH5w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pnQM9SGyeH+onQG5XFBaY5ckyItetys1/otAzgHWaOkeyUfxoLlnT0Z4XXLFHSBdkQVJ9eRMhYwgqpBiFQa0WKHmJMwQ/qVNNbZ8s55OtNlJoU+6ZB5+yxNJ2v+n5Y6XoASgDtMVtd/FJBmW4UlfhJpnc1B8RPSWg/iec6nUmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNtWuQXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1B1C4CEF0;
	Sun,  7 Sep 2025 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757280196;
	bh=I0s1pPH+mtabRNC+vz53i5kd4s/KZv/wifxZaOtGH5w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uNtWuQXvubNr/HQIh06oqZe6PKdHDZdDxJiML5pIqwdVTuRVZu3zWrd79Tr83RFny
	 ejaAQuxpiiciM292mBz2C/rH/k7RE9MbKMMHBy5Bm67Usfpj4hLGVN/8WPbp7EIeKG
	 XlFKp5D8n+gIk/NpaK2MJYhvbmpdnEPmJN6ZIpnjo4O9XpElDEb1l/whTSIbfKQ2yK
	 drG3YQvE9XNcSZyxfeUIeQ8W1xmYuhHZEzv08OOFAR/9rsAd9X4++oKzQacOMFK/Iz
	 kB6bLSQ9xvG2tmsfbCof1hh34GWGH9K0DTAuyJyEYnTNPu7bIF1uALETwiCk7yUR52
	 Q8CWZvUoJGmiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5C383BF69;
	Sun,  7 Sep 2025 21:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fix for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250907114319.GAaL1v16f5XIbbkIZY@fat_crate.local>
References: <20250907114319.GAaL1v16f5XIbbkIZY@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250907114319.GAaL1v16f5XIbbkIZY@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.17_rc5
X-PR-Tracked-Commit-Id: ff2a66d21fd2364ed9396d151115eec59612b200
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c3bac60853ed8f67e42451c7810321ff1df9c7c
Message-Id: <175728020029.3128559.14553780994832706463.pr-tracker-bot@kernel.org>
Date: Sun, 07 Sep 2025 21:23:20 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Sep 2025 13:43:19 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.17_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c3bac60853ed8f67e42451c7810321ff1df9c7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

