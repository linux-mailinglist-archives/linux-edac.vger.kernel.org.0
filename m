Return-Path: <linux-edac+bounces-3401-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB2CA70BF6
	for <lists+linux-edac@lfdr.de>; Tue, 25 Mar 2025 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D65D178AA7
	for <lists+linux-edac@lfdr.de>; Tue, 25 Mar 2025 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9601DDC3E;
	Tue, 25 Mar 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkD9fM8k"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFD18A6A8;
	Tue, 25 Mar 2025 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937474; cv=none; b=ZrZ+jowf9+lAsfBDFCGJiTt8r+oNjuRwFax2yn3ViZR4TihpoGsXVXv/XiOmg6W8J2ZfY1GklfbIljmffupDRzDINyYKfU5wllt843YZgJsK1uW47s4JNXNYppr+ObhGnBtQ9b6aby1pt72PMrniZdi2veHKJOcs3h6KmBsUyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937474; c=relaxed/simple;
	bh=QtGr64tQZA3IpOzfjBCD63yPAA2mLCCe++20UgNGhs8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k9bjSeQ2mDr3Krf5GBDHuGp2hxgRHwsKcn39/Da0jFL+o1UM6MrTeV1L9sVM4omdjea8KjqZrv3OzmjvxKmjCBgvzYn1VpbHYSdILw3p/6u73KITS2IWkv3qLjnAfNSFPyq+Bm2M49hiU3XbW/L+aQDYUW2Lx2OKdZt1MJfADNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkD9fM8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD856C4CEE4;
	Tue, 25 Mar 2025 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937473;
	bh=QtGr64tQZA3IpOzfjBCD63yPAA2mLCCe++20UgNGhs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dkD9fM8kxxgnzD1+TgelG4m7H+Vw+jTw+gCQDSD3rYG7ktQJuTK4Zl8/MPwD5Xf6k
	 jne4a44KilG/tezYDaOrNaYnftlKwrt4qQxfB+5t4MbfYehqF2UA4eH9Qj/0udcx8P
	 L+Auh8AD9GbfoxGYapPQvjr0dL8E/oSVfVwIQY1aHEjGGcDTKBLcAJGkXSeYckoUH0
	 xCa/kJz4e0tczuaN88ulaPXf40CsLQCwhofV714bF0QjRvwG8mPpAbmGnj+ocEsnSi
	 DuFu+NqUEjSrSNoRNJqyeBIA1FlCeagjYb2EyGcF6iMgFbt6cj37Zl3DV2hlhBYoFX
	 9aTmVhNs50/0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35A60380DBFC;
	Tue, 25 Mar 2025 21:18:31 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325142948.GAZ-K93G38luDj558S@fat_crate.local>
References: <20250325142948.GAZ-K93G38luDj558S@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325142948.GAZ-K93G38luDj558S@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.15
X-PR-Tracked-Commit-Id: 298ffd537585ceb45034749d51d8a82c8f3f3c0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae8371a46e59d768a5540a237309962b50b8bec7
Message-Id: <174293750978.732113.17417100103995199162.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:18:29 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 15:29:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_updates_for_v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae8371a46e59d768a5540a237309962b50b8bec7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

