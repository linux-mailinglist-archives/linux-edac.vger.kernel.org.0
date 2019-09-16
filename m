Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F647B433C
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfIPVfK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 17:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfIPVfJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:09 -0400
Subject: Re: [GIT PULL] EDAC pile for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669708;
        bh=Q8GTme3IiHedr7H42Wwk+kuVWATq+D/siW94eNG8dt4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IIjlXLjP2ErJ79nKZsKfl2giW+yUZFHDoD1/DovmBk6/EnrWrJ+TLhJ7NddnrpEw2
         RJhTjxNRMH/n45GMQ+uMps5aC8JOedZJu8k/rGCZg67ANhgP3MCaXiQhcpwCmJ7MfX
         KZm6X72vX0kJNbmflZV++XT+mooroWzstTp71o/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913074229.GA20745@zn.tnic>
References: <20190913074229.GA20745@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913074229.GA20745@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.4
X-PR-Tracked-Commit-Id: 3e443eb353eda6f4b4796e07f2599683fa752f1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff881842e12563f25d69a4e2e373f1ad392a7027
Message-Id: <156866970872.13102.12851440763335110247.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 09:42:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff881842e12563f25d69a4e2e373f1ad392a7027

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
