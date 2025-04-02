Return-Path: <linux-edac+bounces-3456-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D20A785FA
	for <lists+linux-edac@lfdr.de>; Wed,  2 Apr 2025 03:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4313316E5F6
	for <lists+linux-edac@lfdr.de>; Wed,  2 Apr 2025 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF462D052;
	Wed,  2 Apr 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM+THaCX"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319313FEE;
	Wed,  2 Apr 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555710; cv=none; b=FSdNpzhLEvklkx3smPDk/21A1O33nxupIrB1zzwAvc5sBToTWhvkidb2I2imOXca/27EHgI99DyFT7/S1eE+Qn6/dhyFURqdjB4ZUeYi3+JImgdyjyFTCcBChJayC0b9ZA8LK9phVcAru0UW79On+hQQdtlAMaotR5LIu4tYM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555710; c=relaxed/simple;
	bh=k07jFBsUD1V9slO32PfMlw8MQpsn5NgZniuZvRu5Ey4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lxqBmK5XmXIwja+iignTbXRBgeGCOEE9Oy/upAm/nzrcRANQ78QOd0M4OnFQD7VsdOl4vyKJvsr8sxID/BRjWViSyXFOMFMOcrB30+Z0yTsuRAT4K5yuhlYew/9ml0mZyI0dbXOV9eRyO7OFdN0aP5ErgOAEg3mv5LAOvQZhgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM+THaCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649F2C4CEE4;
	Wed,  2 Apr 2025 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555710;
	bh=k07jFBsUD1V9slO32PfMlw8MQpsn5NgZniuZvRu5Ey4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RM+THaCXpcpajjkEZGIevHskoW7y6Pc4VN4X32sfA1x5JJjy1c7Ekc8C1oPYKhkFw
	 8YqDHwYiR/gPcmFnMpmNrfuIs1yq98xDJB068hianrJ3ZilFf+8UWVCfhwLO+2k2Cd
	 NWcIFQFc6uD9a6jChV3p1S0vUy/StCwI5G/u+K35Vt0EDTic/I5opIkcGscZbuf3yn
	 wNTQqn7dmukeVKChbrXyn/S+ab0+q5acnQea8NGxGZeUgepUxZnaeDNgPz71GLbKPe
	 v2IgQ1AnpWQEMDYLPqA0+tnoQTgrHZ6QbVquGqlew9IAGG4e7R+W8hp2fl6H4Hx7IB
	 1Y21K9CsKBLHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D31380AAFA;
	Wed,  2 Apr 2025 01:02:28 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250401212907.GAZ-xao52zj3Enjy8W@fat_crate.local>
References: <20250401212907.GAZ-xao52zj3Enjy8W@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250401212907.GAZ-xao52zj3Enjy8W@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.15_rc1
X-PR-Tracked-Commit-Id: 212120a164d59fd534148d315f13db3d296efb0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 792b8307ecd237ba719736c5310430cff3dd2296
Message-Id: <174355574710.978371.10012551560014886131.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 01:02:27 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 1 Apr 2025 23:29:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.15_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/792b8307ecd237ba719736c5310430cff3dd2296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

