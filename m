Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3009424EF48
	for <lists+linux-edac@lfdr.de>; Sun, 23 Aug 2020 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHWSji (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 23 Aug 2020 14:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHWSjY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:24 -0400
Subject: Re: [GIT PULL] EDAC urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207964;
        bh=09n9DPXyjeVOuJISvWRvida3UAVTg7gh8CDylNsGf4s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vNFDdXgN2fF64EuC7S/21i3CfTmwM8xM/5xDJXshWkpboxT23s0/ucjwJAWEmEdZB
         ZrIt4rxgvPYWXAg4fDwk9JpSHkN/8gjm+aMiWaEnarpZrMF66xIJwpFCrJoPGQuIQI
         8Tq7VHu1JUnGgw5f2QaJVsDlth02NqcqyhHB6Ils=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200823101203.GA27452@zn.tnic>
References: <20200823101203.GA27452@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200823101203.GA27452@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc2
X-PR-Tracked-Commit-Id: 45bc6098a3e279d8e391d22428396687562797e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9232cb79651c244f8679607b6e30c5230bcc967
Message-Id: <159820796431.12134.18041504030184472094.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 12:12:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9232cb79651c244f8679607b6e30c5230bcc967

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
