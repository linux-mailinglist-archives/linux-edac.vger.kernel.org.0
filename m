Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC31220C40E
	for <lists+linux-edac@lfdr.de>; Sat, 27 Jun 2020 22:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgF0UZP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 27 Jun 2020 16:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgF0UZO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Subject: Re: [GIT PULL] EDAC urgent for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289513;
        bh=4ZVFImtbaCKd0Np4tmJJBMCy0Tek++XCgT1Ml2ZJ58o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XF0TTRWVKcxQVKy9PRFvVilaIIIt5ERquPMGDf22xNAgPSW0UdMc2V2b8EDdy3B9r
         VFuLlXHWgra8se6gw/tUFuOvyd99dJ6AOwQSyz6ze5EgJ3zi6s9Z9146K1FQair54U
         yMPgUBbZvUn/1gfITnd9OZiNFwXSyahcpJdLFPcI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627105918.GD18956@zn.tnic>
References: <20200627105918.GD18956@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627105918.GD18956@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_urgent_for_5.8
X-PR-Tracked-Commit-Id: ee470bb25d0dcdf126f586ec0ae6dca66cb340a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f8f9bc5cb7c35ca04a6867cc01c24538d59f7f
Message-Id: <159328951364.11719.14509799335240723936.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 12:59:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f8f9bc5cb7c35ca04a6867cc01c24538d59f7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
