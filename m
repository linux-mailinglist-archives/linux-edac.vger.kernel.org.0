Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479E348A069
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jan 2022 20:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiAJTs1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jan 2022 14:48:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48152 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbiAJTs0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jan 2022 14:48:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47A3EB81072;
        Mon, 10 Jan 2022 19:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19CB7C36AEF;
        Mon, 10 Jan 2022 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641844104;
        bh=VkR+lfaG+6HQP+/InyiRUte5h9PRx5RScZ/cmPLo0Xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7ut8rMxnCBogVzLyh7BFFMd3EGAGL0fRpvOE39kn909qz8jg1P+zqntU/UrPLONG
         3WAfuFu9u6IA8YvmxcLuNs0HSOYl02I3UmcNbmRjEQHWn0ygbPfX15zk4Rclvphsmf
         5vE2olkkG65Qq4JxP2st7na5kP5n3pTEEtOQi74szRbRHbSQK3MuE7me+v2Km3elJh
         3WYgBNh8gBBugDFAMOEVE4zn2ry+gBlN/Lxa36cFXnN/nw6wGCLQLJy8IivnMsMyEJ
         PD9X619yljq8DlbwrV1OSQT1BCfhiGHNV7/0ucJikFsRAdqEGUc7C+HrS0CY54q9Ws
         Vjl0uwxhr3bEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 092AFF6078B;
        Mon, 10 Jan 2022 19:48:24 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ydv97EG//cs7Xo99@zn.tnic>
References: <Ydv97EG//cs7Xo99@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ydv97EG//cs7Xo99@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.17_rc1
X-PR-Tracked-Commit-Id: da0119a9123c73269657fc61f537223d6affef02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff8be964208e6b6f1341f0645857c67830a78379
Message-Id: <164184410402.23269.8008696798235347748.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 19:48:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:35:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff8be964208e6b6f1341f0645857c67830a78379

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
