Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF863FBD7E
	for <lists+linux-edac@lfdr.de>; Mon, 30 Aug 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhH3UmP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Aug 2021 16:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhH3UmM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Aug 2021 16:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C852560ED4;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630356078;
        bh=ePcFGc7KhNM/qiM941MHMTSqZ2TmCJyCC7NPz2u2KEo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DJ+RDQE7x5S8tlaczi95w7AGESUlI0sr5IFuN2uhYCUre2qiamJQTm0feNuoreUCj
         /hWNMP5P/Ou0SubiD+uUwajnfgt7xpXGTSi1XaCIuzdbZw+G/75ltJXvaMKr4r5Msp
         sSTJxHTf6tc+TxKg1/wFOL34LIjQULz4lTLUOu+5xt5gqGD5Bj+cWEo33DXUFqrlXq
         9fSPCDr0+oDKetCBXzNagPLRcTctEM4Y1X2RW8NSHj7c1/HaWfjjnPuTrePKbo5M7N
         itvE+2oOEPRfaasncPOtyIGVmVW4o+t/zd0KlGW+tEXF6KsGuiYiY5ibvcSxipdm5J
         YtMkeLiQNp6gQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B863A60A5A;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSyldBbc4ngIMUhS@zn.tnic>
References: <YSyldBbc4ngIMUhS@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSyldBbc4ngIMUhS@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.15
X-PR-Tracked-Commit-Id: cf4e6d52f58399c777276172ec250502e19d5e63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05b5fdb2a8f7f981b9b1aa77a6c4b810e19f01ab
Message-Id: <163035607869.29257.17919151320982988457.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 11:31:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05b5fdb2a8f7f981b9b1aa77a6c4b810e19f01ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
