Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731E50D4DE
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiDXTim (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 24 Apr 2022 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiDXTij (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 24 Apr 2022 15:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE75BF48;
        Sun, 24 Apr 2022 12:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2B460EF6;
        Sun, 24 Apr 2022 19:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 801DEC385AE;
        Sun, 24 Apr 2022 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650828937;
        bh=wFinVtndMfPomHV0+0abt1jIqt93tYNbvD6uwHeKhM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jA373gT5dKKX/WpUuD7IEbxiPbW4U2kY95xc/wEGzPbMNDPELhdLRh//pjP6Q7AwA
         Yv3qNs8ibLxPhQGOz8IlIYI9JiNfzXR+OPIpIlkQArnemI71edk5I4/1APaYoDm+5Q
         mVldHm0Mu6Y920TQXDQMCpLCjBch+9iAQO90K30kygEvY/N19bZAXYyf2W/DoAQwQm
         nhM/qoLFglhExVGtDsMO4V7hzWYLIGM4PRuv/aqZiY0+N7ctDQHCIRTQAn+c4s8n8S
         2K/E/cJj7cXNyrHCbTEqjlZSuqtgNH/zFZb3Dh45svfWx8/b0s9pxdUDlXR0fovBft
         +6fIYxqH/RVCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 691B8E8DBDA;
        Sun, 24 Apr 2022 19:35:37 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmUcwHD0QLywciqo@zn.tnic>
References: <YmUcwHD0QLywciqo@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmUcwHD0QLywciqo@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.18_rc4
X-PR-Tracked-Commit-Id: e2932d1f6f055b2af2114c7e64a26dc1b5593d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b877ca4dc816aeee1ac2e27eae3f2ed42179d707
Message-Id: <165082893742.1098.16164923269814704344.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Apr 2022 19:35:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 24 Apr 2022 11:47:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.18_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b877ca4dc816aeee1ac2e27eae3f2ed42179d707

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
