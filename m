Return-Path: <linux-edac+bounces-2716-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EF9F2567
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 19:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1659318855AB
	for <lists+linux-edac@lfdr.de>; Sun, 15 Dec 2024 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51721B415D;
	Sun, 15 Dec 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+gBae/6"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF801E526;
	Sun, 15 Dec 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734288318; cv=none; b=T3oxewhd86398UakPycSDb0EB8wfqas56QsmKGaWRjEdVvhZkW8ODHGrfEs6OyGihxsGY5xjbseqHe2j5ADjGV3/Hhropm+dEPaHJNhTDRcS+jMgth+wRs8R0nu/JTPxxGHH1NR1BzW9+vGh2iO/gp2iPTSEjYTqE5m48z4YI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734288318; c=relaxed/simple;
	bh=cs57p87VGcJPj3CoaHVNP6uPmNM9ZjuGhzo/45FASUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QJHwW829J3xpyMjarjzTt4TPN2cQlfoYlEMm1j4vW7+xWPe83uYf51s75dGxadQJNtsuwckJFX+2YcJb+IqwFsMQ94EOfr0Z83eGowouy+D3VAypF3DgyYklPGeMvl4IO/0L0vm64Wba0/Oo2+oEH1AjUjFWy/I0Bs+a9FXvU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+gBae/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1859DC4CECE;
	Sun, 15 Dec 2024 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734288318;
	bh=cs57p87VGcJPj3CoaHVNP6uPmNM9ZjuGhzo/45FASUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R+gBae/6SWEfnkDKh73YlI0uLTuFAuInG5HdVL4wVq6JKq6oid8szB3Xbe66dskVA
	 AUlh5SrwtBVCvGDecsiOwzd9+YMu7xoZXV4hwjDrNw5VYlKzQlAS/2GiYrpIKI/1xB
	 COf+dbvs3OlJlJ+91osVXAR108wUXj7RyYrebYeYMlW6BO0S1VxQbPDbyzW1ZufbAa
	 ApKcgcSfIcCiTsivpQWSFngbW+9vLza2CnCWUf8dW3B8e8+3mqFSRXhKYVsTj1BE+W
	 H0RG50XNoSYf01B5dNWFdNiVZNPQA/s/LW0/y/lW4nVQzHcrOn2MRdkAwfBXkDtVNh
	 /xA/xlk8SJyrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340253806656;
	Sun, 15 Dec 2024 18:45:36 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fix for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241215121618.GAZ17IkjqHzDVyqjo1@fat_crate.local>
References: <20241215121618.GAZ17IkjqHzDVyqjo1@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241215121618.GAZ17IkjqHzDVyqjo1@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.13_rc3
X-PR-Tracked-Commit-Id: 747367340ca6b5070728b86ae36ad6747f66b2fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dccbe2047a5b0859de24bf463dae9eeea8e01c1e
Message-Id: <173428833490.3562041.18228525055315610965.pr-tracker-bot@kernel.org>
Date: Sun, 15 Dec 2024 18:45:34 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Dec 2024 13:16:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dccbe2047a5b0859de24bf463dae9eeea8e01c1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

