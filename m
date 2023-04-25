Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557146EE73D
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjDYSA7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjDYSA5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 14:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C7BCC0B;
        Tue, 25 Apr 2023 11:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45BC63087;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12461C433D2;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445652;
        bh=uVuhvGul3IKDwcvHaWZOCaZpLPNQI6/HPw5gQCge+5g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tzyf8+IYmjZEce3mg/VCzgvPP0CnacA4ohsQEttWNhyXES6iSpZnx5tXnKwIOFnzq
         rSIjBF0JqPiJ1J5xX75JDH/EZxviPsiMea/0sEsXxELKbqwKuIW5egHPhiVP46MDCY
         9FCqQi5Z3t5sxqneAq67ChgbPLUfMbutU6t+kdGtQPxrmfOXiEeLV2rhEzcc+8lp5I
         SoLKGIeR88mmP8c7kptUe4klQBVZBVNTFO008pICFJ+qS25dGO41KiMhKr4rPtiX27
         pE6vRxHS5MP542oLaS5x+j3KkKhsBh6P/OigX25JQiAP4Cy8+4zmjoBO/aa05Z8Ti+
         OiJEgSB67674g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00105E5FFC5;
        Tue, 25 Apr 2023 18:00:51 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.4
X-PR-Tracked-Commit-Id: ce8ac91130b96f651cf6b5245668dfa4969c9c42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e94ee641f9cef2502adfe5e0c264b271420c7ab5
Message-Id: <168244565199.10431.11416081995881321602.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:51 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 09:28:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e94ee641f9cef2502adfe5e0c264b271420c7ab5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
