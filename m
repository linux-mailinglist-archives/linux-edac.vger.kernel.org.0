Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC02128BF91
	for <lists+linux-edac@lfdr.de>; Mon, 12 Oct 2020 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbgJLSVC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Oct 2020 14:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387669AbgJLSVC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:02 -0400
Subject: Re: [GIT PULL] EDAC queue for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526862;
        bh=22XGfSewhYj0UUi/pwq1jJzvdCqo8cXGLo+vm/QUmys=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S6E3dZ5/4oKdAA/quNs6PREt9MQtoqbvvLjzKP7NXeobK67LAcrx9u1fwz9BypUVE
         uyDIbYQp9/2DnOIlpi78HmUT0qgjsCvEX836iBOrufuUjuGTWO2JJR1H6nhTLPCqZ7
         tzOmvkcgUYj5NETgoyaOB8KLda4FnJe6tcstEnIM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012092029.GA25311@zn.tnic>
References: <20201012092029.GA25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012092029.GA25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.10
X-PR-Tracked-Commit-Id: 1dc32628d65a670625afada00f50c91add1a19a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9a4b7d9a6380ae4e1df2c9b90fef6c427229aab
Message-Id: <160252686240.3643.17498350851659457514.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 11:20:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9a4b7d9a6380ae4e1df2c9b90fef6c427229aab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
