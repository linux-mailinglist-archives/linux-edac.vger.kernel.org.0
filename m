Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA866B13E
	for <lists+linux-edac@lfdr.de>; Sun, 15 Jan 2023 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjAONZW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Jan 2023 08:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjAONZV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 15 Jan 2023 08:25:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178C81258E;
        Sun, 15 Jan 2023 05:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D8E60CEF;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B786C433EF;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673789120;
        bh=i2NAbCkk1Kfs010QYlB1Av43LOI0kANFVJnXeapcK7Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GI1A0BAPKt7Hn/zqAYsrNr0QNIJo7Pn3BnJ8bj758lK7xQSHF7Obq+tc9kpsV1N74
         /Hi0RsrxKsiMJ66zB5C2s/5Ffqb3aHpTDYE1xjtyaw3KyI5fiKYcVvbIGqlSwe3ykS
         zVdaEnwR2maOWRuGsc9xX8w1TAlAeoizksWS8LvIzVTLd/L8FIbNkP0nXZh3Rk9DsH
         jAsZMWh7Z/VmJ+gPAHDHBZ6Rs/mcH0SD++/iXzCH1JmRKTU07pOiW7ahFt3zlmvzHR
         oeQfocGkS4X726J1YzI25G5RYndGTfh2JZo7WihQF3OM6aCuiiMjGJpJgu+Y4aL36+
         FiJdqmzOjY9sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06B82C395D4;
        Sun, 15 Jan 2023 13:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8PlBfg2sdjP1OIb@zn.tnic>
References: <Y8PlBfg2sdjP1OIb@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8PlBfg2sdjP1OIb@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc4
X-PR-Tracked-Commit-Id: e7a293658c20a7945014570e1921bf7d25d68a36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8aa9761223af6a075f9904d035b57cef9b26aaab
Message-Id: <167378912002.21615.16135528505118886694.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Jan 2023 13:25:20 +0000
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

The pull request you sent on Sun, 15 Jan 2023 12:35:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8aa9761223af6a075f9904d035b57cef9b26aaab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
