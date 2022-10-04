Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68B5F4888
	for <lists+linux-edac@lfdr.de>; Tue,  4 Oct 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJDReO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Oct 2022 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJDReH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Oct 2022 13:34:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A655E67F;
        Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D28FB808CF;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64FFDC433D6;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904844;
        bh=OQN95weSY/YFmDiwGQZZZUdIQ8PpQdC6jI5I0iTppJw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kq79/b+51LCPy3cqM3pBODv72d0HNdTkHSANz5+LcAeEizjEgTucF8dGKKjP7mKE1
         jEHsbsAGS/menRv17C+lKi6JaNRPfCqdb1VQAhKllH/QBcfVY1a3uNUbxKkTUcK7xw
         xT/e9Zzf6+As3RrHKcrFfSPhjMphjRzXey/xZwj6pG4QOltaicFmkNQxTs9pU8475T
         I2sgY9R4TipWbgBn4UIpNhUhjFPumxgNbd6NiE7WuZk0EuLKZ8ELQv+HTjz03eb/o/
         Evb1ecfb3o1UoYWPyYIoVmWPXJDkYp0yjPeqC5j0bNL3Jf1HnTpRj4yXS4t3eaIiiA
         JermXM8xXwAkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 553D0E21ED6;
        Tue,  4 Oct 2022 17:34:04 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzvqtD2dVN9YPI1K@zn.tnic>
References: <YzvqtD2dVN9YPI1K@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzvqtD2dVN9YPI1K@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.1
X-PR-Tracked-Commit-Id: c257795609e9c9f063c92a6c7ea2e798417700c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf7676251b49cc4a97572da7e10f52b97cf65c75
Message-Id: <166490484434.22164.4621633068074973875.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:04 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Tue, 4 Oct 2022 10:11:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf7676251b49cc4a97572da7e10f52b97cf65c75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
