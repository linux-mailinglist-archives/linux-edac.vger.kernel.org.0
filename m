Return-Path: <linux-edac+bounces-2934-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF29A18376
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C716A02F
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894E1F8AD8;
	Tue, 21 Jan 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GywE5K1I"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D81F8AD1;
	Tue, 21 Jan 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482168; cv=none; b=WQyrrOeZq0bpx+deyeaLpQvIX9rOs2EIm0nV0Lx646cYakqJhuvGdWPHKEaPd5VJYlKihwoa0gjMun6v0OD3XeAtdxfnvYtTG9F5Ryr+l34Q8VmADZ+EbuHgV9iH2nEw1g40QchRxPpif7T4Mkna11yOnVrDCF5u7prAr4IE90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482168; c=relaxed/simple;
	bh=6bESarTVly0Wvblg40rsGeRanJAueYpz5QYs+cmzzdU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i7cYv8eqHYOLEkWaAb/DOorkowiCRYcYN9vmIWU7MvAj+V8xcleBXJyQcu8YQPGwP/D0E73J0ktOTtvSvs/ScmeKMcEQhGGhE+P6oSWsXTx1Ct67RbC6z7Z8JAO30tq2QzGvahCbX6v20+YFuo7Af6TCYZAp1bZSJw+zudHvJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GywE5K1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F124AC4CEE0;
	Tue, 21 Jan 2025 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737482168;
	bh=6bESarTVly0Wvblg40rsGeRanJAueYpz5QYs+cmzzdU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GywE5K1IDci9NbKXvFoxRDd+YzwtiUzEM2ijCQLRmgYSqg4qRj9Tse8u1jKDknAco
	 +EejOQE+VrKQpgeVcV5D+k6OAK6C3e1dhvJQjQXVTlWsvdjPNZlyf0FkX1St/G3L42
	 iCRwkOgKrc7h4ZkqJ9zsJtH8WoIGrwDOTj3GFTCVInaqmUAZuDdjAWVlm8Vm3EKdec
	 UfQ+kBD+x+dlo92zqOyfpfMRKezfRO5KPpBdR6uY/q9q9awSGqTfKGpPy5DLfStnlv
	 PyE5wktX6YQIdcCGbJAxE78a0UWM3XsTVT9OV8zMHRmWcPhU5acghzxmUmUlTruQzT
	 EErWOlidPqxUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB2380AA75;
	Tue, 21 Jan 2025 17:56:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250121120957.GAZ4-Old2JOsTkUGf4@fat_crate.local>
References: <20250121120957.GAZ4-Old2JOsTkUGf4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250121120957.GAZ4-Old2JOsTkUGf4@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.14_rc1
X-PR-Tracked-Commit-Id: e5d3a57891ba500503df075b99b78d6e61f2694e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48795f90cbdcccc36cc415a2d785a23a4b23e57a
Message-Id: <173748219213.75120.12873384713905586287.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 17:56:32 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-edac <linux-edac@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 13:09:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.14_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48795f90cbdcccc36cc415a2d785a23a4b23e57a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

