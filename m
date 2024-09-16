Return-Path: <linux-edac+bounces-1877-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB03979A7A
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 06:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D372C1F23611
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62393CF74;
	Mon, 16 Sep 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG+C0Vp8"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814834CC4;
	Mon, 16 Sep 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462510; cv=none; b=XnXRq26kyjdtbK4QJe4kpTwKmMK7ZysTJbSUGCDiJgOA05GJMbjaK6nXX3QUqVSl8Qi1TU0HpMNGkMNJuXgzoLNFD7QFkkItkzEyjSxDPPgkbhaddU7to+s+qVYTyksjw1w4WKP5wbqSu/jIoEKySX4GAYn6BhHIuA0Jt6aRdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462510; c=relaxed/simple;
	bh=Z8N1/F3KpXA/voPxWSAajOuZyHweZSsBUEP7ZKw407k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fJQoaJH/9cWypQzQOvu+papRnJphgi3cbK3fqo1nxmz0yqpzY2L6djVnhI24DPuhxAEK6HRn18qqD2vIiIjjaTQU8vD2u2wOZZTu557RsvLDoL/Y6R8jSSliiVLRhHIzk9PguQVGmT/H8V6llLb1RG7BHsnz5GJv/btVy/Gi0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG+C0Vp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1F3C4CEC4;
	Mon, 16 Sep 2024 04:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462510;
	bh=Z8N1/F3KpXA/voPxWSAajOuZyHweZSsBUEP7ZKw407k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AG+C0Vp8BSvrPK54z/BB9sZCFUYTYEAZ4w/JNtrZsL2elbpIcn+35U3OnVRWvB7su
	 42o651mObx83Wk17x3pr1yXY7JH1Nhw/I4JsAPx8NX0/jlB5vx0OSGGi4SlHX7A3ME
	 6YK+H556eQXJc1LpIIqF27f8r1SgRgHWP4uhSIN+Dy0+EvSeviTWYWFV+BrLXiQJyS
	 Pd/wCwJz3mOC3qhupNcNTc8XYnu+ENFgiWLctSzilvSJnvnzdWMLvKYArIzj2Gr+Xf
	 5saML5Aj+wd5vq8B8km0xT1RHE2Rrx0NKLdd/qK9n/qVOVMmbPXbOpToO9mXbt8NCP
	 6Hk9Is7AoBNog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03F3809A80;
	Mon, 16 Sep 2024 04:55:12 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909090302.GAZt65xhBpCvrrefhl@fat_crate.local>
References: <20240909090302.GAZt65xhBpCvrrefhl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909090302.GAZt65xhBpCvrrefhl@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.12
X-PR-Tracked-Commit-Id: 92f8358bce13da0b2c37122573a2b2d7de0071df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dfc15c47372e8bf8a693ca3dfaaec33a68ee116
Message-Id: <172646251123.3235832.3824649219070543148.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:11 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 11:03:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dfc15c47372e8bf8a693ca3dfaaec33a68ee116

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

