Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9C198587
	for <lists+linux-edac@lfdr.de>; Mon, 30 Mar 2020 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgC3UkK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Mar 2020 16:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgC3UkK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Mar 2020 16:40:10 -0400
Subject: Re: [GIT PULL] EDAC updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585600809;
        bh=aMZuRgR9yvTiM/HCzKkw7ccSKnO22OA7ZHNOuGjZ9Pg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y+S6X3SKwQeS+urwOdc6VeYduBt34SuBaG689/Z996czvqYgdbB2xNUpXKcMVcJaO
         kugY3rr1curFeR3ysgAkU41B7I7TMk9t/n2JphO5YX4VFi8MqHqlWtA0ZOFr3LOwlg
         TLJmfjd0kpKOVz60y5J8ukGBcRDFHA3hdmA4IJl8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330081948.GC14624@zn.tnic>
References: <20200330081948.GC14624@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330081948.GC14624@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_updates_for_5.7
X-PR-Tracked-Commit-Id: 41dac9a2ad4a3d5c96394a23dd53b7e6edcb80ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaf985e21a4abb471df2a10ad7163367cbcd4088
Message-Id: <158560080970.3259.9178106095809793276.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 20:40:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 10:19:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaf985e21a4abb471df2a10ad7163367cbcd4088

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
