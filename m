Return-Path: <linux-edac+bounces-3823-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C184AAA873F
	for <lists+linux-edac@lfdr.de>; Sun,  4 May 2025 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C33F1893331
	for <lists+linux-edac@lfdr.de>; Sun,  4 May 2025 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A01D86F6;
	Sun,  4 May 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l00nyxN3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392E1D79A5;
	Sun,  4 May 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746372142; cv=none; b=mgUxo/12qzD98h3guuyjEGQci66pOfV/DI3EW0WslwUozm9UVQbM3fj/1C+fHaqCEMBEHhni32cp5Nlx6ixvkHsQF7oi/inRVf66AufMG2MHPI0ppfyjzfP+96xZA8eQnub9bPCp+ihoEyeit/SLe2Tu9Cb9nuwPd7ZGYLpdbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746372142; c=relaxed/simple;
	bh=fpvqb7kTlOOuUN70MgJgEf3UkSdSGeqD6Y1imEuSwAk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ogp5FzFvOAC1HM1PzjoCwVGdDv1RJh0pD45GIkFnrlzQsVd/JZ29blskf7Dk6qurQV1VRnsSLejgh0LkEznlRAQNjlOehGO0A5k9Ns6XFZc1gUBlkRmn7tTK1eEVqD+gxhYFG7GWhvTx+RP50+jNcjkebmadYqJVqaV2J8UxWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l00nyxN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8977C4CEE7;
	Sun,  4 May 2025 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746372141;
	bh=fpvqb7kTlOOuUN70MgJgEf3UkSdSGeqD6Y1imEuSwAk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l00nyxN3I68g47m4MMDzIBk7ZukQ7rlBiUqTzd98Ti/iT4P9ekm9CISazTH8z4LJy
	 4BDScnvvPt/HkwXSbzTLKOh4jI8ayWWLWsUugfmmVkJEHgdxEDqFEZlEsNXz8aiZ2V
	 P07KzTZ41XUbUfDt6JRK7pRwvTplhyZbwp2wcPmLEgX2Q2kGcB03Nea5KGPIRps8RS
	 sBhGS8bo81wLI9DX5HJvtmqe8NRS+YkIXLHOYCERBOs6lDjC+GoI9i4YJsMKotRJQs
	 WEcIxYgKgKBMqY5sB3PVo0klDyjXUs1bUbBnd+4U85NAeARUtfdzYxTJgmBn99I0XQ
	 MSoyg/Z8aRkPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716EC3806659;
	Sun,  4 May 2025 15:23:02 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC/urgent for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250504102133.GAaBc_rTClPZmy75Rm@fat_crate.local>
References: <20250504102133.GAaBc_rTClPZmy75Rm@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250504102133.GAaBc_rTClPZmy75Rm@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc5
X-PR-Tracked-Commit-Id: 6dbe3c5418c4368e824bff6ae4889257dd544892
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 081bc61f93123c3b3e446539377b3c7d8deb046f
Message-Id: <174637218085.4049463.3882500317466037978.pr-tracker-bot@kernel.org>
Date: Sun, 04 May 2025 15:23:00 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 4 May 2025 12:21:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/081bc61f93123c3b3e446539377b3c7d8deb046f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

