Return-Path: <linux-edac+bounces-3560-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F130FA8A397
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCDB3B7F8D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49BD1DE3BB;
	Tue, 15 Apr 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPdYd9Tf"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AB19EED3;
	Tue, 15 Apr 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732983; cv=none; b=tBdQAMKcotaQ/KnSfyFof+kfe29361UDY2YrKTCpMRO3TOrRmUMxLlLiQfP1sS8+YJYymQOjhZ2GLkkRHuBZo9F9XvlMv6TI4W7WNuBN2urZlViJkGvLRBPuhX6nQbegOxdLpek6/V5boBxKZgqwoTOzbg78F114wBcuJb5+qfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732983; c=relaxed/simple;
	bh=oVG6X9XWFy9aJLnKwYviGDUveDG6ru1V3vJIEt9Gp60=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WWnquMSwvmow4KQ3ppZDRZQs+Nd3aiJLAWHkeF5qZvX5JsX9nf6BCTQg9LTskT9vw/XqeHu++spR5ADL1WdX3Sjdj1I5vnaGoesfNrQ3udGMaE9pX+zSsi11WQ9mmW+ak/snlglo6QJDXUJZSbJtXD/a9ASq30tCyDyO/SFatKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPdYd9Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BE0C4CEEB;
	Tue, 15 Apr 2025 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744732983;
	bh=oVG6X9XWFy9aJLnKwYviGDUveDG6ru1V3vJIEt9Gp60=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jPdYd9TfYCZ/0zViGkI4CF/QcLry0wj2/3+1HQGvZ9uoXdjBmrKioFtny6j9kCWxK
	 bl+uPKajtkXU+FfvhSA3sC3V0IjwDhSbqjUb07Sic8gNWCBD5NQa3Gw9Hln5hKG9Uj
	 NuQRljEjL4JXm592h1qpU1O8RbbIWZn/+hxOMh1Vu1/54NEN5fXklgOM/D4FXX71Mg
	 e4JiV40+E/GW0mNyxQho47ucouhSUUS78z6JS5WpECPOcj5gzWowILus+zJvNvrlTd
	 eljn9IgPMSPnIOvZCZg3YCW0m1qt/QsmJN/RIFWg75QCK3gu8y8nKktBcmwUEEjAbI
	 kwDPqlBE082UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3403C3822D55;
	Tue, 15 Apr 2025 16:03:42 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250415123332.GAZ_5SHIlZcpQxbLMj@fat_crate.local>
References: <20250415123332.GAZ_5SHIlZcpQxbLMj@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250415123332.GAZ_5SHIlZcpQxbLMj@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc3
X-PR-Tracked-Commit-Id: 58029c39cdc54ac4f4dc40b4a9c05eed9f9b808a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
Message-Id: <174473302070.2689177.2532379643450427629.pr-tracker-bot@kernel.org>
Date: Tue, 15 Apr 2025 16:03:40 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Apr 2025 14:33:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.15_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a1d569a75f3ab2923cb62daf356d102e4df2b86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

