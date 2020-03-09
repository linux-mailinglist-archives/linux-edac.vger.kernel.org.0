Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98F17D793
	for <lists+linux-edac@lfdr.de>; Mon,  9 Mar 2020 01:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCIAuG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Mar 2020 20:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCIAuG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 8 Mar 2020 20:50:06 -0400
Subject: Re: [GIT PULL] EDAC urgent fix for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583715006;
        bh=lWfiQdoCsnTQPI1RCdJJfvuV1crdqrAx/b6jzhDKNyw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fDgPGNu1F/gcMrJ2m7Ljp1XbX7b2iPWJNa5amxOLjCLAIUOFo5BnFsj0+19VD0DJd
         2Egvp1qMZkq0Als8aaMy2zMQ9bI+OwDCgnUVV9VYL5caW7loPNkl23BkRkQkyWPAjf
         FHb4zCCzQ3zZVQr5UGl+QtYEfg19aB0SxkefGKHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308163335.GC12445@zn.tnic>
References: <20200308163335.GC12445@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308163335.GC12445@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_urgent-2020-03-08
X-PR-Tracked-Commit-Id: dfc6014e3b60713f375d0601d7549eed224c4615
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efe582a137eda93265d880494cb04370afd162f2
Message-Id: <158371500614.10826.15867365502473300442.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Mar 2020 00:50:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 8 Mar 2020 17:33:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent-2020-03-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efe582a137eda93265d880494cb04370afd162f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
