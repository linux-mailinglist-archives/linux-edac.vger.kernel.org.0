Return-Path: <linux-edac+bounces-1298-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53617909F23
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BD1282C38
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jun 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097115476B;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohTzT9Zw"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4D51012;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562272; cv=none; b=DMyQ+VSLvyw4oGOYVWLTVOgCLHNV8hfUa5F0sm9jMMH6bwuKQW4+MiEzmxwTFwT/4MPYbXcsqjNfJpkLWtTJPUn3Qd4Jd9GGnH2ezot69vLDJvPRrOTVhP6+89p50iulcqslWVxABCYPhd51sOOMVcgmg9jqa38t5YhdY5mceJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562272; c=relaxed/simple;
	bh=uKFb0AJTMagQkxwGTc73zoMThBSjNEuR3j9Q0Yd8fp8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EV114tJFYEDIk0eBAO5Oq2u3B0c1IaYE1eVI28Ru10d/KjllztSQUQrV9PeVIPMPWjwM02VEtpyGjVog88EexFckOwvzbJpIUqZmic1HM+tZ4ktf3xYya8sSCveQ9jzRRBGKejdOmIdnGl+znJvqLt3P9J6h7ov+z1ycPI4rrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohTzT9Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBB20C2BBFC;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562272;
	bh=uKFb0AJTMagQkxwGTc73zoMThBSjNEuR3j9Q0Yd8fp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ohTzT9ZwhkZQAvz29hcyI3Er1+6sZJ8SgwrO/gtc5Lwhwn7rzIHXws2jKOkjWW9Kk
	 Bj8PxeLhVdwChbwId0rpqcXo6X25TAJ9v2zRLauriGD49YugmHbPjaoVneTQgORWaV
	 5yh4qu5F+HjbOGmfSPXEI0/zNXQditJC8T/gpiObiMFXFn8lJBHlmSTLtkxmQctEun
	 5JoSYaduus5W7Ir1u9TMqx/2MIJAzCvzBHe6mp4i4Ebmhak4fTJrMVRwaX2nvoO7dk
	 DfiwSzh1gIfz3SkKSrpG9Z4VOTVjgKg03IsOir5GjCWZOlPQsxk93JtSzqw3Bdv41p
	 Dwa21FtWKTu+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B08D4C43616;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240616092621.GAZm6vvbHCGbc4hKz_@fat_crate.local>
References: <20240616092621.GAZm6vvbHCGbc4hKz_@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240616092621.GAZm6vvbHCGbc4hKz_@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.10_rc4
X-PR-Tracked-Commit-Id: ba437905b4fbf0ee1686c175069239a1cc292558
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e39388e430d0b170fdaf319059e719d3c6875d07
Message-Id: <171856227271.1143.18404823142288797945.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:32 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 11:26:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.10_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e39388e430d0b170fdaf319059e719d3c6875d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

