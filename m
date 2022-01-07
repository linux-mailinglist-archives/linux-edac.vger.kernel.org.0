Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B177487E4D
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jan 2022 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiAGVcz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jan 2022 16:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiAGVcz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Jan 2022 16:32:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E017C061574;
        Fri,  7 Jan 2022 13:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDCBFB82297;
        Fri,  7 Jan 2022 21:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A739C36AE9;
        Fri,  7 Jan 2022 21:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641591172;
        bh=JO6uJvDbybmnUUNjbmpcBKsNix7QQYv8ap58zDBS8GI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vOYrycYYnNW+QD3F6KEENhMGJmezlpGPV9pgTuAUSgmxzRstyJrz/HoLIvasaImL1
         bgN6rBU8Z7VQTvlucno+2xywagJSDCu8uIygdWNKjGZP+F3I2N7u1oAI4qqB9bzw8d
         bTo9l2TtSG+NAQZ2cKE/9ELsaXWScOlH32y8eRvL63WjlrrlNAMnnV/ALTIcV40yrr
         IVb+un8cDuzTzQ5S6s8p7O7DOdtEZsKnBlI4Zs1LbxVmMIY2zIgnA6nbcwsDfxWCtr
         t2pyiHPoqQtRxxAbxuSF0zW5MZ5PDhI2Cbt3/Lo7GRnZQB13c5w0T+7IyhtRS4QybN
         9NOHU0VWE5FLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89CDBF79408;
        Fri,  7 Jan 2022 21:32:52 +0000 (UTC)
Subject: Re: [GIT PULL] One late urgent EDAC driver fix from the RAS tree
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdigwC6Od5wQCyFF@agluck-desk2.amr.corp.intel.com>
References: <YdigwC6Od5wQCyFF@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdigwC6Od5wQCyFF@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.16
X-PR-Tracked-Commit-Id: c370baa328022cbd46c59c821d1b467a97f047be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 494603e06b3c8c0b29086b72f0bc41abf102fe0d
Message-Id: <164159117255.9111.17755400595406583152.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jan 2022 21:32:52 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 12:21:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/494603e06b3c8c0b29086b72f0bc41abf102fe0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
