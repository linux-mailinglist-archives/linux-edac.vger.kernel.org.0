Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9A4BD13D
	for <lists+linux-edac@lfdr.de>; Sun, 20 Feb 2022 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbiBTUPX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 15:15:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiBTUPW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 15:15:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC414C42E;
        Sun, 20 Feb 2022 12:15:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55061B80DB6;
        Sun, 20 Feb 2022 20:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 219CCC340E8;
        Sun, 20 Feb 2022 20:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645388098;
        bh=vTvrVsvOELmsKXEboyBj9jxLeG/JSHr9FcsA1TYbJik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NAXVWWoWYV8fxx828t8VdASdvCeZQaGE+FH6Dz9EoBfeo9ZQRbZbJozf0RFcHhJ7M
         8LPmmQ7XXo4Or+3jQ3N8NOjHjnD+6swRJgxftM9vAImp2wcNLBPvRRFrlVXA0NjsWI
         6e3hmcUh3HWnivWxwMUVt2riNbUqioPje1dspL9HvOrFXNuUlgO4dLTeIgRnoxOtIJ
         ibhm6+g9pqQN8W8pfbQlz2lP8PwHLil0Gk54zJzooktpM7vwnhxzcPBsOy1weABKI1
         6rjOi70tHJsBzuhEko9CgY6OygPckZA8zz3O7wirvEAlIDAJWtOsTBrzTloYbRG3wT
         aGToFItR0iRiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10E2DE6D447;
        Sun, 20 Feb 2022 20:14:58 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fix for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhIq94B0MpYGrEm2@zn.tnic>
References: <YhIq94B0MpYGrEm2@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhIq94B0MpYGrEm2@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc5
X-PR-Tracked-Commit-Id: f8efca92ae509c25e0a4bd5d0a86decea4f0c41e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e8e752f705c2713005a3182c8444ef7b54f10aa
Message-Id: <164538809806.22885.16950927019152123970.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 20:14:58 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 20 Feb 2022 12:50:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e8e752f705c2713005a3182c8444ef7b54f10aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
