Return-Path: <linux-edac+bounces-5707-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mu6IXz3i2njeAAAu9opvQ
	(envelope-from <linux-edac+bounces-5707-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 04:29:00 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E152C120E8D
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 04:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED0A3041A5C
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58A34402D;
	Wed, 11 Feb 2026 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOpG7p7h"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7217ADE0;
	Wed, 11 Feb 2026 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780521; cv=none; b=FERhqrPWjT/4+RDUGinTFBJ6VlDi4fBCZIy5onNbtteoYcbdKd4ASVn1ymDIHPO95fe2rg1NFUNdnYqgt3WXdFeC59Ttw3KDIftimYAe9SW2YcITEaKLZChGjkdQXCar/nvD6nIxj7pOF9rRGVVWohIBFH97jOZ+m9Kjw5NuF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780521; c=relaxed/simple;
	bh=pNihZTaY+z/MZdqfarGpx+32rp+LTBU4YWQ7qgWgZEU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HGmgukL92W4mlqKEsvbZ0D8DNauP7/Q8oZgvlmHyFN4n0E5I3eNY01x7PaV04PGDTtVZstaNbYxdhE5R2cGjfNCACD5bS1M2//5wwIxtde78MReI9Yl7cCPPKMhyrgx5kun5JDYhs5bTM15wFJ4fPSoDGN6JJhYtRNNTRNev/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOpG7p7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63903C116C6;
	Wed, 11 Feb 2026 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770780521;
	bh=pNihZTaY+z/MZdqfarGpx+32rp+LTBU4YWQ7qgWgZEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lOpG7p7hZpvrwzbOQTHz6+0bK8r+c6IANkXlQ9R1sohSZSe23seYrZPpPfgf9WLS+
	 UCc6KC9tPM38V3ORuL9BQYZjaocC2OKLJ1BQkjHlQfaDvDvjBiA1knRmJF+ujDjrsv
	 tE477Xi9C8XpEr/rk8aC+Of8QGem2hzi8QwfUUL/IDe6xTH/iRskj76WeHEJAABSDJ
	 QM/qMf3ywGgOmEN4TUTiyLvQkRDjOLBNmc24Vrjzln8C+bkI1CG39+sQo1lsqRCUdc
	 yTKADvKWxHJsJ+7k+0PvHx5fSMdcAby3WkLFlJsQjckH7bOIbt4ETMwAPxo3W5P5W1
	 6OTV7D0hloMjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23D5380AA50;
	Wed, 11 Feb 2026 03:28:37 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209135708.GAaYnntIzX5fP95e9T@fat_crate.local>
References: <20260209135708.GAaYnntIzX5fP95e9T@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209135708.GAaYnntIzX5fP95e9T@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v7.0_rc1
X-PR-Tracked-Commit-Id: 5b115dccdc8612cd892c41354e63fd5b23d56c51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14c357c4add8b2a213f291230c5bf485cffb9db6
Message-Id: <177078051638.4176860.2763045031739175244.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 03:28:36 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5707-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-edac@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-edac];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E152C120E8D
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 14:57:08 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v7.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14c357c4add8b2a213f291230c5bf485cffb9db6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

