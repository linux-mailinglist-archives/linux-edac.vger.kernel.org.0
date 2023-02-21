Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583B69E5E2
	for <lists+linux-edac@lfdr.de>; Tue, 21 Feb 2023 18:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBURYv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Feb 2023 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjBURYp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Feb 2023 12:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25604728B;
        Tue, 21 Feb 2023 09:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B380061158;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26033C433D2;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000283;
        bh=zEazf+VbCzG+CDO1J2YJlktuJ6Ydxs1YM7+UI1g/Tm8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IAnBSRx9mA8GIpii5Ezyc/gjkPwBgUh1xrAh+fcqAA/tlZJdBRiuPFCrFgGAo27hR
         ZKc++rNf457xCl6TiuwNv/Jb+KagdZmWZl1UCUfCzO1BetKuINrcUGqnyn25L1CrNB
         XXeMUx7yOIC7ibP4PWl57dfFre+L5I28Eg9U4gJUTUcmTHGiYK33XPBo38n5a29Uo7
         lkJfZ/exLYZgerT51tfotzwLJUgLJWhX/Ape+aAXA2NCzbasJP+OVpzm7xdhLhHKFe
         mNNT+Tci+0SnnqnLYPQvvVuqtIN9H+1z58D5EoF+eNaOd9b6/4GPa9Bxc8MzAm9SFr
         xZ0TTImda5Zkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1019DC43158;
        Tue, 21 Feb 2023 17:24:43 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/Dn5bXwGxiDh8RI@zn.tnic>
References: <Y/Dn5bXwGxiDh8RI@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Dn5bXwGxiDh8RI@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.3
X-PR-Tracked-Commit-Id: 28980db94742f9f2fb0f68ea35f2171b38007bae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9de5ce8a5ec8f97c9468244fd85ff1a10363b60
Message-Id: <167700028305.32027.2642909732954967762.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:43 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sat, 18 Feb 2023 15:59:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9de5ce8a5ec8f97c9468244fd85ff1a10363b60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
