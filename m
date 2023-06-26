Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00173EED6
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFZWyF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 18:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjFZWyD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 18:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC71B1;
        Mon, 26 Jun 2023 15:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3079560F9B;
        Mon, 26 Jun 2023 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93F25C433C8;
        Mon, 26 Jun 2023 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820041;
        bh=7NrI+R0CJ53BqUcNv8qwUmv+sivwME0iGAI+yWgXV58=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EWwxXCdpglYoaPLB4Zvbt5ymq8koYOnjuKRblCPmqMNfeBPZXAAeYW8U0RgY3/O4x
         qMZUo9gD8Ka1jGVE5jOXfgiQduRzNOC1+t5uyClrp5+dAUfIMfkW04DrIq1+eFcJ4a
         rtKyV73cSrf+6lxNOBr0jt5doODMaAHJLjeAvgq7DJnMlAhtRH1vuYGlSY2bfMFyH4
         2oiErKoS2LbNf/xHVn+PBHJUw7RY1vT2pD61I4VM854ZcJC1RTzly33BuhNO+2nVdG
         bP+xuWTdIR2i8RiUn+Nifg33OBL8UMZm+4BiuLRPs2hLeDCpn9CletyEXJLvD6wH0h
         kKBl/DeXqtJ1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 819A1C43170;
        Mon, 26 Jun 2023 22:54:01 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626114842.GAZJl7GsleaEc2+cU1@fat_crate.local>
References: <20230626114842.GAZJl7GsleaEc2+cU1@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626114842.GAZJl7GsleaEc2+cU1@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.5
X-PR-Tracked-Commit-Id: 852667c317ae23f366cfaade3b9269b1943888dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5ce2f196fb9ab35fe18dcfd2bc17883db7bbe33
Message-Id: <168782004152.10634.6649441276896881332.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:01 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 13:48:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5ce2f196fb9ab35fe18dcfd2bc17883db7bbe33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
