Return-Path: <linux-edac+bounces-1049-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C08C373E
	for <lists+linux-edac@lfdr.de>; Sun, 12 May 2024 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C5C1F211DB
	for <lists+linux-edac@lfdr.de>; Sun, 12 May 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9C45BEF;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AigWMD+x"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93F4500C;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530280; cv=none; b=jXLq2Z0yk4f4NxKA0w4BT9M24T11cEsdaJ/Z+ixRF9hVOwQvjoFQExi/X5GtrcxPJLoNCfTH89Sh8CUWCw7xZv1bVABe0zNkdZh+T76zL9QJu4oTEXCqdI5ZpbUZ9K5j0ObhRXfQy8y91h+oGJjqpDNaS7e6DHT/9ikNE0ONK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530280; c=relaxed/simple;
	bh=69jzUin/rmNDnbKvGfeDq9UoffkPNXUKBy0SLY7QC/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZT5AOoQ72p8gsUWg5hDjTB9uFZ28tC5FQR7vCNegTNHpZGnTWMX61NKDBqlcUtworSIL6stu+0UpD2mKKumnXb73lcs1GMW3VdHgwN1qkOMfLaaJ5dl1LP59YtyyFDPh0GCBMEDydu6xTOhgGEl4CLd7KD7UzpkWf7DGA1XWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AigWMD+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C0DEC32783;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715530280;
	bh=69jzUin/rmNDnbKvGfeDq9UoffkPNXUKBy0SLY7QC/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AigWMD+xPjSBuxXTy4w+O8eYnhkyU7EoKnBK6yRYthZxPNlChidaSPwOoZq9Wd4Z3
	 Q9AIjc6h7OovicUiwStVfa1HWEjSVnYSErHS5JOwdSA5QSPco7iFdD7ZJ9ROIEsFAj
	 fKICX+vSVbW7wVWy0YX3Hqiys5db6yia7mlBghmZVMdrr4fk7XLCiMBjTswjh3yqzc
	 UnBVUGr+dRwjCF97DyqS1cjNJee83ZWFTw7jCDX6tDqyqVk2C3OFhzMRdY7abZEii4
	 r3hUaDzY+kK0foRhm5FnwZobMGYpLnyS8Kyag1MwuTov23DK0pn+k2VQ4mwzqCxk2c
	 oJD4kXPJNMisg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B744E7C0E2;
	Sun, 12 May 2024 16:11:20 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC/urgent for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240512075732.GAZkB2bMH9QL7i1eZS@fat_crate.local>
References: <20240512075732.GAZkB2bMH9QL7i1eZS@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240512075732.GAZkB2bMH9QL7i1eZS@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9
X-PR-Tracked-Commit-Id: 591c946675d88dcc0ae9ff54be9d5caaee8ce1e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba16c1cf11c9f264b5455cb7d57267b39925409a
Message-Id: <171553028043.9930.10769346949516796843.pr-tracker-bot@kernel.org>
Date: Sun, 12 May 2024 16:11:20 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 09:57:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba16c1cf11c9f264b5455cb7d57267b39925409a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

