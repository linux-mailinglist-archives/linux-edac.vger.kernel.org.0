Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E3B433E
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 23:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIPVfl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Sep 2019 17:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbfIPVfK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:10 -0400
Subject: Re: [GIT PULL] RAS updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669709;
        bh=IuFtdRZy8Fw6/pIdcVat/3OLcaQYt0tbzzR7b91WMEM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tDZ5kfTtYwaejPyOqM8/iwTWCM7RLg4CilY+V2v8TmZ18KEgae9EbST3VMKnApWus
         f0rRdr9m7ZJlwHzOqYO54icz9sTDy8bYsXYc6wpAv2yQlNR1IYZ/Vtmc8E6jQGiAt9
         pMiHgfiZyUVv9B4r0mwEd1JPiKSFrg29JJrQIYOw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190913080937.GB20745@zn.tnic>
References: <20190913080937.GB20745@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190913080937.GB20745@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: b6ff24f7b5101101ff897dfdde3f37924e676bc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e97be2acd59e07539c5002e12ba6a9c0bb5e83b
Message-Id: <156866970957.13102.2317125622371263603.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Fri, 13 Sep 2019 10:10:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e97be2acd59e07539c5002e12ba6a9c0bb5e83b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
