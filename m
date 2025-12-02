Return-Path: <linux-edac+bounces-5545-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D10C9D037
	for <lists+linux-edac@lfdr.de>; Tue, 02 Dec 2025 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49F1E4E3CE0
	for <lists+linux-edac@lfdr.de>; Tue,  2 Dec 2025 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D22F90C9;
	Tue,  2 Dec 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+qYe7KC"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07F2F8BFF;
	Tue,  2 Dec 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709756; cv=none; b=nxmsr3FVe0JUSAzOjvV2vHbn16lop6PqytnYNlnHtHS3uur+zO/1TmxtCWH7VhJvjMwWVRmIKCxGIWPrR5Dh8Viww1OKf9ZcCIVaquNwqpNhYEX+OQ9/G4NxZ8bAti5uolPTRDtCqJdkymMp++ARGj2OSV5wHHTiHTASY/gEMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709756; c=relaxed/simple;
	bh=6Il/pxVNwkt0KRplPDmYRFYCVjUJg7DKPvcdC90b2y4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h2JBA4zGtjXFiVQh3RHoHu7D4ruRChoGX5Vm4CqDk10MeRced4ovuqEVQNEEB17W5oNc2anfqnH1ZDDrb/HDslh8pyLT4HG+S8ZZ5OZ69CxOPhYjfQ2lV7hvwmRi72jKpRXCcjnfuFZhxPEGD6rcklfLUPBD33DEwTLklgzzHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+qYe7KC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C9C4CEF1;
	Tue,  2 Dec 2025 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764709756;
	bh=6Il/pxVNwkt0KRplPDmYRFYCVjUJg7DKPvcdC90b2y4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C+qYe7KCaJClw+TpWvz7i+7a/4Mb4LDLglvq7Hv/tWhLxviG8FDh4Y8iRAbuafgW7
	 e/DE6Zq+8wxdDYhWkKqKZO0y+nOPKsOwn3QC+s/0T183/M1dnh2GEnTe2T0Y6mn8Yp
	 iBVSDe07oERIGAoy0/3k4ohizHHQL0TGRt2jBtKVjzFay0r2XmFfWpe+9xljLtwrtn
	 G8SZWWqyEZgTjuc6ph2rt3JAu4AbmOj9HLktmqfeO+dQ4UJcLOrNZfQ7P3kQppa7l5
	 qHzAGYEDIKCJ42Q7A8NFArLz3WjSejeMwT4+qWxZcwyapbrsiScBctPRW5IuNntZQO
	 HJSoRYtpUIOow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5D373A54A3E;
	Tue,  2 Dec 2025 21:06:16 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251201121852.GAaS2HrICVFEQyuAIh@fat_crate.local>
References: <20251201121852.GAaS2HrICVFEQyuAIh@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251201121852.GAaS2HrICVFEQyuAIh@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.19_rc1
X-PR-Tracked-Commit-Id: e2349c5811ae642f6d948d1ee4bfc4a93566c178
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49219bba0149157774b7091c3ea9ad22b2114285
Message-Id: <176470957537.3391247.12870548145811904188.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 21:06:15 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 13:18:52 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49219bba0149157774b7091c3ea9ad22b2114285

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

