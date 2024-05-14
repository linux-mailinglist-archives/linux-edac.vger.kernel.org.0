Return-Path: <linux-edac+bounces-1055-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D262A8C5A02
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2024 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E892B21C35
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E29717F37C;
	Tue, 14 May 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2U6hYdU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FB158213;
	Tue, 14 May 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706164; cv=none; b=BFv20DiZrL14nTf3LKcNATmHUSWylBJ7YBss+GRLewn21qi4FyqPE7ea+FssoqzVgyQYSIcVlMqqW7M4adI05d4jheGLiCD1KEr0BIKkYbxBqD2qxwli4B3o31dHY7VNpbPvGWznSnlLPzlvbGdZOxtp0JBDOSTiwlUvkyyKFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706164; c=relaxed/simple;
	bh=qfkTSjP/78j6zWhDn7n3i47GTQW7+iaS7wwXUJl6qW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NlI9YQlM5wSRHabNtF14Zk64GpDSPy4YIU9++eu35ByAoGx3KMu5MYZyNOqIO1C6WJSNUNUNHMvmWDrbVR73m6Tks/YNqKadkNijRgBHHclKUZCKFn+Z91UqtlXUE1g3ylaUC3iRibRm6tv6utBZXyIAHY5MPN4xQJBR4lFAt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2U6hYdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1B3FC2BD10;
	Tue, 14 May 2024 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706164;
	bh=qfkTSjP/78j6zWhDn7n3i47GTQW7+iaS7wwXUJl6qW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p2U6hYdUd+hUznCnT8wrcCIOdTvh5dJi86IZKvG0oFUjQTpOVejFybpAXrv5ETn9+
	 1QC8VGf5pRDPiEE/VAm1JV2b2j0qHRXRlAj9bynTGKxr4/63FYjBtkygs8cyYIzUDD
	 I7Ace1AXrGHxgCohIVg7BqQTlVQOLKHPj0/WBybdaNSopdLySY0GWPGtFt6eG6jDTh
	 CD2ZwKO1f0u+MAFzI4ox1O5Vv0vCYvYUJK3xDipE3nZ5mXa4bD0MwPkAVdpJiXOdIB
	 1KOwP9V1ihuvESNRIT7n0W/kOqQc2n07Lc9QXnXnRONkjohy1qFZ/sewtIjttXM9NQ
	 GUu+WWy5YEOHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9FC0C43339;
	Tue, 14 May 2024 17:02:43 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513091302.GAZkHZnuY3xHJWwzs-@fat_crate.local>
References: <20240513091302.GAZkHZnuY3xHJWwzs-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513091302.GAZkHZnuY3xHJWwzs-@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.10
X-PR-Tracked-Commit-Id: e0d335077831196bffe6a634ffe385fc684192ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eba77c0477312c7b614338b24a8cf533695d1257
Message-Id: <171570616394.7410.273440332718137862.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:02:43 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 11:13:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eba77c0477312c7b614338b24a8cf533695d1257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

