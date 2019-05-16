Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4420F33
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEPTZY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 15:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfEPTZX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 15:25:23 -0400
Subject: Re: [GIT PULL] EDAC fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558034722;
        bh=AbWCR0LR5Hk20spLB4lvhOuzYd1dVFyMUjw/0wQvX6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kUpiG3u6bmse4IQ6w0ESZh5sPGcmBCFMDx2bj1zKCFCA3MIUOf9OKJXamNXUY68iL
         xJRq/c0sSH6udoKlXlw+jVzffgcYyy4NmSRIq7B9HOWH4jD+VOTzBMESp/ZswEcq0P
         93Y7efOtHfrUkf9JA2LV0GMpIacERCyqZMPw19LA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516103553.GA21457@zn.tnic>
References: <20190516103553.GA21457@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516103553.GA21457@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
 tags/edac_fixes_for_5.2
X-PR-Tracked-Commit-Id: 29a0c843973bc385918158c6976e4dbe891df969
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11b1177399b69528f75ad7594ce93c957d4d16b6
Message-Id: <155803472285.27329.6968680898363630017.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 19:25:22 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 12:35:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fixes_for_5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11b1177399b69528f75ad7594ce93c957d4d16b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
