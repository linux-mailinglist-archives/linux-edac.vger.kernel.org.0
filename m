Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34028271681
	for <lists+linux-edac@lfdr.de>; Sun, 20 Sep 2020 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgITSAZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Sep 2020 14:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgITSAX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:23 -0400
Subject: Re: [GIT PULL] EDAC urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600624823;
        bh=Fc4O2ntJhipGapfvG9AtWFGzKLNS/ZPkvWDMfBudwkw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Psigey2j90OAiFKCa7pH1iFoIlNfBtNRVs7nIwDJWDLS1R2Hu3IdSwPGFcg7AQJ89
         KdYXB80E/lvt/blcSToywaIRmJLTihcPpzfbhwcndzhD/r2IXezJd00p3Vtkq/JVBo
         RcJh36hE0JnUShLmY6h+9wxh+PtTD9pZmmdRJCk8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920092456.GA13044@zn.tnic>
References: <20200920092456.GA13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920092456.GA13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc6
X-PR-Tracked-Commit-Id: 251c54ea26fa6029b01a76161a37a12fde5124e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aac5925b49956f7bf0f5d0ef3477e419f3ee2f78
Message-Id: <160062482341.2021.12014127101188593873.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 18:00:23 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 11:24:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aac5925b49956f7bf0f5d0ef3477e419f3ee2f78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
