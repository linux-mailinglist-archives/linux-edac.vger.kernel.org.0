Return-Path: <linux-edac+bounces-2563-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E833A9D2F89
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD09F283369
	for <lists+linux-edac@lfdr.de>; Tue, 19 Nov 2024 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95221D0B9E;
	Tue, 19 Nov 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSsmMggD"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91850148FE8;
	Tue, 19 Nov 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048520; cv=none; b=SNBVN52hIiNQzCYSEcFVOQwFl3R638fvQuGqf7PnQE/1WHk5XS/FjhjCyUXA/MbjQ7/wfE2MLBtSDMh4YL20OoBU3wrf4w+spf550Vc5en++cxgK2uYZexcwzxllPHWey1LvWUWGOraF62BZ55ZZCYBLswE1nMZBonsGDBeEgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048520; c=relaxed/simple;
	bh=SNpXsaFeZE6YYA77ltDYXQ9lY6uqCUzcNugqmI0UTCs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dJXzYl/dBwhr6//NhSU4vbbh7XXAPOu01yytYw++xaovJUBBiiGPZ+ffYcRcEmAeu0Irpoet0DIDeRcVGwXt1Pj+blYOyos3cysgF0L4KJj2w95xvVZ2/ozlc8yhKs31iqQMS8y26DGnMh1ISRPzP5xg4XrEOQugQsKfG7CwKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSsmMggD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704CBC4CECF;
	Tue, 19 Nov 2024 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048520;
	bh=SNpXsaFeZE6YYA77ltDYXQ9lY6uqCUzcNugqmI0UTCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rSsmMggDlt9P858FfJFJrgSVC0qubXNvpPpQaKcl60cIu3ylfkP4zHTmoNxR7Heu2
	 6LQLMQ2X6UPmYfm7tQtedRGeRzBX6nZHuKyPRm6EIAtdi4Jven25PMhtQGhwzPgoGb
	 a+lpXLth48lz1gYLclGz0GbTHvbwVhm4G6/EhtgbQQcSF9DYkvoEhiijKiXfPOQfe8
	 fzCaIYrp6/WJghidyYvbQars5+qmXOjM0jPwWSojtn3u2U6G6yudJe1j+yTMNU5KBZ
	 bqiR2PGlQLfilxrbpSoBkNo0XsoqsLz7aGCh09Dqlk4+ur9y8J4lZQSNRNaq7dB/Ox
	 xhFh6DSNBFiRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348E43809A80;
	Tue, 19 Nov 2024 20:35:33 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118114343.GAZzsob_d_C5sYNHUn@fat_crate.local>
References: <20241118114343.GAZzsob_d_C5sYNHUn@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118114343.GAZzsob_d_C5sYNHUn@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.13
X-PR-Tracked-Commit-Id: 1b38da0115598e30cc7cdd84761fc427c18b281f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77286b868f93a590313b449b25a49ef2ad0c0308
Message-Id: <173204853180.680579.15234578676758821318.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:31 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 12:43:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77286b868f93a590313b449b25a49ef2ad0c0308

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

