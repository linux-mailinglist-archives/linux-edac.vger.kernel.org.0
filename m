Return-Path: <linux-edac+bounces-4205-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6DAE31D7
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F773AFC31
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF0207DEF;
	Sun, 22 Jun 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lehyPf7k"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B9205AA3;
	Sun, 22 Jun 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750622124; cv=none; b=WQmj2BSpqTjWTBX35rTLuRt3xZkfbg7fWVYLyzbyKMZHEPIpV1skWw7a0QHEZIuFzKc62gSN6DjyZRpF6uG+x4m0zodTOfnZ6qEn/6/z+R7yOy0UqxRT6dEB40jptZZLLJApevYSvl/dzRl1yeYdlkkWCYg17p18u8rezYrKEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750622124; c=relaxed/simple;
	bh=txwu/DitIMvhtxSce69xSMDD7mwZgdSnXGLt+nfdTT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uaOAh3m+M7sg64XRox1xRxMhKNqs8nOMmdhbl57cjxJAQgTz0DxXxLbEtDlDzaYw2EIVq3J7hVxC+ZwbONtBG0KF3eBvkg0vDyV+1EGomLo9R9LBaKpCdNStfrTtgxr2y01diBqnGDzWtM53SppS+QgFgbB7xeoWkD/W/R912YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lehyPf7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B223C4CEF0;
	Sun, 22 Jun 2025 19:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750622124;
	bh=txwu/DitIMvhtxSce69xSMDD7mwZgdSnXGLt+nfdTT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lehyPf7k2JtyYS5IcQTEjmAPKlMelk9XjS1gnLeVEK7I/vov4Ddf2jw4TnA8zogqn
	 Vv3cULPsoAUQo/WbKnes0BsPcChz2EwlwPMmrrSpCt4x/4llOdJnfPpGPLd6bfzTNx
	 CRHUHydVJBG0c9NHZxJO7snCXm0vRiyBE+AuKf5FeU0tc/WRGnzIF6YdR82pFr+yPf
	 PXpB0di6YOpqQJN3hEFCBtnHLPYHI/pRsdyg2TEJN/M+StOV9XnOmkgKdPAToZaAvN
	 x2XlkEUBma6SrTyWDke297CE4r7HbamMeNiF0ozKI4KY/AgjRZHAl9tFx6yiovwYG7
	 80koPpRNEBGsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDD39FEB77;
	Sun, 22 Jun 2025 19:55:52 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250622075345.GAaFe2iR1i-n1neZcW@fat_crate.local>
References: <20250622075345.GAaFe2iR1i-n1neZcW@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250622075345.GAaFe2iR1i-n1neZcW@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.16_rc3
X-PR-Tracked-Commit-Id: 88efa0de3285be66969b71ec137d9dab1ee19e52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73543bad766486c3cdbf6fa9d1faf7d0c4bcc7af
Message-Id: <175062215111.2132065.4538310598874632842.pr-tracker-bot@kernel.org>
Date: Sun, 22 Jun 2025 19:55:51 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Jun 2025 09:53:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.16_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73543bad766486c3cdbf6fa9d1faf7d0c4bcc7af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

