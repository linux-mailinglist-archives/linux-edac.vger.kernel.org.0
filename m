Return-Path: <linux-edac+bounces-4327-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC8AFA765
	for <lists+linux-edac@lfdr.de>; Sun,  6 Jul 2025 21:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85719175AE1
	for <lists+linux-edac@lfdr.de>; Sun,  6 Jul 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225B19D8A3;
	Sun,  6 Jul 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnmC/29A"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABDE55B;
	Sun,  6 Jul 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751828573; cv=none; b=f7B8yJm9r6l/q+Mr0w9tCmMzIXeW+EiCVYavtlwPlvhssFmO54fcQqNv08zqPpxWb3n5leHsu542XEPvYoGebdxlR0CZaLUMDX/EOHknJuNo8D6s629aoskkxW4JNjuvYUKSxXylIUcvjmJFEfyBWXVJ6u4ne/Yab/kJAE7WHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751828573; c=relaxed/simple;
	bh=Zj5/mVFiVPSvGjvNl0UcCtXfLmpf3AUOo6DSq7jYWvU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sNOMNAE8Cbv8hRpBHA0zWuxEyI6b8dJHuXLc1dldIxEIEP4AifC0ZH/8iV0JAhPpZZnImUnhCkYzy7gZc+yuxNO4yk7x3FEuJYhAFAi5rs+t187IGtYRBfEeSjvtL4FjyVsAfyrubqywDqsrLY8zXQ5twWWG+hz1STmOp5WG5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnmC/29A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D7C4CEED;
	Sun,  6 Jul 2025 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751828573;
	bh=Zj5/mVFiVPSvGjvNl0UcCtXfLmpf3AUOo6DSq7jYWvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UnmC/29A4psYUkJlxoPHM/PomOKt6Lq2+pOhX7flv15wdsOl31B4p3XMlgfMsOn1z
	 HvBfSqn8xBdp6OpEAG0pp5wTG8ZLflJhjoF7CHXcKZNiR82QwCTLV2UhfbrvxE+qpY
	 qZ/X8CoLi0R57sBPlrKKqzyoXaTbGcNyTBigD7F0Qdr0O174Hb41s8AxF0vZKghR2R
	 6EQfblYQ0JWQQgCUEbLuFwXSAkzX9FnUbN/rt+B+FDsW/ozPt0VhCHZCRK2O5jw7NP
	 GjEW3I/oDgAWlNDGb+H+rcHT+iRfRfhJs2oDVBGy5simzFD/mcwuAmCKfvpVNu+Nsl
	 9ZW4WEsFD4t7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB16A38111DD;
	Sun,  6 Jul 2025 19:03:17 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250706080410.GAaGot-nOKs75u4yKR@fat_crate.local>
References: <20250706080410.GAaGot-nOKs75u4yKR@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250706080410.GAaGot-nOKs75u4yKR@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc5
X-PR-Tracked-Commit-Id: 1e14ea901dc8d976d355ddc3e0de84ee86ef0596
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c92bda4cb96970b78037d52cfae43844044744b1
Message-Id: <175182859650.2712443.13893763597749246505.pr-tracker-bot@kernel.org>
Date: Sun, 06 Jul 2025 19:03:16 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 6 Jul 2025 10:04:10 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c92bda4cb96970b78037d52cfae43844044744b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

