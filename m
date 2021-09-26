Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2088418AC6
	for <lists+linux-edac@lfdr.de>; Sun, 26 Sep 2021 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhIZTcg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 26 Sep 2021 15:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhIZTcg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 26 Sep 2021 15:32:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8F51460F46;
        Sun, 26 Sep 2021 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632684659;
        bh=q3mSpO5epEm4gwABRooQm7+SAuOL2TG90lVfOmeqpcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IhZsHA4Na53rat/9lQrwbjLsOkVX+yK4+4R1nnOghnznGsfJARNyEUD4slI622IZ5
         FfIrv8e+U7HW/CfTJeGZ7bsqHP+g1OK7Y7g5uJBYdr6QLLD4LrobIRz+4ae+HBKn8p
         ffbSZaW9A5fxuTyPy+syhb3dYg+0dpHXpPvHc1cjwOHH6iFKXH6MOWZXctdz9BlyRr
         eGXw0xxSM8NA+hadN6wDX5UPKgk5nnCekN0Vjlgh/sNSLh8OsZvBQVpeWqsxqiuhhQ
         StHWXzM0QwiOEWjsKBzms1HjnI5TKtRO2QvYSSVUaOHNRuJKustbjlVNKq/zr26dsg
         aPT53ww7oe6/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8532760A12;
        Sun, 26 Sep 2021 19:30:59 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fixes for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVC6ZS+Z3T0Ky87i@zn.tnic>
References: <YVC6ZS+Z3T0Ky87i@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVC6ZS+Z3T0Ky87i@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc3
X-PR-Tracked-Commit-Id: 54607282fae6148641a08d81a6e0953b541249c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 996148ee05d08ef5163cad99c33a7b5e844ac494
Message-Id: <163268465947.21680.1551934160178094239.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Sep 2021 19:30:59 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 26 Sep 2021 20:22:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/996148ee05d08ef5163cad99c33a7b5e844ac494

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
