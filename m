Return-Path: <linux-edac+bounces-3185-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D8A411A6
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 21:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C677F188CF27
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F623A982;
	Sun, 23 Feb 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paXMvqph"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67367B64A;
	Sun, 23 Feb 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342763; cv=none; b=TOgOz5GvLqvjy4LEHnKgnnzdwr/lmLKZEasrmRC4SMsfpGBynpEPfw3/u5ab8XifmihbgSR2OBYF1Q/HlT/gmLn77HrIGaF3DHgnJFg9By6QS1pzCG4BNdqhZJOTS+4Gt4YuS4MoS49Uaz6x+ckRNAhnnaO9MopK1p9B5iNSwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342763; c=relaxed/simple;
	bh=i6Jm4qE64VOM1DaJjXn3iv835TtFEqshmpOvz7YEcB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eAuf6zGFsNGTYGUMKe/DchfKPEWZ5bz6kTaBSGnTh1ko2s1tP7tjoZgavSsK/jtwniCxSZroKntXaB4eyr5VO1oRI6dW+5ISxKuvDxXNO/SMHG0NdrBTGeeOFQCkLSaqbltNQ5cdGMqJaN6pZ/7L0AhkSgAd5OiiMWHip97i6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paXMvqph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B2EC4CEDD;
	Sun, 23 Feb 2025 20:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740342762;
	bh=i6Jm4qE64VOM1DaJjXn3iv835TtFEqshmpOvz7YEcB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=paXMvqphsopbAjzmVYOwmKECYRURQtcK+wyJqVQ1wQGrBhOTHS2goR9IMufHD8AS4
	 lPOlR7mTxuPeNGBAhaDHLOmABpuF9s9vTs8+86jYq4dv98EdxsJZohNAkzBixaIGlf
	 KOBuf2SnDcQXhZwDyvFIJr0pjAqropKJctsZ6/f1sjOshpRPJIROLFzPdgQ/EXa7l4
	 9uVxbafVbWEmp6QUcSed4Ui5ru7lhiW4tR7OPkJUwQ5Abnreo6U0AmDAltKkluWLol
	 M20csdb//yjWTybJbwgl+WUEf6MxD/MXxgQnU2ukiHwzdnkj5aqTxLfh/+v+1nZBrR
	 4UfCDqKnnbUMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBE380AAF9;
	Sun, 23 Feb 2025 20:33:15 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC/urgent for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250223100633.GAZ7rzKTBKLL0-bqMn@fat_crate.local>
References: <20250223100633.GAZ7rzKTBKLL0-bqMn@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250223100633.GAZ7rzKTBKLL0-bqMn@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.14_rc4
X-PR-Tracked-Commit-Id: c158647c107358bf1be579f98e4bb705c1953292
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad328a3785a24a7e7a8053b06139a6bfb42d0280
Message-Id: <174034279397.2614901.4162057167037693433.pr-tracker-bot@kernel.org>
Date: Sun, 23 Feb 2025 20:33:13 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Feb 2025 11:06:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.14_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad328a3785a24a7e7a8053b06139a6bfb42d0280

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

