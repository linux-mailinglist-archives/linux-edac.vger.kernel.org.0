Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AF1EAFAB
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jun 2020 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFATfN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Jun 2020 15:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbgFATfK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:10 -0400
Subject: Re: [GIT PULL] EDAC for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040109;
        bh=TKnLF50B+lrLerj74xVFVrjdxPs8SeorPl1Zc3zRuFY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cOOtJgWZaHoMc41VxkoB4sFtSqUyjPB+LRThTRGXZUob5ab7rD/MSwG+W/pSJKKpr
         JW0/pZGkMApSpEUcxAM1fP8p7Rk9GYhs6ShJDpSnBPAIh6HXtYIbV30KoaNd2M1Oaw
         eUi/jHzZRIb3IFD5L3Gl2O54JzdeNTYIQuuVJ8Do=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601095317.GB30795@zn.tnic>
References: <20200601095317.GB30795@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601095317.GB30795@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_updates_for_5.8
X-PR-Tracked-Commit-Id: 2a02ca0428cfe68cce600111acb4c6f7d85cf71f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b11dd54add63aa398c4b239d31b7f4477a4b859
Message-Id: <159104010983.18844.14542765433119826738.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:53:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b11dd54add63aa398c4b239d31b7f4477a4b859

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
