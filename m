Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8529D430E85
	for <lists+linux-edac@lfdr.de>; Mon, 18 Oct 2021 06:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJREKl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Oct 2021 00:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJREKk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 718CD6101B;
        Mon, 18 Oct 2021 04:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530109;
        bh=dD/RN6DErXpnq9KPJ/vnGh8s9emXdGv8XWMH6TnC5Qs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ctNP/J1GBMX+cndomjA0dMmvlpSIdl2Y0bs3Ncd4qi5okNz9IWSoeW5Si/gjyiLa5
         SMOP4pNWWfWXRdYQ0kd8XJAPQ4B+3Bhjzij+nv7d8rfkhZN9YGPJZrPjyf2znXbeMx
         1Ytd3j4mBplUmqVvZKMcV0MRvo7AYgvwwak4/ukN+WB3U8H4MS1VzkLoeVQXqHUOZA
         bRQk8lPHwfatVyIe9RtZdQq4Xkr1Tz1o2Fa867YQHzTTiXNyAbh9W0bQc/zT59UiSl
         dzSW0XFArynckkKlkmR9tC7XhzdZuZ0VZhlFKdRAx3t+sqQRcXyFrpJrmGXpv+J9jZ
         ElFwOFaWqFHvw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6819D6095B;
        Mon, 18 Oct 2021 04:08:29 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fix for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv9Eb+ZYTtWfLSc@zn.tnic>
References: <YWv9Eb+ZYTtWfLSc@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv9Eb+ZYTtWfLSc@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc6
X-PR-Tracked-Commit-Id: d9b7748ffc45250b4d7bcf22404383229bc495f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f644750ccc02f5d513abf314a16bec5f70d13c40
Message-Id: <163453010942.24310.5503711549901004658.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:29 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:38:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f644750ccc02f5d513abf314a16bec5f70d13c40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
