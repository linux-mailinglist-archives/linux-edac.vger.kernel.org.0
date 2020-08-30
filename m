Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB1257017
	for <lists+linux-edac@lfdr.de>; Sun, 30 Aug 2020 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgH3TRi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 30 Aug 2020 15:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgH3TPO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:14 -0400
Subject: Re: [GIT PULL] EDAC urgent for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814913;
        bh=O8tj7DSx0vwmnNuv7eWXpLFX2YMjUI8WL9iHmjVf47w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sHU25HXOVLtOX9aiebyoqbdm399QmMUlIry++8+O45XzOsyuxIqIM4yHNWLklKDHd
         hu9XbU+GIh7KSa0PEvNM6LYUyHtH3i78K8SO/WJ3znolATfBtrjVK51r176XOyHxFR
         d4QsbF6INJ0kLv/SAboF+wmcb99RT6jDECI5Vw4o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200830070245.GB4363@zn.tnic>
References: <20200830070245.GB4363@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200830070245.GB4363@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc3
X-PR-Tracked-Commit-Id: b972fdba8665d75109ade0357739f46af6415d2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42df60fcdfb8c02fa1800899cb33858e46efd587
Message-Id: <159881491366.11937.4998385925824911031.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 09:02:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42df60fcdfb8c02fa1800899cb33858e46efd587

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
