Return-Path: <linux-edac+bounces-4057-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C332AC9F43
	for <lists+linux-edac@lfdr.de>; Sun,  1 Jun 2025 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F8C3B5734
	for <lists+linux-edac@lfdr.de>; Sun,  1 Jun 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07DC1EF08F;
	Sun,  1 Jun 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCe/Wsol"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E81E51F1;
	Sun,  1 Jun 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748793911; cv=none; b=V9F40r2mPW6vvlQUZYGjUBfV69iIBiwKFIlf7YgsPTiKllKyGt2aJnte1G40H+vyaswYDIO6Mx8+1QeFQKELsoCmt0RrMdXNlVzBgbHZbzoFvxpQrVOQcf56PfnzyTzqipmKY22ujV4kqkGL4sJD7pQSwM34oKB8tj7emjlMssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748793911; c=relaxed/simple;
	bh=IE9O6UwoCx3UKD6YhzIiVik0ovMxtw4VImkGVaTLCxk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gGv0NktH5vHsp9cDuwNQcAbQDCd/bh43isTsJgp5cMcBPmY/YYrgcdGDvkVYJ2RKtKlkrng68x0KK0Zm8eeV06pX08wU068UJIwKIfu7lKzBFBpPiF62+IUXw2zTfk6HV7yQAdv1yoUR9m+2QpCmugLgWiiWraAQADVYrLC4AE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCe/Wsol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B356C4CEE7;
	Sun,  1 Jun 2025 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748793911;
	bh=IE9O6UwoCx3UKD6YhzIiVik0ovMxtw4VImkGVaTLCxk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sCe/Wsol4ov4k2uRadt6fcNjl3JJ/Rwu8GUaaPjeQv5pdKKXNPW1rqgU4QvgRM8US
	 6Fe8nzwtE6ke3QqkksG+G7J6In7Xn4Sqvp3q11kvsS+6SGb7zIVc2Vh4H9I4wxAobo
	 GngfagJ7iOeSCq1H4Zh/5xARNo8zKjRziqk9+Av4nFxQ9jK8S2cG3btGbHPQAflJRE
	 +U0DW8e9voXK/FxXWr91Os/uNRlrfTSTVGTLNZGDrIGjMeB53MDktoaUX9CrT4X0LI
	 VK4jjyfq03KQNyCRJGzg/uGx3PBqC5wbfTN73XLefxLKbgIqihyUUujiiqUm1ScqQU
	 igaRsn7AY+VNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCE380AA7C;
	Sun,  1 Jun 2025 16:05:45 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250601093529.GAaDwe4Ucse6iANlLb@fat_crate.local>
References: <20250601093529.GAaDwe4Ucse6iANlLb@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250601093529.GAaDwe4Ucse6iANlLb@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc1
X-PR-Tracked-Commit-Id: e5ef4cd2a47f27c0c9d8ff6c0f63a18937c071a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bebf9f9d5db910ab3bd285749ee0f869d39c642
Message-Id: <174879394398.436212.5503923042980778438.pr-tracker-bot@kernel.org>
Date: Sun, 01 Jun 2025 16:05:43 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Jun 2025 11:35:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bebf9f9d5db910ab3bd285749ee0f869d39c642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

