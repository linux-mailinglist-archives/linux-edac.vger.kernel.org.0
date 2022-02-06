Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9981F4AB14B
	for <lists+linux-edac@lfdr.de>; Sun,  6 Feb 2022 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiBFSij (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Feb 2022 13:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346625AbiBFSii (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Feb 2022 13:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC3C0401C4;
        Sun,  6 Feb 2022 10:38:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AB061216;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F8D5C340EF;
        Sun,  6 Feb 2022 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172716;
        bh=Wo2yBu/aTPpyMacSBuIn+0D0onIVmCmqqpZ0MuElrMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qTGAXI6YVRm4XoxFI/6o/v5Lp3t+s23umi+BacX1An/Rv8Eo5t4D52Bo+sbNitKI0
         ywhVMLkY8x5ngcWxXuOKkd7aQ4r9YmGpJkW6bgglk2MzeQZ05QxiUJ9roU0EK82Rec
         0/fFBof7wfvmIBvBjSMq7aDYuI5nD5v79xGA271YPz/BY4VzLzXzVVm0BkbWot7MT0
         qNFdjoHg2Y2iOutLuo0c3+8J6H/RFH9/cGSITbBoX8kDFkbzR3qfgeF90PEej2hpci
         dNDS5FsUqZ4JGfQSVARikCJ0BF9oCBqmKxN0rW3QU8XFIXflrB7Tuo42rQ25esHLmU
         euvu/3TO/ZL6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E756C6D4EA;
        Sun,  6 Feb 2022 18:38:36 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC fixes for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf+1ehVTFHkihPfd@zn.tnic>
References: <Yf+1ehVTFHkihPfd@zn.tnic>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yf+1ehVTFHkihPfd@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc3
X-PR-Tracked-Commit-Id: dfd0dfb9a7cc04acf93435b440dd34c2ca7b4424
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 898b5841ae37c8a7297214b7fd001d4c0f6fd89d
Message-Id: <164417271644.9246.17463149362704352064.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:36 +0000
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

The pull request you sent on Sun, 6 Feb 2022 12:48:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/898b5841ae37c8a7297214b7fd001d4c0f6fd89d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
