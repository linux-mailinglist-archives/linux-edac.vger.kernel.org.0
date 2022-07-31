Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD993586002
	for <lists+linux-edac@lfdr.de>; Sun, 31 Jul 2022 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiGaQzu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 31 Jul 2022 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiGaQzt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 31 Jul 2022 12:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BF6472;
        Sun, 31 Jul 2022 09:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F3AEB80DB3;
        Sun, 31 Jul 2022 16:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0FBC433C1;
        Sun, 31 Jul 2022 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286546;
        bh=52xgJ0fYvA74FCngjrlN+Kb5uPrOE3AB0WPM27/0kUE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DRmhKvRvXwUB0qRwKvKuI298yVHXyuPEH++ed+zJLIemICSTjq2oMb0TCP14Auk00
         5KB0utn+w4JSTVge6UQf4g98l4nV3y4tIrU51u7tj1/cZig5PyLqzcBrVm+xntkJ4c
         lDiydDFA1vmnZFPUWHTU+T+CQ2D3hERZMqfVS/6X6TOyFqwi42XyFVypR459l5gbN1
         9ZyCX/Y7Jd4RR45eBUfNdKeaPvN1yNKlPOx9r+f8OIOzNH5CFgQv5T3KNG8+Nbdp5V
         aCg9zf8SivhPEXf4lkenmGGxWigzl57VSnJOE8/jrxQT2NqEHx6Blq5U78z0MWR91q
         bAJPW9ngWZlog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A8DEC43142;
        Sun, 31 Jul 2022 16:55:46 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuZOAlAdsg9i1YLt@zn.tnic>
References: <YuZOAlAdsg9i1YLt@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuZOAlAdsg9i1YLt@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.19
X-PR-Tracked-Commit-Id: 5e2805d5379619c4a2e3ae4994e73b36439f4bad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd2715b7929bcaf6e38d13ac512e0a9bba8df10d
Message-Id: <165928654603.8632.10369750834891343890.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jul 2022 16:55:46 +0000
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

The pull request you sent on Sun, 31 Jul 2022 11:40:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd2715b7929bcaf6e38d13ac512e0a9bba8df10d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
