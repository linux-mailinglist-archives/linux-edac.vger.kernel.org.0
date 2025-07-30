Return-Path: <linux-edac+bounces-4462-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4FBB15658
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 02:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DEA7B0DB0
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jul 2025 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816F374EA;
	Wed, 30 Jul 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUBDBASd"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089EA921;
	Wed, 30 Jul 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835015; cv=none; b=dEPnhwSbWCOq1abHwHdks3wPLso1FnTFSIeGgNdF+ZbMvA+0HDj2koN36iDfNw1HSt2QnQowEii9E51U1xsXANCursTijSi8Pj+hqWg6azvec1pddT7nEqEE2fX+JeTxX5gnn839mqBfCZsw6+KT20lu0VHq4zxiUkwsV5ZdpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835015; c=relaxed/simple;
	bh=XWFjsPB5rIt/Q2YFZ3XpWEmsKOYAGcRdZ3nOl1XgkUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OnL5jYkuhwPSHxObgr/PMex+47Pu3tKm8wupulXEUu+masz34w7TT3HZHgJDXgROm+Tov0xoYoaQMj4XwPhVGi6cOoHsTZh6HBK2ud14onctdNEaI6qvGkZn16MZZjsdNpqtmkO4/FdFFNWqWNncf5CVkAu/e61YAQ/rySyT+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUBDBASd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44434C4CEFE;
	Wed, 30 Jul 2025 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835014;
	bh=XWFjsPB5rIt/Q2YFZ3XpWEmsKOYAGcRdZ3nOl1XgkUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TUBDBASdWthL2q4uiv6S+XB4NDL1+h+Gbzf7NzAVDHAXpPFpkCjJYaE1pYgQaPDyu
	 Uu+1nTJInXTj26V9YCXeiwak0PHzIRrGix9TmMwKtxMWAkHDhTYDKH1lqg8iiUealg
	 Oy2H86lFH34M7KQVWvYVwddGFo2AtXUojOlGNiMfF1OYsC6CN8NLCYOsB28X9YL7jR
	 sLaeP00+DsVtX780iutGtQ27XlZv/j1KE0qgn7dyaUyZTzp8avRZQcM7urVmp1TRNV
	 4LoI6QK2SrxGrZVpRfhGeCAlkPB3qxBR7ZNmfUDXeOSBBoNEZ6HCyxp7aGfYHeY0jY
	 Xbg1Ay3ke+s5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA2383BF5F;
	Wed, 30 Jul 2025 00:23:51 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728141521.GAaIeF-XYJVbfOQdT6@fat_crate.local>
References: <20250728141521.GAaIeF-XYJVbfOQdT6@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728141521.GAaIeF-XYJVbfOQdT6@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.17_rc1
X-PR-Tracked-Commit-Id: 35928bc38db69a2af26624e35a250c1e0f9a6a3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7223aed30cd77be31dabd635e709828f3255366
Message-Id: <175383502994.1700147.17624701348929453468.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 00:23:49 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 16:15:22 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7223aed30cd77be31dabd635e709828f3255366

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

