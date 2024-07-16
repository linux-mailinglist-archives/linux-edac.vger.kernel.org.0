Return-Path: <linux-edac+bounces-1517-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDD931E7D
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 03:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D278AB22707
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jul 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0FE28F0;
	Tue, 16 Jul 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sym7ncuN"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D914690;
	Tue, 16 Jul 2024 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093118; cv=none; b=WAvPxYq3oU5BFvRc2wBS73t9W18TgZzrY2yBcKwTE0ff8sa/nzhnmYxlL5Ht9IFosgYrxgvIpQt93lW+E8J5WL/lN26rFsDeI9PMtK0YDl5MUT/urlTBis1Vw+0fglv3Qag2Jkjb8SX2rj0TwOboCSJtjNTyhfNpplq4FreMwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093118; c=relaxed/simple;
	bh=HjlHfzANhCis1CXO3AIUef/4lort5A5zTdvd7PMfHfs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IKJjV+16O4JWl7z4+ToBlszDiFRUPCwwtp+ItOgPAkWFrO/b7DQWTPqnVa9hVBLcE0n4kWtFMff9gGCAYWmVmT2+7lG6TpLKfpNBId3LaPAUON8Wqofy4i3JQWq09dKogKYeZrbK2WY0dzOC7bjlxzv7pUOjkcwvZS2s3eMXuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sym7ncuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75D29C32782;
	Tue, 16 Jul 2024 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721093118;
	bh=HjlHfzANhCis1CXO3AIUef/4lort5A5zTdvd7PMfHfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sym7ncuN5sUW/Eor3l6IRKc8pRhwDJm7Waer5zXbfXtm+SSmgSVkfd5f7GztarJr5
	 aqjIE69S20ncxNi67GETK+sy+yhB4WTaNxEyHLgdhtS9p3wlsI2+V8wWXoU15J6I2A
	 q45/tZGbj1t1sT+MeNeRg2QBtq9aERbsIXDUHAVYkP0jERuDXDAvEmaepqRHbRATI+
	 /n1f/oBeS8WToqJDJhuYk1lKmyp4dCABEB8sAxrFKC0gvF2eGy29rAJf9HX0phXURR
	 /M+k4p+hYsv8jZHKNLsszDIQcPRMH08fAUsBw93zsuUQzdl8WUuFfx4ZeOnbHHwSxI
	 JBEkn99fZvWDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C44BC43443;
	Tue, 16 Jul 2024 01:25:18 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715102134.GAZpT4LmsnVCrZsmt5@fat_crate.local>
References: <20240715102134.GAZpT4LmsnVCrZsmt5@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715102134.GAZpT4LmsnVCrZsmt5@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.11
X-PR-Tracked-Commit-Id: 03a9b67087ba071f69b12d730b36aa7c2d3dbf21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8028e290b6354ddb404e88f17fe5d37945cb122f
Message-Id: <172109311843.16804.1252409573104866754.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 01:25:18 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:21:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8028e290b6354ddb404e88f17fe5d37945cb122f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

