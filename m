Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30453212D
	for <lists+linux-edac@lfdr.de>; Tue, 24 May 2022 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiEXCvY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 May 2022 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiEXCvS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 May 2022 22:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D231A3B9;
        Mon, 23 May 2022 19:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997AB61223;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08CDEC385A9;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=GeIS+3QMgxpUci60FIASW934eMl7GiWGeQtqmA97e0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cgQDT4XeAifjy90KkGGhDp4Kn9jqFuCSo2y3vTg4pU7+0eYYiHQwZJJy1aL/MSevj
         unsTp5yGDBjbmkxKcFxdMa960TsxaS19NctH9E7zGexXPRbmiZvmQSNor1HcLTnSwu
         h2r4b6DmN3TaGpa6MEAoDhcHGo81PabkFn1sg5qdDEhVcQotkV2ZZQW08lpolzZW2A
         MCByQZlkgnksx4xj6MbY0ZKA3uokuK2J0aawgI4i2uV53joOHd/ur3AlU9SuZbCfDd
         7dIiSDpYiV/ResI+dAD3VEnJkJqUppqMWZY8yYPg8iTlAnlL34RTXxexI3r0QtppHd
         Q/CicGQm8vByQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC2C6EAC081;
        Tue, 24 May 2022 02:51:14 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YotQLlwVatMzp6Ow@zn.tnic>
References: <YotQLlwVatMzp6Ow@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YotQLlwVatMzp6Ow@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.19_rc1
X-PR-Tracked-Commit-Id: be80a1ca5119c5d31b6019d5e6dc6d9123bda959
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0be3ff0ccbfacb1bcc56e2ec9c1c5d92cf9a64d3
Message-Id: <165336067495.14181.3990744775793624869.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 11:13:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0be3ff0ccbfacb1bcc56e2ec9c1c5d92cf9a64d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
