Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839A014A917
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2020 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgA0RfT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jan 2020 12:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgA0RfF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:05 -0500
Subject: Re: [GIT PULL] EDAC pile for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146505;
        bh=qhY0TFPNzUZOVx5iMguYgwRXr8GxK+aud/aGQTrte3A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZtezQYq91kE5k3AC0CnKvtE7i0VXrx/nMcdj7AO+oYv2l85sSTmI0GtWvTLC+9+nQ
         zE5Uwh7ZpXCWR2tKZ6VWUelnfBo9OBgKY60poo5VxgC2PgBxT8wNBhfJjAAzi25dX3
         n6JVrEYpqx6fGMr3qZPAZZLewDBRCLwIfEne7pFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127104139.GB24228@zn.tnic>
References: <20200127104139.GB24228@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127104139.GB24228@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.6
X-PR-Tracked-Commit-Id: 7e5d6cf35329c8b232a1e97114545c1745d79083
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b62061b82a6e6783bed5f9052326694ba1418bba
Message-Id: <158014650523.9177.12505761935117443546.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 11:41:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b62061b82a6e6783bed5f9052326694ba1418bba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
