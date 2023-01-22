Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95F677247
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jan 2023 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAVUUm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Jan 2023 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjAVUUl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 22 Jan 2023 15:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956615574;
        Sun, 22 Jan 2023 12:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4238AB80B62;
        Sun, 22 Jan 2023 20:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E301DC433D2;
        Sun, 22 Jan 2023 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674418837;
        bh=szpOtfLDjW+XlpGdtQ/LxvgDMq9REnopVes7COV2Txc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EXdm+90ceDAVC6qzdFu9ml9+q2iaSi87M+JrBhjSJ3ebeowJpia2aal3mIgnvfyHV
         BcOaku4QyFfBgWpSboGKjil7ztRqDifOVV58FRwrH19XHVwHlR/zomlzxbu8MwuUEO
         VNf9R/CCX+Vbhv+JCnSxtEP8KdcCDva+GPxOFaXHkqhZ5Hhd4+TE+nEihdPmaqUfp/
         QMq9glj9f3vZaYuxfBTVlC7dHRbHvLNTf9RTHsyXPbUzXskpcBYPLjfKrJIlvIrx2C
         wY1dyiCxl0qgpoVZrjytTtSEF/G4XTpKEM9oXWYDv7Elh5YeWffueNFmtj8kFY7SqP
         lJNLDRdmtyY1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEE13C04E35;
        Sun, 22 Jan 2023 20:20:37 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y80mm14dxcMzxrLW@zn.tnic>
References: <Y80mm14dxcMzxrLW@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y80mm14dxcMzxrLW@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc6
X-PR-Tracked-Commit-Id: 977c6ba624f24ae20cf0faee871257a39348d4a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab2f408731cc7e03ef2e5dc7dada649220e4dcd2
Message-Id: <167441883783.2461.9069114770231647687.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Jan 2023 20:20:37 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 22 Jan 2023 13:05:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab2f408731cc7e03ef2e5dc7dada649220e4dcd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
