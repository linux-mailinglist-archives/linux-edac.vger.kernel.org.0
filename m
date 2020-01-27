Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A188814A913
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2020 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgA0RfG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jan 2020 12:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgA0RfG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:06 -0500
Subject: Re: [GIT PULL] RAS pile for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146505;
        bh=b9/Bm00Vd9nhuu6buL4my2Mo3wrRU8i+vANEpvHosO8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yP8aqEt//6oO9VURt+sA6y1AN2r3TmnM6FDlyBCpKX83N/0LBUeD69z9fx927PHQk
         1VALc9nlKtVrKIgMicw7s4LMndPKU3MkA+ulvhq9tduZc32fUOpAz7SekR7PuqxtMw
         KXAQit1AT4iXsfw6/aOi+JqGSWBjooOBoaxGmVlE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127111755.GC24228@zn.tnic>
References: <20200127111755.GC24228@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127111755.GC24228@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: 86e9f9d60eb5e0c5d99ddf6b79f4d308d6453bd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30f5a75640998900d995e099e060e920e72790b2
Message-Id: <158014650575.9177.11918923915378996339.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 12:17:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30f5a75640998900d995e099e060e920e72790b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
