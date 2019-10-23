Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD97E17CD
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbfJWKZN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 06:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391024AbfJWKZH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 06:25:07 -0400
Subject: Re: [GIT PULL] EDAC fix for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571826306;
        bh=b8F2m3SFJhpHjXyJAIps/x1YKc8omHwLdZOcjhr733U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xx5KqGRbPXcoqODN1UtA4yBkarSY/nO5QJE9Hy94+tZ1mc7OEbLDGe2PZKU6Ih2jE
         cAwvpZRIdv/N/O9FchDcS1XNUDDOXzJhZ94UI2Zv/EblwphjyLC+kXWGSsa/ShrSbS
         hPUOOJe5nkpoOn6DeARpT0SRiq12OPGTzk0pm10w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023073047.GD12272@zn.tnic>
References: <20191023073047.GD12272@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023073047.GD12272@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_urgent_for_5.4
X-PR-Tracked-Commit-Id: 1e72e673b9d102ff2e8333e74b3308d012ddf75b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e969c860d56345b2c2efd2bf2b6d8c716bdc1468
Message-Id: <157182630681.4124.17219799857806635866.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Oct 2019 10:25:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 09:30:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e969c860d56345b2c2efd2bf2b6d8c716bdc1468

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
