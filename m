Return-Path: <linux-edac+bounces-5447-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F8C6173B
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1054EBECC
	for <lists+linux-edac@lfdr.de>; Sun, 16 Nov 2025 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3530C618;
	Sun, 16 Nov 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PafYj+Ja"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91730C610;
	Sun, 16 Nov 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763305988; cv=none; b=gn4ZsB2ack01CAkIRfFZSfolLVOO97rJ1qktBb8GNG+XV9O2z4LJIIAGbL4C0ntDcm5tW/puuR3EPOPxfhV8clpHs8h92Ay/4qR6mBOvGloBwfeAEjScW2FJF9XM9TtycSiJzIpxNLVLqMV26eROeaDVXkkUKiP77L6Hc+sJq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763305988; c=relaxed/simple;
	bh=M9pCgDpCYThHs3xl1BFDbX1tX6I/H0NeYOevmFt69mY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EnKGM3qSxkBW9TIIGbsvgPAhfcwVbzjguE68JlLfnc8BbvMPMYKQkqUVmexIBxg9gYWbeP+KrYTBKHvNqOqxNybGyM0vTCr7hqX3yzqTtvvXjDT/xXEqGXeG7czV6/Z46qOGAVLcoHAqB2C99EXBu/G+acxevwAfxFK1wzjgBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PafYj+Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4EAC113D0;
	Sun, 16 Nov 2025 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763305984;
	bh=M9pCgDpCYThHs3xl1BFDbX1tX6I/H0NeYOevmFt69mY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PafYj+JahEUBLE49eig4y5fl/w0VVeW7uQTzFiWzQkjmzcnF21631jgnrhm3qObUC
	 Te6K2junJ/xfEE5Fc/4LETofqnz7LBASkrWGebE7T95GPJevTkUyqan+JFD6hRABfJ
	 atTQEK3mD50IwRKUATyWKqUyFn0FH6ki4o0/QCs5+eGbpz5Q6Pn+T+pCXGZPB7Nclv
	 p37o4TfWqu/xmZlyDYQTVdpVIj1S0qzU2MY6SmfnHXiMxN9BgJLPZzEaB7L1aKcQl4
	 XzsPJqExhoR2ZUaqSke9db4T9+xDgG+7gqHR8mhvAIQkz/bQstZ1eD8bvak21h9IBI
	 wK+W5uccp83qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2273A78ACF;
	Sun, 16 Nov 2025 15:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251116105140.GAaRmsvNHdHys6awJr@fat_crate.local>
References: <20251116105140.GAaRmsvNHdHys6awJr@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251116105140.GAaRmsvNHdHys6awJr@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc6
X-PR-Tracked-Commit-Id: 281326be67252ac5794d1383f67526606b1d6b13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87751e715e23ede7386fb57a1a8593aa9830b21f
Message-Id: <176330595144.2263355.8715428166163760371.pr-tracker-bot@kernel.org>
Date: Sun, 16 Nov 2025 15:12:31 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Nov 2025 11:51:40 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.18_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87751e715e23ede7386fb57a1a8593aa9830b21f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

