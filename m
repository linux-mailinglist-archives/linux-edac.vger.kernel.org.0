Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E564ABB0
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiLLXp3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 18:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiLLXp0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 18:45:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09D17886;
        Mon, 12 Dec 2022 15:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9059612A3;
        Mon, 12 Dec 2022 23:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56ED5C433EF;
        Mon, 12 Dec 2022 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888724;
        bh=TH2ET57//OZ7iPswpnyZ/G+9HyjRITAoqBi4uzrG2ks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RbIgrPBcZph8h0G6rmYXrbnUPtiIyf8qunbp81jkihyIm0hOsR3Dq+bRfYNdXhEUo
         iLf9nR1UJ3tjn/HfpGzeSs8ZeH95rcoNsZeQR4302vKzv+13jcmV0RkKC9WDsnNFgn
         esqYHHQEAN1RFVeaGMAzJJZ5j0jCKxyC994qaiaeMmUPTxocYL3udDrM2Ir/fYswmO
         Y0TEQrUGGV2aG/R9x/S85eLKhjsd78DYvC5kaBuzMYUy6UatOgK80MvLkRpuJvv0y5
         DiJ4PKk9zkivnh72AE1eipSqCajZRb6cDB8QfNmGGuAPZx7QFsBH99ZqtmvPHfyCRO
         rAwtxedj3Oc6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4715EC00445;
        Mon, 12 Dec 2022 23:45:24 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5dAJyR9meVleZTm@zn.tnic>
References: <Y5dAJyR9meVleZTm@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5dAJyR9meVleZTm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_6.2
X-PR-Tracked-Commit-Id: 3919430fe93bcfad5e34cdbb4d81cd17b3bbd27a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7adcadb98405cb4ef56b2518164026c1069d8669
Message-Id: <167088872428.9522.8137490894324955072.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:24 +0000
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

The pull request you sent on Mon, 12 Dec 2022 15:52:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7adcadb98405cb4ef56b2518164026c1069d8669

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
