Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40AD3B887E
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhF3ShZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 14:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhF3ShZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 14:37:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DD0F461419;
        Wed, 30 Jun 2021 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078095;
        bh=o7HWFBp8JYLf/BFqmOzk6+xx+xon3y637YTwer/C800=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M8rIc/WiM5Z3dKLaLSRul49OfyxMr9JF0kKsPc8SNWB0rkOy3gOSZm4cZrG3xPwzL
         482FaStSQLW/QCLBdhcsxNcSdwzO+AyONFu3+JpGC/T3gRv3HBQPc3SI8A2bvh0OZ1
         6uLscZ3BofyuCZBvCiOrLC0F3gm5ah51EMWEW21d2KxzbAPybBjHUIx3Nn5knUEKBN
         Fzs7oG/aJaO7SC7ZQSQez22A0VlFnX3FxEkKPdozKjWMH8iL7NJkOFNCsrH5Jz7TgQ
         BwRis1/TTQTGsd726PdNWRAal1mRrd8dxzpqilvr1zE06y/1Me+ajc0Ju/xHlFeqQe
         ovPS9VLDZGJOQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CBE7D60A17;
        Wed, 30 Jun 2021 18:34:55 +0000 (UTC)
Subject: Re: [GIT PULL] ras/edac changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629234446.GA1239895@agluck-desk2.amr.corp.intel.com>
References: <20210629234446.GA1239895@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629234446.GA1239895@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.14
X-PR-Tracked-Commit-Id: 0a9ece9ba154dd6205709108180952c55e630833
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b5e35ce075817bc36d7c581b22853be984e5b41
Message-Id: <162507809577.10377.5016426522118551443.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 18:34:55 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 16:44:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b5e35ce075817bc36d7c581b22853be984e5b41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
