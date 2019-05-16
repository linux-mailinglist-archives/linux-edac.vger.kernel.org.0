Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0B2038D
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 12:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEPKgC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 06:36:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfEPKgB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 06:36:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA572AE9F;
        Thu, 16 May 2019 10:36:00 +0000 (UTC)
Date:   Thu, 16 May 2019 12:35:53 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fixes for 5.2
Message-ID: <20190516103553.GA21457@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two EDAC fixes, as below.

Thx.

---
The following changes since commit 275b103a26e218b3d739e5ab15be6b40303a1428:

  Merge tag 'edac_for_5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2019-05-06 19:53:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fixes_for_5.2

for you to fetch changes up to 29a0c843973bc385918158c6976e4dbe891df969:

  EDAC/mc: Fix edac_mc_find() in case no device is found (2019-05-14 17:08:46 +0200)

----------------------------------------------------------------
* Do not build mpc85_edac as a module			(Michael Ellerman)

* Correct edac_mc_find()'s return value on error	(Robert Richter)

----------------------------------------------------------------
Michael Ellerman (1):
      EDAC/mpc85xx: Prevent building as a module

Robert Richter (1):
      EDAC/mc: Fix edac_mc_find() in case no device is found

 drivers/edac/Kconfig   |  4 ++--
 drivers/edac/edac_mc.c | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
